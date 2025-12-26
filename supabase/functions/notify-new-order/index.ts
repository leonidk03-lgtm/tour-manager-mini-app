import { createClient } from 'npm:@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    
    const supabase = createClient(supabaseUrl, supabaseServiceKey)

    const payload = await req.json()
    
    const record = payload.record || payload
    if (!record || !record.order_number) {
      console.log('No valid order record in payload')
      return new Response(JSON.stringify({ success: true, skipped: true }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      })
    }

    const { data: settings } = await supabase
      .from('notification_settings')
      .select('telegram_bot_token, notifications_enabled')
      .single()

    if (!settings?.notifications_enabled || !settings?.telegram_bot_token) {
      console.log('Notifications disabled or no bot token')
      return new Response(JSON.stringify({ success: true, skipped: true }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      })
    }

    const { data: client } = await supabase
      .from('rental_clients')
      .select('name, phone')
      .eq('id', record.client_id)
      .single()

    const startDate = new Date(record.start_date).toLocaleDateString('ru-RU')
    const endDate = new Date(record.end_date).toLocaleDateString('ru-RU')

    const message = `📋 <b>Новый заказ #${record.order_number}</b>\n\n` +
      `<b>Клиент:</b> ${client?.name || 'Неизвестно'}\n` +
      `<b>Телефон:</b> ${client?.phone || '-'}\n` +
      `<b>Даты:</b> ${startDate} - ${endDate}\n` +
      `<b>Дней:</b> ${record.days_count || 1}\n` +
      `<b>Комплектов:</b> ${record.kit_count || 1}\n` +
      (record.spare_receiver_count > 0 ? `<b>Запасных приёмников:</b> ${record.spare_receiver_count}\n` : '') +
      (record.transmitter_count > 0 ? `<b>Передатчиков:</b> ${record.transmitter_count}\n` : '') +
      (record.microphone_count > 0 ? `<b>Микрофонов:</b> ${record.microphone_count}\n` : '') +
      `<b>Сумма:</b> ${record.total_price || 0} руб.\n` +
      (record.receiver_notes ? `<b>Комментарий:</b> ${record.receiver_notes}\n` : '') +
      `\n<i>Заказ создан через Telegram Mini App</i>`

    const { data: managers } = await supabase
      .from('managers')
      .select('id, name, telegram_chat_id')
      .eq('is_admin', true)
      .not('telegram_chat_id', 'is', null)

    if (!managers || managers.length === 0) {
      console.log('No admin managers with telegram_chat_id found')
      return new Response(JSON.stringify({ success: true, skipped: true }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      })
    }

    const BOT_TOKEN = settings.telegram_bot_token
    let sentCount = 0

    for (const manager of managers) {
      if (manager.telegram_chat_id) {
        try {
          const response = await fetch(
            `https://api.telegram.org/bot${BOT_TOKEN}/sendMessage`,
            {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({
                chat_id: manager.telegram_chat_id,
                text: message,
                parse_mode: 'HTML',
              }),
            }
          )

          if (response.ok) {
            sentCount++
            console.log(`Notification sent to manager ${manager.name}`)
          } else {
            const error = await response.json()
            console.error(`Failed to send to ${manager.name}:`, error)
          }
        } catch (err) {
          console.error(`Error sending to ${manager.name}:`, err)
        }
      }
    }

    return new Response(
      JSON.stringify({ success: true, sentCount }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (error) {
    console.error('Error in notify-new-order:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
