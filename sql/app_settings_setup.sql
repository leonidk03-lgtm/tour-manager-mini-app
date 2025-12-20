-- Create app_settings table for storing application configuration
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS app_settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE app_settings ENABLE ROW LEVEL SECURITY;

-- Allow all authenticated users to read settings
CREATE POLICY "Allow authenticated users to read settings"
  ON app_settings FOR SELECT
  TO authenticated
  USING (true);

-- Allow admins to update settings
CREATE POLICY "Allow admins to update settings"
  ON app_settings FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );

-- Insert default values
INSERT INTO app_settings (key, value) VALUES 
  ('radio_guide_price', '80'),
  ('rental_cost_per_kit_per_day', '50')
ON CONFLICT (key) DO NOTHING;
