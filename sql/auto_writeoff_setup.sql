-- Add auto_writeoff columns to equipment_categories table
-- Run this in Supabase SQL Editor
-- Safe to run multiple times (idempotent)

-- Add auto_writeoff column if not exists
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'equipment_categories' AND column_name = 'auto_writeoff'
  ) THEN
    ALTER TABLE equipment_categories ADD COLUMN auto_writeoff BOOLEAN DEFAULT false;
  END IF;
END $$;

-- Add auto_writeoff_source_id column if not exists (references another category)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'equipment_categories' AND column_name = 'auto_writeoff_source_id'
  ) THEN
    ALTER TABLE equipment_categories ADD COLUMN auto_writeoff_source_id UUID REFERENCES equipment_categories(id);
  END IF;
END $$;

-- Usage:
-- 1. Create a category for consumables (e.g., "Одноразовые наушники")
-- 2. Set auto_writeoff = true for that category
-- 3. Set auto_writeoff_source_id to the ID of the "Radio Guides" or "Receivers" category
-- 
-- When equipment from the source category is issued, items from this category
-- will be automatically written off using formula: receivers_count + 5
