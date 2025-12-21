-- Add dashboard_config column to profiles table for storing widget visibility and order settings
-- Run this in your Supabase SQL Editor

ALTER TABLE profiles 
ADD COLUMN IF NOT EXISTS dashboard_config JSONB DEFAULT NULL;

-- Add comment for documentation
COMMENT ON COLUMN profiles.dashboard_config IS 'Stores dashboard widget configuration including visibility and order settings';
