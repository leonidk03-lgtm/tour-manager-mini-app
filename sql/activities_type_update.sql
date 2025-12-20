-- Update activities table to allow new activity types
-- Run this in Supabase SQL Editor

-- Drop the existing check constraint
ALTER TABLE activities DROP CONSTRAINT IF EXISTS activities_type_check;

-- Add updated check constraint with all activity types
ALTER TABLE activities ADD CONSTRAINT activities_type_check CHECK (
  type IN (
    'excursion_added',
    'transaction_added',
    'excursion_deleted',
    'transaction_deleted',
    'radio_issued',
    'radio_returned',
    'rental_order_created',
    'rental_order_updated',
    'rental_order_issued',
    'rental_order_returned',
    'rental_order_completed',
    'equipment_loss_registered',
    'equipment_loss_found'
  )
);
