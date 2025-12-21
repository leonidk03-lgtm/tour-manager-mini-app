-- Расширенные функции для статистики диспетчеризации
-- Выполните в Supabase SQL Editor

-- 1. Статистика по экскурсиям
CREATE OR REPLACE FUNCTION get_dispatch_stats_by_excursion(
  p_start_date DATE,
  p_end_date DATE
)
RETURNS TABLE (
  excursion_name TEXT,
  excursion_date DATE,
  total_phones BIGINT,
  total_pax BIGINT,
  managers_count BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COALESCE(e.excursion_name, 'Без названия') as excursion_name,
    e.excursion_date,
    (COUNT(CASE WHEN e.action = 'mark' THEN 1 END) - 
     COUNT(CASE WHEN e.action = 'unmark' THEN 1 END))::BIGINT as total_phones,
    (SUM(CASE WHEN e.action = 'mark' THEN e.pax_count ELSE 0 END) - 
     SUM(CASE WHEN e.action = 'unmark' THEN e.pax_count ELSE 0 END))::BIGINT as total_pax,
    COUNT(DISTINCT e.manager_id)::BIGINT as managers_count
  FROM dispatch_mark_events e
  WHERE e.created_at >= p_start_date
    AND e.created_at < p_end_date + INTERVAL '1 day'
  GROUP BY e.excursion_name, e.excursion_date
  ORDER BY e.excursion_date DESC, total_pax DESC;
END;
$$;

-- 2. Поиск по телефону - кто обилетил клиента
CREATE OR REPLACE FUNCTION search_dispatch_by_phone(
  p_phone TEXT
)
RETURNS TABLE (
  id UUID,
  manager_id UUID,
  manager_name TEXT,
  phone TEXT,
  pax_count INTEGER,
  excursion_date DATE,
  excursion_name TEXT,
  action TEXT,
  created_at TIMESTAMPTZ
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    e.id,
    e.manager_id,
    p.display_name as manager_name,
    e.phone,
    e.pax_count,
    e.excursion_date,
    e.excursion_name,
    e.action,
    e.created_at
  FROM dispatch_mark_events e
  JOIN profiles p ON e.manager_id = p.id
  WHERE e.phone ILIKE '%' || p_phone || '%'
  ORDER BY e.created_at DESC
  LIMIT 100;
END;
$$;

-- 3. Детальная статистика менеджера по экскурсиям
CREATE OR REPLACE FUNCTION get_manager_excursion_stats(
  p_manager_id UUID,
  p_start_date DATE,
  p_end_date DATE
)
RETURNS TABLE (
  excursion_name TEXT,
  excursion_date DATE,
  net_phones BIGINT,
  net_pax BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COALESCE(e.excursion_name, 'Без названия') as excursion_name,
    e.excursion_date,
    (COUNT(CASE WHEN e.action = 'mark' THEN 1 END) - 
     COUNT(CASE WHEN e.action = 'unmark' THEN 1 END))::BIGINT as net_phones,
    (SUM(CASE WHEN e.action = 'mark' THEN e.pax_count ELSE 0 END) - 
     SUM(CASE WHEN e.action = 'unmark' THEN e.pax_count ELSE 0 END))::BIGINT as net_pax
  FROM dispatch_mark_events e
  WHERE e.manager_id = p_manager_id
    AND e.created_at >= p_start_date
    AND e.created_at < p_end_date + INTERVAL '1 day'
  GROUP BY e.excursion_name, e.excursion_date
  ORDER BY e.excursion_date DESC;
END;
$$;

-- 4. Статистика по экскурсиям с разбивкой по менеджерам
CREATE OR REPLACE FUNCTION get_dispatch_excursion_manager_breakdown(
  p_start_date DATE,
  p_end_date DATE
)
RETURNS TABLE (
  excursion_name TEXT,
  excursion_date DATE,
  manager_id UUID,
  manager_name TEXT,
  net_phones BIGINT,
  net_pax BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COALESCE(e.excursion_name, 'Без названия') as excursion_name,
    e.excursion_date,
    e.manager_id,
    p.display_name as manager_name,
    (COUNT(CASE WHEN e.action = 'mark' THEN 1 END) - 
     COUNT(CASE WHEN e.action = 'unmark' THEN 1 END))::BIGINT as net_phones,
    (SUM(CASE WHEN e.action = 'mark' THEN e.pax_count ELSE 0 END) - 
     SUM(CASE WHEN e.action = 'unmark' THEN e.pax_count ELSE 0 END))::BIGINT as net_pax
  FROM dispatch_mark_events e
  JOIN profiles p ON e.manager_id = p.id
  WHERE e.created_at >= p_start_date
    AND e.created_at < p_end_date + INTERVAL '1 day'
  GROUP BY e.excursion_name, e.excursion_date, e.manager_id, p.display_name
  ORDER BY e.excursion_date DESC, excursion_name, net_pax DESC;
END;
$$;

-- Индекс для поиска по телефону
CREATE INDEX IF NOT EXISTS idx_dispatch_mark_events_phone ON dispatch_mark_events(phone);

-- Предоставить доступ к функциям
GRANT EXECUTE ON FUNCTION get_dispatch_stats_by_excursion TO authenticated;
GRANT EXECUTE ON FUNCTION search_dispatch_by_phone TO authenticated;
GRANT EXECUTE ON FUNCTION get_manager_excursion_stats TO authenticated;
GRANT EXECUTE ON FUNCTION get_dispatch_excursion_manager_breakdown TO authenticated;
