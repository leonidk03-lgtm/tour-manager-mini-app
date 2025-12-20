-- Rental Services table for additional services (delivery, extra headphones, etc.)
CREATE TABLE IF NOT EXISTS rental_services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  price DECIMAL(10,2) NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE rental_services ENABLE ROW LEVEL SECURITY;

-- Allow all authenticated users to read services
CREATE POLICY "Allow authenticated read" ON rental_services
  FOR SELECT TO authenticated USING (true);

-- Allow authenticated users to insert/update/delete
CREATE POLICY "Allow authenticated insert" ON rental_services
  FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Allow authenticated update" ON rental_services
  FOR UPDATE TO authenticated USING (true);

CREATE POLICY "Allow authenticated delete" ON rental_services
  FOR DELETE TO authenticated USING (true);

-- Rental Order Services junction table
CREATE TABLE IF NOT EXISTS rental_order_services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID NOT NULL REFERENCES rental_orders(id) ON DELETE CASCADE,
  service_id UUID NOT NULL REFERENCES rental_services(id) ON DELETE CASCADE,
  service_name TEXT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 1,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE rental_order_services ENABLE ROW LEVEL SECURITY;

-- Allow all authenticated users to read order services
CREATE POLICY "Allow authenticated read" ON rental_order_services
  FOR SELECT TO authenticated USING (true);

-- Allow authenticated users to insert/update/delete
CREATE POLICY "Allow authenticated insert" ON rental_order_services
  FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Allow authenticated update" ON rental_order_services
  FOR UPDATE TO authenticated USING (true);

CREATE POLICY "Allow authenticated delete" ON rental_order_services
  FOR DELETE TO authenticated USING (true);

-- Add service commission percentage to profiles table
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS service_commission_percent DECIMAL(5,2) DEFAULT 10;
