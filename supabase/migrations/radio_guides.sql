-- Radio Guide Kits - сумки с радиогидами
CREATE TABLE IF NOT EXISTS radio_guide_kits (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    bag_number INTEGER NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'available' CHECK (status IN ('available', 'issued', 'maintenance')),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Radio Guide Assignments - выдача радиогидов
CREATE TABLE IF NOT EXISTS radio_guide_assignments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    kit_id UUID NOT NULL REFERENCES radio_guide_kits(id) ON DELETE CASCADE,
    excursion_id UUID,
    guide_name VARCHAR(255) NOT NULL,
    bus_number VARCHAR(50),
    receivers_issued INTEGER NOT NULL,
    receivers_returned INTEGER,
    issued_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    returned_at TIMESTAMPTZ,
    manager_id UUID NOT NULL,
    manager_name VARCHAR(255) NOT NULL,
    return_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_radio_guide_kits_status ON radio_guide_kits(status);
CREATE INDEX IF NOT EXISTS idx_radio_guide_kits_bag_number ON radio_guide_kits(bag_number);
CREATE INDEX IF NOT EXISTS idx_radio_guide_assignments_kit_id ON radio_guide_assignments(kit_id);
CREATE INDEX IF NOT EXISTS idx_radio_guide_assignments_issued_at ON radio_guide_assignments(issued_at);

-- RLS
ALTER TABLE radio_guide_kits ENABLE ROW LEVEL SECURITY;
ALTER TABLE radio_guide_assignments ENABLE ROW LEVEL SECURITY;

-- Policies - все авторизованные пользователи могут все
CREATE POLICY "radio_guide_kits_all" ON radio_guide_kits 
    FOR ALL TO authenticated 
    USING (true) 
    WITH CHECK (true);

CREATE POLICY "radio_guide_assignments_all" ON radio_guide_assignments 
    FOR ALL TO authenticated 
    USING (true) 
    WITH CHECK (true);

-- Trigger для автоматического обновления updated_at
CREATE OR REPLACE FUNCTION update_radio_guide_kits_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_update_radio_guide_kits_updated_at ON radio_guide_kits;
CREATE TRIGGER trigger_update_radio_guide_kits_updated_at
    BEFORE UPDATE ON radio_guide_kits
    FOR EACH ROW
    EXECUTE FUNCTION update_radio_guide_kits_updated_at();
