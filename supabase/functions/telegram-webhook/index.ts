import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

interface TelegramUpdate {
  update_id: number;
  message?: {
    message_id: number;
    from: {
      id: number;
      first_name: string;
      last_name?: string;
      username?: string;
    };
    chat: {
      id: number;
      type: string;
    };
    text?: string;
  };
}

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
    
    if (!update.message?.text) {
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const text = update.message.text;
    const chatId = update.message.chat.id.toString();
    const userName = update.message.from.first_name + (update.message.from.last_name ? ` ${update.message.from.last_name}` : "");

    if (text.startsWith("/start ")) {
      const inviteCode = text.replace("/start ", "").trim();
      
      if (!inviteCode) {
        await sendTelegramMessage(supabaseClient, chatId, "Код приглашения не указан.");
        return new Response(JSON.stringify({ ok: true }), {
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }

      const { data: client, error: clientError } = await supabaseClient
        .from("rental_clients")
        .select("id, name, telegram_invite_code, invite_code_used, invite_code_expires_at")
        .eq("telegram_invite_code", inviteCode)
        .maybeSingle();

      if (client) {
        if (client.invite_code_used) {
          await sendTelegramMessage(supabaseClient, chatId, "Эта ссылка уже была использована.");
          return new Response(JSON.stringify({ ok: true }), {
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          });
        }

        if (client.invite_code_expires_at && new Date(client.invite_code_expires_at) < new Date()) {
          await sendTelegramMessage(supabaseClient, chatId, "Срок действия ссылки истёк. Запросите новую ссылку.");
          return new Response(JSON.stringify({ ok: true }), {
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          });
        }

        await supabaseClient
          .from("rental_clients")
          .update({
            telegram_chat_id: chatId,
            invite_code_used: true,
          })
          .eq("id", client.id);

        await sendTelegramMessage(
          supabaseClient,
          chatId,
          `Добро пожаловать, ${client.name}! Вы успешно подключены к уведомлениям TourManager.`
        );

        return new Response(JSON.stringify({ ok: true }), {
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }

      const { data: guide, error: guideError } = await supabaseClient
        .from("tour_guides")
        .select("id, name, telegram_invite_code, invite_code_used, invite_code_expires_at")
        .eq("telegram_invite_code", inviteCode)
        .maybeSingle();

      if (guide) {
        if (guide.invite_code_used) {
          await sendTelegramMessage(supabaseClient, chatId, "Эта ссылка уже была использована.");
          return new Response(JSON.stringify({ ok: true }), {
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          });
        }

        if (guide.invite_code_expires_at && new Date(guide.invite_code_expires_at) < new Date()) {
          await sendTelegramMessage(supabaseClient, chatId, "Срок действия ссылки истёк. Запросите новую ссылку.");
          return new Response(JSON.stringify({ ok: true }), {
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          });
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
          `Добро пожаловать, ${guide.name}! Вы успешно подключены к уведомлениям TourManager.`
        );

        return new Response(JSON.stringify({ ok: true }), {
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }

      await sendTelegramMessage(supabaseClient, chatId, "Код приглашения не найден или недействителен.");
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    if (text === "/start") {
      await sendTelegramMessage(
        supabaseClient,
        chatId,
        "Добро пожаловать в TourManager Bot! Для подключения уведомлений используйте персональную ссылку-приглашение от вашего менеджера."
      );
      return new Response(JSON.stringify({ ok: true }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
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
