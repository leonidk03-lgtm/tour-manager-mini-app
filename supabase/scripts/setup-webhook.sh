#!/bin/bash

# Script to configure database webhook for new order notifications
# Requires: SUPABASE_PROJECT_REF, SUPABASE_SERVICE_ROLE_KEY, SUPABASE_ACCESS_TOKEN

if [ -z "$SUPABASE_PROJECT_REF" ] || [ -z "$SUPABASE_ACCESS_TOKEN" ]; then
  echo "Error: Required environment variables not set"
  echo "Please set: SUPABASE_PROJECT_REF, SUPABASE_ACCESS_TOKEN"
  exit 1
fi

WEBHOOK_URL="https://${SUPABASE_PROJECT_REF}.supabase.co/functions/v1/notify-new-order"

echo "Creating database webhook for rental_orders INSERT..."

# Note: Supabase Database Webhooks are configured via Dashboard, not API
# This script serves as documentation for the manual steps

echo ""
echo "=== Manual Setup Required ==="
echo ""
echo "1. Go to Supabase Dashboard: https://supabase.com/dashboard/project/${SUPABASE_PROJECT_REF}/database/hooks"
echo ""
echo "2. Click 'Create a new hook'"
echo ""
echo "3. Configure the hook:"
echo "   - Name: notify_new_order"
echo "   - Table: rental_orders"
echo "   - Events: INSERT (check only INSERT)"
echo "   - Hook type: HTTP Request"
echo "   - HTTP Method: POST"
echo "   - URL: ${WEBHOOK_URL}"
echo ""
echo "4. Add HTTP Headers:"
echo "   - Key: Authorization"
echo "   - Value: Bearer [your_service_role_key]"
echo "   - Key: Content-Type"
echo "   - Value: application/json"
echo ""
echo "5. Click 'Create hook'"
echo ""
echo "=== Deployment Commands ==="
echo ""
echo "Deploy the edge function:"
echo "  supabase functions deploy notify-new-order --project-ref ${SUPABASE_PROJECT_REF}"
echo ""
echo "=== Test the Webhook ==="
echo ""
echo "After setup, create an order via Mini App and check if admin managers receive Telegram notifications."
echo ""
