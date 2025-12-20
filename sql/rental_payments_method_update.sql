-- Add payment method column to rental_payments table
-- Run this in Supabase SQL Editor

ALTER TABLE rental_payments 
ADD COLUMN IF NOT EXISTS method TEXT DEFAULT 'cash' CHECK (method IN ('cash', 'card', 'transfer'));

-- Update existing payments to have 'cash' as default method (already handled by DEFAULT)
UPDATE rental_payments SET method = 'cash' WHERE method IS NULL;
