-- Add equipment_blocks column to rental_orders table
-- This stores per-block equipment data for multi-bag orders
-- Run this in Supabase SQL Editor

ALTER TABLE rental_orders 
ADD COLUMN IF NOT EXISTS equipment_blocks JSONB DEFAULT NULL;

-- Add comment explaining the column
COMMENT ON COLUMN rental_orders.equipment_blocks IS 'JSON array of equipment blocks: [{bagNumber, kitCount, spareReceiverCount, transmitterCount, microphoneCount}]. Used for multi-bag orders. Falls back to aggregated columns if null.';
