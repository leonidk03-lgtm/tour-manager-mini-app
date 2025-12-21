-- Dispatch Mark Events - Статистика отметок туристов менеджерами
-- Выполните этот SQL в Supabase SQL Editor

-- Таблица для хранения событий отметок
CREATE TABLE IF NOT EXISTS dispatch_mark_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  manager_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  phone TEXT NOT NULL,
  pax_count INTEGER NOT NULL DEFAULT 1,
  excursion_date DATE NOT NULL,
  action TEXT NOT NULL CHECK (action IN ('mark', 'unmark')),
  excursion_name TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Индексы для быстрых запросов
CREATE INDEX IF NOT EXISTS idx_dispatch_mark_events_manager_id ON dispatch_mark_events(manager_id);
CREATE INDEX IF NOT EXISTS idx_dispatch_mark_events_created_at ON dispatch_mark_events(created_at);
CREATE INDEX IF NOT EXISTS idx_dispatch_mark_events_excursion_date ON dispatch_mark_events(excursion_date);
CREATE INDEX IF NOT EXISTS idx_dispatch_mark_events_manager_date ON dispatch_mark_events(manager_id, created_at);

-- Уникальный индекс для предотвращения дублирования одинаковых событий
-- (один менеджер не может отметить один и тот же телефон дважды за секунду)
CREATE UNIQUE INDEX IF NOT EXISTS idx_dispatch_mark_events_unique 
ON dispatch_mark_events(manager_id, phone, excursion_date, action, date_trunc('second', created_at));

-- RLS политики
ALTER TABLE dispatch_mark_events ENABLE ROW LEVEL SECURITY;

-- Менеджеры могут добавлять свои события
CREATE POLICY "Managers can insert own events" ON dispatch_mark_events
  FOR INSERT WITH CHECK (auth.uid() = manager_id);

-- Менеджеры видят только свои события
CREATE POLICY "Managers can view own events" ON dispatch_mark_events
  FOR SELECT USING (
    auth.uid() = manager_id 
    OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- Админы могут видеть все события
CREATE POLICY "Admins can view all events" ON dispatch_mark_events
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- Функция для получения агрегированной статистики
CREATE OR REPLACE FUNCTION get_dispatch_stats(
  p_start_date DATE,
  p_end_date DATE,
  p_manager_id UUID DEFAULT NULL
)
RETURNS TABLE (
  manager_id UUID,
  manager_name TEXT,
  total_phones BIGINT,
  total_pax BIGINT,
  mark_count BIGINT,
  unmark_count BIGINT,
  net_phones BIGINT,
  net_pax BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    e.manager_id,
    p.display_name as manager_name,
    COUNT(DISTINCT CASE WHEN e.action = 'mark' THEN e.phone END) as total_phones,
    SUM(CASE WHEN e.action = 'mark' THEN e.pax_count ELSE 0 END)::BIGINT as total_pax,
    COUNT(CASE WHEN e.action = 'mark' THEN 1 END) as mark_count,
    COUNT(CASE WHEN e.action = 'unmark' THEN 1 END) as unmark_count,
    (COUNT(CASE WHEN e.action = 'mark' THEN 1 END) - 
     COUNT(CASE WHEN e.action = 'unmark' THEN 1 END))::BIGINT as net_phones,
    (SUM(CASE WHEN e.action = 'mark' THEN e.pax_count ELSE 0 END) - 
     SUM(CASE WHEN e.action = 'unmark' THEN e.pax_count ELSE 0 END))::BIGINT as net_pax
  FROM dispatch_mark_events e
  JOIN profiles p ON e.manager_id = p.id
  WHERE e.created_at >= p_start_date
    AND e.created_at < p_end_date + INTERVAL '1 day'
    AND (p_manager_id IS NULL OR e.manager_id = p_manager_id)
  GROUP BY e.manager_id, p.display_name
  ORDER BY net_pax DESC;
END;
$$;

-- Предоставить доступ к функции
GRANT EXECUTE ON FUNCTION get_dispatch_stats TO authenticated;
