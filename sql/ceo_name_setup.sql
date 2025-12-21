-- Add ceo_name column to rental_clients table
-- Run this in Supabase SQL Editor

ALTER TABLE rental_clients 
ADD COLUMN IF NOT EXISTS ceo_name TEXT;

COMMENT ON COLUMN rental_clients.ceo_name IS 'ФИО директора компании';
