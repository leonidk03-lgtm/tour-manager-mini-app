-- Radio Guide Kits - сумки с радиогидами
CREATE TABLE IF NOT EXISTS radio_guide_kits (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    bag_number INTEGER NOT NULL UNIQUE,
    receiver_count INTEGER NOT NULL DEFAULT 40,
    status VARCHAR(20) NOT NULL DEFAULT 'available' CHECK (status IN ('available', 'issued', 'maintenance')),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Radio Guide Assignments - выдача радиогидов
CREATE TABLE IF NOT EXISTS radio_guide_assignments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    kit_id UUID NOT NULL REFERENCES radio_guide_kits(id) ON DELETE CASCADE,
    excursion_id UUID REFERENCES excursions(id) ON DELETE SET NULL,
    guide_name VARCHAR(255) NOT NULL,
    bus_number VARCHAR(50),
    receivers_issued INTEGER NOT NULL,
    receivers_returned INTEGER,
    issued_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    returned_at TIMESTAMPTZ,
    manager_id UUID NOT NULL REFERENCES profiles(id),
    manager_name VARCHAR(255) NOT NULL,
    return_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes для производительности
CREATE INDEX IF NOT EXISTS idx_radio_guide_kits_status ON radio_guide_kits(status);
CREATE INDEX IF NOT EXISTS idx_radio_guide_kits_bag_number ON radio_guide_kits(bag_number);
CREATE INDEX IF NOT EXISTS idx_radio_guide_assignments_kit_id ON radio_guide_assignments(kit_id);
CREATE INDEX IF NOT EXISTS idx_radio_guide_assignments_excursion_id ON radio_guide_assignments(excursion_id);
CREATE INDEX IF NOT EXISTS idx_radio_guide_assignments_issued_at ON radio_guide_assignments(issued_at);
CREATE INDEX IF NOT EXISTS idx_radio_guide_assignments_returned_at ON radio_guide_assignments(returned_at);

-- RLS Policies
ALTER TABLE radio_guide_kits ENABLE ROW LEVEL SECURITY;
ALTER TABLE radio_guide_assignments ENABLE ROW LEVEL SECURITY;

-- Политики для radio_guide_kits (все авторизованные пользователи могут читать)
CREATE POLICY "radio_guide_kits_select_all" ON radio_guide_kits
    FOR SELECT TO authenticated USING (true);

-- Админы могут добавлять сумки
CREATE POLICY "radio_guide_kits_insert_admin" ON radio_guide_kits
    FOR INSERT TO authenticated
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles 
            WHERE profiles.id = auth.uid() 
            AND profiles.role = 'admin'
        )
    );

-- Все авторизованные пользователи могут обновлять статус (для выдачи/приёма)
CREATE POLICY "radio_guide_kits_update_all" ON radio_guide_kits
    FOR UPDATE TO authenticated
    USING (true)
    WITH CHECK (true);

-- Только админы могут удалять сумки
CREATE POLICY "radio_guide_kits_delete_admin" ON radio_guide_kits
    FOR DELETE TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM profiles 
            WHERE profiles.id = auth.uid() 
            AND profiles.role = 'admin'
        )
    );

-- Политики для radio_guide_assignments (все могут читать и создавать/обновлять)
CREATE POLICY "radio_guide_assignments_select_all" ON radio_guide_assignments
    FOR SELECT TO authenticated USING (true);

CREATE POLICY "radio_guide_assignments_insert_all" ON radio_guide_assignments
    FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "radio_guide_assignments_update_all" ON radio_guide_assignments
    FOR UPDATE TO authenticated USING (true);

-- Функция обновления updated_at
CREATE OR REPLACE FUNCTION update_radio_guide_kits_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер для автоматического обновления updated_at
DROP TRIGGER IF EXISTS trigger_update_radio_guide_kits_updated_at ON radio_guide_kits;
CREATE TRIGGER trigger_update_radio_guide_kits_updated_at
    BEFORE UPDATE ON radio_guide_kits
    FOR EACH ROW
    EXECUTE FUNCTION update_radio_guide_kits_updated_at();
