-- Add separate rental permissions to profiles
-- Run this in Supabase SQL Editor

-- This script migrates existing rental permission to new granular permissions
-- The permissions are stored in the JSONB 'permissions' column

-- For users who have rental=true in permissions, grant all rental sub-permissions
UPDATE profiles 
SET permissions = permissions || '{
  "rental_clients": true,
  "rental_orders": true,
  "rental_payments": true,
  "rental_commissions": true,
  "rental_calendar": true
}'::jsonb
WHERE permissions->>'rental' = 'true';

-- Note: After running this migration, you can manage individual rental permissions
-- from the Admin Panel -> Manager Details screen
