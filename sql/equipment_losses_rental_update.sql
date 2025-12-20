-- Migration: Add rental_order_id to equipment_losses table
-- This allows tracking equipment losses from rental orders separately from excursion losses

-- Add rental_order_id column to equipment_losses table
ALTER TABLE equipment_losses
ADD COLUMN IF NOT EXISTS rental_order_id UUID REFERENCES rental_orders(id) ON DELETE SET NULL;

-- Create index for faster lookups by rental order
CREATE INDEX IF NOT EXISTS idx_equipment_losses_rental_order 
ON equipment_losses(rental_order_id) 
WHERE rental_order_id IS NOT NULL;

-- Update existing constraints: assignment_id and kit_id are now nullable
-- to support rental losses which don't have radio guide assignments
ALTER TABLE equipment_losses 
ALTER COLUMN assignment_id DROP NOT NULL;

ALTER TABLE equipment_losses 
ALTER COLUMN kit_id DROP NOT NULL;

-- Add comment for documentation
COMMENT ON COLUMN equipment_losses.rental_order_id IS 'Reference to rental order if loss occurred during rental (nullable for excursion losses)';
