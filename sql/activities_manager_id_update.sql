-- Add manager_id column to activities table for proper manager filtering
-- Run this in Supabase SQL Editor

-- Add manager_id column if it doesn't exist
ALTER TABLE activities ADD COLUMN IF NOT EXISTS manager_id uuid REFERENCES auth.users(id);

-- Create index for faster filtering by manager
CREATE INDEX IF NOT EXISTS idx_activities_manager_id ON activities(manager_id);

-- Backfill manager_id for existing records based on manager_name
UPDATE activities a
SET manager_id = p.id
FROM profiles p
WHERE a.manager_id IS NULL
AND a.manager_name = p.display_name;
