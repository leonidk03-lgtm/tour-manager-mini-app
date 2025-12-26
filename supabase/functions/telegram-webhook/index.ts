import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

interface TelegramUser {
  id: number;
  first_name: string;
  last_name?: string;
  username?: string;
}

interface TelegramMessage {
  message_id: number;
  from: TelegramUser;
  chat: {
    id: number;
    type: string;
  };
  text?: string;
}

interface TelegramCallbackQuery {
  id: string;
  from: TelegramUser;
  message?: TelegramMessage;
  data?: string;
}

interface TelegramUpdate {
  update_id: number;
  message?: TelegramMessage;
  callback_query?: TelegramCallbackQuery;
}

interface InlineKeyboardButton {
  text: string;
  callback_data?: string;
  url?: string;
  web_app?: { url: string };
}

interface InlineKeyboardMarkup {
  inline_keyboard: InlineKeyboardButton[][];
}

const ORDER_STATUS_LABELS: Record<string, string> = {
  new: "Новый",
  issued: "Выдан",
  returned: "Возвращён",
  completed: "Завершён",
  cancelled: "Отменён",
};

const ORDER_STATUS_EMOJI: Record<string, string> = {
  new: "📋",
  issued: "📦",
  returned: "✅",
  completed: "🏁",
  cancelled: "❌",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    const update: TelegramUpdate = await req.json();
    
    // Handle callback queries (inline button clicks)
    if (update.callback_query) {
      await handleCallbackQuery(supabaseClient, update.callback_query);
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Handle regular messages
    if (!update.message?.text) {
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const text = update.message.text;
    const chatId = update.message.chat.id.toString();
    const userName = update.message.from.first_name + (update.message.from.last_name ? ` ${update.message.from.last_name}` : "");

    // Handle /start with invite code
    if (text.startsWith("/start ")) {
      const inviteCode = text.replace("/start ", "").trim();
      await handleInviteCode(supabaseClient, chatId, inviteCode, userName);
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Handle /start without code - check if already connected
    if (text === "/start") {
      await handleStart(supabaseClient, chatId, userName);
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Handle /menu command
    if (text === "/menu") {
      const client = await getClientByChatId(supabaseClient, chatId);
      if (client) {
        await sendMainMenu(supabaseClient, chatId, client.name);
      } else {
        await sendTelegramMessage(
          supabaseClient,
          chatId,
          "Вы не подключены к системе. Используйте персональную ссылку-приглашение от вашего менеджера."
        );
      }
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Handle /help command
    if (text === "/help") {
      await sendHelpMessage(supabaseClient, chatId);
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Handle /orders command
    if (text === "/orders") {
      const client = await getClientByChatId(supabaseClient, chatId);
      if (client) {
        await sendOrdersList(supabaseClient, chatId, client.id, 0);
      } else {
        await sendTelegramMessage(
          supabaseClient,
          chatId,
          "Вы не подключены к системе. Используйте персональную ссылку-приглашение от вашего менеджера."
        );
      }
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Unknown command or text
    const client = await getClientByChatId(supabaseClient, chatId);
    if (client) {
      await sendMainMenu(supabaseClient, chatId, client.name);
    } else {
      await sendTelegramMessage(
        supabaseClient,
        chatId,
        "Для подключения уведомлений используйте персональную ссылку-приглашение от вашего менеджера."
      );
    }

    return new Response(JSON.stringify({ ok: true }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (error) {
    console.error("Webhook error:", error);
    return new Response(
      JSON.stringify({ ok: false, error: error.message || "Internal server error" }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 500 }
    );
  }
});

async function handleCallbackQuery(supabaseClient: any, callbackQuery: TelegramCallbackQuery) {
  const chatId = callbackQuery.message?.chat.id.toString();
  const data = callbackQuery.data;
  const callbackQueryId = callbackQuery.id;

  if (!chatId || !data) {
    await answerCallbackQuery(supabaseClient, callbackQueryId);
    return;
  }

  const client = await getClientByChatId(supabaseClient, chatId);
  
  if (!client) {
    await answerCallbackQuery(supabaseClient, callbackQueryId, "Вы не подключены к системе");
    return;
  }

  // Parse callback data
  const [action, ...params] = data.split(":");

  switch (action) {
    case "menu":
      await sendMainMenu(supabaseClient, chatId, client.name);
      await answerCallbackQuery(supabaseClient, callbackQueryId);
      break;

    case "orders":
      const offset = Math.max(0, parseInt(params[0] || "0"));
      await sendOrdersList(supabaseClient, chatId, client.id, offset);
      await answerCallbackQuery(supabaseClient, callbackQueryId);
      break;

    case "order":
      const orderId = params[0];
      await sendOrderDetails(supabaseClient, chatId, orderId, client.id);
      await answerCallbackQuery(supabaseClient, callbackQueryId);
      break;

    case "active_orders":
      await sendActiveOrders(supabaseClient, chatId, client.id);
      await answerCallbackQuery(supabaseClient, callbackQueryId);
      break;

    case "history":
      const historyOffset = Math.max(0, parseInt(params[0] || "0"));
      await sendOrderHistory(supabaseClient, chatId, client.id, historyOffset);
      await answerCallbackQuery(supabaseClient, callbackQueryId);
      break;

    case "new_order":
      await sendNewOrderInfo(supabaseClient, chatId);
      await answerCallbackQuery(supabaseClient, callbackQueryId);
      break;

    case "help":
      await sendHelpMessage(supabaseClient, chatId);
      await answerCallbackQuery(supabaseClient, callbackQueryId);
      break;

    default:
      await answerCallbackQuery(supabaseClient, callbackQueryId, "Неизвестная команда");
  }
}

async function handleInviteCode(supabaseClient: any, chatId: string, inviteCode: string, userName: string) {
  if (!inviteCode) {
    await sendTelegramMessage(supabaseClient, chatId, "Код приглашения не указан.");
    return;
  }

  // Check clients first
  const { data: client } = await supabaseClient
    .from("rental_clients")
    .select("id, name, telegram_invite_code, invite_code_used, invite_code_expires_at")
    .eq("telegram_invite_code", inviteCode)
    .maybeSingle();

  if (client) {
    if (client.invite_code_used) {
      await sendTelegramMessage(supabaseClient, chatId, "Эта ссылка уже была использована.");
      return;
    }

    if (client.invite_code_expires_at && new Date(client.invite_code_expires_at) < new Date()) {
      await sendTelegramMessage(supabaseClient, chatId, "Срок действия ссылки истёк. Запросите новую ссылку.");
      return;
    }

    await supabaseClient
      .from("rental_clients")
      .update({
        telegram_chat_id: chatId,
        invite_code_used: true,
      })
      .eq("id", client.id);

    // Send welcome message with menu
    await sendWelcomeMessage(supabaseClient, chatId, client.name);
    return;
  }

  // Check guides
  const { data: guide } = await supabaseClient
    .from("tour_guides")
    .select("id, name, telegram_invite_code, invite_code_used, invite_code_expires_at")
    .eq("telegram_invite_code", inviteCode)
    .maybeSingle();

  if (guide) {
    if (guide.invite_code_used) {
      await sendTelegramMessage(supabaseClient, chatId, "Эта ссылка уже была использована.");
      return;
    }

    if (guide.invite_code_expires_at && new Date(guide.invite_code_expires_at) < new Date()) {
      await sendTelegramMessage(supabaseClient, chatId, "Срок действия ссылки истёк. Запросите новую ссылку.");
      return;
    }

    await supabaseClient
      .from("tour_guides")
      .update({
        telegram_chat_id: chatId,
        invite_code_used: true,
      })
      .eq("id", guide.id);

    await sendTelegramMessage(
      supabaseClient,
      chatId,
      `Добро пожаловать, ${guide.name}!\n\nВы успешно подключены к уведомлениям TourManager как экскурсовод.\n\nВы будете получать уведомления о назначенных вам заказах.`
    );
    return;
  }

  await sendTelegramMessage(supabaseClient, chatId, "Код приглашения не найден или недействителен.");
}

async function handleStart(supabaseClient: any, chatId: string, userName: string) {
  const client = await getClientByChatId(supabaseClient, chatId);
  
  if (client) {
    await sendWelcomeMessage(supabaseClient, chatId, client.name);
  } else {
    await sendTelegramMessage(
      supabaseClient,
      chatId,
      "Добро пожаловать в TourManager Bot!\n\nДля подключения уведомлений используйте персональную ссылку-приглашение от вашего менеджера."
    );
  }
}

async function sendWelcomeMessage(supabaseClient: any, chatId: string, clientName: string) {
  const keyboard: InlineKeyboardMarkup = {
    inline_keyboard: [
      [
        { text: "📋 Мои заказы", callback_data: "active_orders" },
        { text: "📚 История", callback_data: "history:0" },
      ],
      [
        { text: "➕ Новый заказ", callback_data: "new_order" },
      ],
      [
        { text: "❓ Помощь", callback_data: "help" },
      ],
    ],
  };

  await sendTelegramMessageWithKeyboard(
    supabaseClient,
    chatId,
    `Добро пожаловать, ${clientName}!\n\nВы подключены к TourManager. Здесь вы можете:\n\n• Просматривать свои заказы\n• Отслеживать статус оборудования\n• Создавать новые заказы\n\nВыберите действие:`,
    keyboard
  );
}

async function sendMainMenu(supabaseClient: any, chatId: string, clientName: string) {
  const keyboard: InlineKeyboardMarkup = {
    inline_keyboard: [
      [
        { text: "📋 Активные заказы", callback_data: "active_orders" },
        { text: "📚 История", callback_data: "history:0" },
      ],
      [
        { text: "➕ Новый заказ", callback_data: "new_order" },
      ],
      [
        { text: "❓ Помощь", callback_data: "help" },
      ],
    ],
  };

  await sendTelegramMessageWithKeyboard(
    supabaseClient,
    chatId,
    `${clientName}, выберите действие:`,
    keyboard
  );
}

async function sendActiveOrders(supabaseClient: any, chatId: string, clientId: string) {
  const { data: orders, error } = await supabaseClient
    .from("rental_orders")
    .select("id, order_number, status, start_date, end_date, days_count, total_price, kit_count")
    .eq("client_id", clientId)
    .in("status", ["new", "issued"])
    .order("start_date", { ascending: true })
    .limit(10);

  if (error || !orders || orders.length === 0) {
    const keyboard: InlineKeyboardMarkup = {
      inline_keyboard: [
        [{ text: "➕ Создать заказ", callback_data: "new_order" }],
        [{ text: "◀️ Назад в меню", callback_data: "menu" }],
      ],
    };

    await sendTelegramMessageWithKeyboard(
      supabaseClient,
      chatId,
      "У вас нет активных заказов.",
      keyboard
    );
    return;
  }

  let message = "📋 <b>Ваши активные заказы:</b>\n\n";
  const buttons: InlineKeyboardButton[][] = [];

  for (const order of orders) {
    const statusEmoji = ORDER_STATUS_EMOJI[order.status] || "📋";
    const statusLabel = ORDER_STATUS_LABELS[order.status] || order.status;
    const startDate = formatDate(order.start_date);
    const endDate = formatDate(order.end_date);

    message += `${statusEmoji} <b>Заказ #${order.order_number}</b>\n`;
    message += `Статус: ${statusLabel}\n`;
    message += `Даты: ${startDate} - ${endDate}\n`;
    message += `Комплектов: ${order.kit_count} | Сумма: ${order.total_price} руб.\n\n`;

    buttons.push([{ text: `📦 Заказ #${order.order_number}`, callback_data: `order:${order.id}` }]);
  }

  buttons.push([{ text: "◀️ Назад в меню", callback_data: "menu" }]);

  await sendTelegramMessageWithKeyboard(supabaseClient, chatId, message, { inline_keyboard: buttons });
}

async function sendOrdersList(supabaseClient: any, chatId: string, clientId: string, offset: number) {
  const limit = 5;

  const { data: orders, error, count } = await supabaseClient
    .from("rental_orders")
    .select("id, order_number, status, start_date, end_date, total_price, kit_count", { count: "exact" })
    .eq("client_id", clientId)
    .order("created_at", { ascending: false })
    .range(offset, offset + limit - 1);

  if (error || !orders || orders.length === 0) {
    const keyboard: InlineKeyboardMarkup = {
      inline_keyboard: [
        [{ text: "➕ Создать заказ", callback_data: "new_order" }],
        [{ text: "◀️ Назад в меню", callback_data: "menu" }],
      ],
    };

    await sendTelegramMessageWithKeyboard(
      supabaseClient,
      chatId,
      offset > 0 ? "Больше заказов нет." : "У вас пока нет заказов.",
      keyboard
    );
    return;
  }

  let message = "📚 <b>Все заказы:</b>\n\n";
  const buttons: InlineKeyboardButton[][] = [];

  for (const order of orders) {
    const statusEmoji = ORDER_STATUS_EMOJI[order.status] || "📋";
    const statusLabel = ORDER_STATUS_LABELS[order.status] || order.status;
    const startDate = formatDate(order.start_date);

    message += `${statusEmoji} #${order.order_number} | ${startDate} | ${statusLabel}\n`;
    buttons.push([{ text: `Заказ #${order.order_number}`, callback_data: `order:${order.id}` }]);
  }

  // Pagination buttons
  const navButtons: InlineKeyboardButton[] = [];
  if (offset > 0) {
    navButtons.push({ text: "⬅️ Назад", callback_data: `orders:${offset - limit}` });
  }
  if (count && offset + limit < count) {
    navButtons.push({ text: "➡️ Далее", callback_data: `orders:${offset + limit}` });
  }
  if (navButtons.length > 0) {
    buttons.push(navButtons);
  }

  buttons.push([{ text: "◀️ В меню", callback_data: "menu" }]);

  await sendTelegramMessageWithKeyboard(supabaseClient, chatId, message, { inline_keyboard: buttons });
}

async function sendOrderHistory(supabaseClient: any, chatId: string, clientId: string, offset: number) {
  const limit = 5;

  const { data: orders, error, count } = await supabaseClient
    .from("rental_orders")
    .select("id, order_number, status, start_date, end_date, total_price", { count: "exact" })
    .eq("client_id", clientId)
    .in("status", ["returned", "completed", "cancelled"])
    .order("end_date", { ascending: false })
    .range(offset, offset + limit - 1);

  if (error || !orders || orders.length === 0) {
    const keyboard: InlineKeyboardMarkup = {
      inline_keyboard: [[{ text: "◀️ Назад в меню", callback_data: "menu" }]],
    };

    await sendTelegramMessageWithKeyboard(
      supabaseClient,
      chatId,
      offset > 0 ? "Больше заказов нет." : "История заказов пуста.",
      keyboard
    );
    return;
  }

  let message = "📚 <b>История заказов:</b>\n\n";
  const buttons: InlineKeyboardButton[][] = [];

  for (const order of orders) {
    const statusEmoji = ORDER_STATUS_EMOJI[order.status] || "📋";
    const statusLabel = ORDER_STATUS_LABELS[order.status] || order.status;
    const startDate = formatDate(order.start_date);

    message += `${statusEmoji} #${order.order_number} | ${startDate} | ${statusLabel}\n`;
    buttons.push([{ text: `Заказ #${order.order_number}`, callback_data: `order:${order.id}` }]);
  }

  // Pagination
  const navButtons: InlineKeyboardButton[] = [];
  if (offset > 0) {
    navButtons.push({ text: "⬅️ Назад", callback_data: `history:${offset - limit}` });
  }
  if (count && offset + limit < count) {
    navButtons.push({ text: "➡️ Далее", callback_data: `history:${offset + limit}` });
  }
  if (navButtons.length > 0) {
    buttons.push(navButtons);
  }

  buttons.push([{ text: "◀️ В меню", callback_data: "menu" }]);

  await sendTelegramMessageWithKeyboard(supabaseClient, chatId, message, { inline_keyboard: buttons });
}

async function sendOrderDetails(supabaseClient: any, chatId: string, orderId: string, clientId: string) {
  const { data: order, error } = await supabaseClient
    .from("rental_orders")
    .select("*")
    .eq("id", orderId)
    .eq("client_id", clientId)
    .single();

  if (error || !order) {
    await sendTelegramMessage(supabaseClient, chatId, "Заказ не найден.");
    return;
  }

  const statusEmoji = ORDER_STATUS_EMOJI[order.status] || "📋";
  const statusLabel = ORDER_STATUS_LABELS[order.status] || order.status;
  const startDate = formatDate(order.start_date);
  const endDate = formatDate(order.end_date);

  let message = `${statusEmoji} <b>Заказ #${order.order_number}</b>\n\n`;
  message += `<b>Статус:</b> ${statusLabel}\n`;
  message += `<b>Даты:</b> ${startDate} - ${endDate}\n`;
  message += `<b>Дней аренды:</b> ${order.days_count}\n\n`;
  
  message += `<b>Оборудование:</b>\n`;
  message += `• Комплектов: ${order.kit_count}\n`;
  if (order.spare_receiver_count > 0) {
    message += `• Запасных приёмников: ${order.spare_receiver_count}\n`;
  }
  if (order.transmitter_count > 0) {
    message += `• Передатчиков: ${order.transmitter_count}\n`;
  }
  if (order.microphone_count > 0) {
    message += `• Микрофонов: ${order.microphone_count}\n`;
  }
  
  message += `\n<b>Стоимость:</b>\n`;
  message += `• Сумма: ${order.total_price} руб.\n`;
  if (order.prepayment > 0) {
    message += `• Предоплата: ${order.prepayment} руб.\n`;
    message += `• К оплате: ${order.total_price - order.prepayment} руб.\n`;
  }

  if (order.receiver_notes) {
    message += `\n<b>Комментарий:</b> ${order.receiver_notes}\n`;
  }

  if (order.manager_name) {
    message += `\n<b>Менеджер:</b> ${order.manager_name}`;
  }

  const keyboard: InlineKeyboardMarkup = {
    inline_keyboard: [
      [{ text: "📋 Все заказы", callback_data: "orders:0" }],
      [{ text: "◀️ В меню", callback_data: "menu" }],
    ],
  };

  await sendTelegramMessageWithKeyboard(supabaseClient, chatId, message, keyboard);
}

async function sendNewOrderInfo(supabaseClient: any, chatId: string) {
  const { data: settings } = await supabaseClient
    .from("notification_settings")
    .select("telegram_bot_username, mini_app_url")
    .single();

  let message = "➕ <b>Создание нового заказа</b>\n\n";
  message += "Для создания заказа укажите:\n";
  message += "• Даты аренды (начало и конец)\n";
  message += "• Количество дней\n";
  message += "• Количество комплектов\n";
  message += "• Комментарий к заказу\n\n";

  const keyboard: InlineKeyboardMarkup = {
    inline_keyboard: [],
  };

  // Add Mini App button if URL is configured
  if (settings?.mini_app_url) {
    message += "Нажмите кнопку ниже для создания заказа:";
    // Pass chatId as query parameter for fallback identification
    const miniAppUrlWithChatId = `${settings.mini_app_url}?chatId=${chatId}`;
    keyboard.inline_keyboard.push([
      { text: "📝 Создать заказ", web_app: { url: miniAppUrlWithChatId } }
    ]);
  } else {
    message += "Для создания заказа свяжитесь с менеджером.";
  }

  keyboard.inline_keyboard.push([{ text: "◀️ Назад в меню", callback_data: "menu" }]);

  await sendTelegramMessageWithKeyboard(supabaseClient, chatId, message, keyboard);
}

async function sendHelpMessage(supabaseClient: any, chatId: string) {
  const message = `❓ <b>Помощь</b>

<b>Команды бота:</b>
/start - Главное меню
/menu - Открыть меню
/orders - Мои заказы
/help - Справка

<b>Кнопки меню:</b>
📋 <b>Активные заказы</b> - текущие заказы со статусом "Новый" или "Выдан"
📚 <b>История</b> - завершённые и отменённые заказы
➕ <b>Новый заказ</b> - создание заказа

<b>Статусы заказов:</b>
📋 Новый - заказ создан
📦 Выдан - оборудование выдано
✅ Возвращён - оборудование возвращено
🏁 Завершён - заказ закрыт
❌ Отменён - заказ отменён

По всем вопросам обращайтесь к вашему менеджеру.`;

  const keyboard: InlineKeyboardMarkup = {
    inline_keyboard: [[{ text: "◀️ Назад в меню", callback_data: "menu" }]],
  };

  await sendTelegramMessageWithKeyboard(supabaseClient, chatId, message, keyboard);
}

async function getClientByChatId(supabaseClient: any, chatId: string) {
  const { data: client } = await supabaseClient
    .from("rental_clients")
    .select("id, name")
    .eq("telegram_chat_id", chatId)
    .maybeSingle();

  return client;
}

function formatDate(dateStr: string): string {
  try {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    });
  } catch {
    return dateStr;
  }
}

async function sendTelegramMessage(supabaseClient: any, chatId: string, text: string) {
  try {
    const { data: settings } = await supabaseClient
      .from("notification_settings")
      .select("telegram_bot_token")
      .single();

    if (!settings?.telegram_bot_token) {
      console.error("Telegram bot token not configured");
      return;
    }

    const telegramUrl = `https://api.telegram.org/bot${settings.telegram_bot_token}/sendMessage`;
    
    await fetch(telegramUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        chat_id: chatId,
        text: text,
        parse_mode: "HTML",
      }),
    });
  } catch (error) {
    console.error("Failed to send Telegram message:", error);
  }
}

async function sendTelegramMessageWithKeyboard(
  supabaseClient: any,
  chatId: string,
  text: string,
  replyMarkup: InlineKeyboardMarkup
) {
  try {
    const { data: settings } = await supabaseClient
      .from("notification_settings")
      .select("telegram_bot_token")
      .single();

    if (!settings?.telegram_bot_token) {
      console.error("Telegram bot token not configured");
      return;
    }

    const telegramUrl = `https://api.telegram.org/bot${settings.telegram_bot_token}/sendMessage`;
    
    await fetch(telegramUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        chat_id: chatId,
        text: text,
        parse_mode: "HTML",
        reply_markup: replyMarkup,
      }),
    });
  } catch (error) {
    console.error("Failed to send Telegram message with keyboard:", error);
  }
}

async function answerCallbackQuery(supabaseClient: any, callbackQueryId: string, text?: string) {
  try {
    const { data: settings } = await supabaseClient
      .from("notification_settings")
      .select("telegram_bot_token")
      .single();

    if (!settings?.telegram_bot_token) {
      return;
    }

    const telegramUrl = `https://api.telegram.org/bot${settings.telegram_bot_token}/answerCallbackQuery`;
    
    await fetch(telegramUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        callback_query_id: callbackQueryId,
        text: text,
      }),
    });
  } catch (error) {
    console.error("Failed to answer callback query:", error);
  }
}
