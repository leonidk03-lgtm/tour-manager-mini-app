-- Добавление политики DELETE для администраторов
-- Выполните этот скрипт в Supabase SQL Editor

-- Удаляем политику если существует, затем создаем заново
DROP POLICY IF EXISTS "Admins can delete events" ON dispatch_mark_events;

CREATE POLICY "Admins can delete events" ON dispatch_mark_events
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );
