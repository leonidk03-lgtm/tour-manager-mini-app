-- DELETE ALL RENTAL DATA
-- WARNING: This action is irreversible!
-- Run this in Supabase SQL Editor

-- First delete dependent tables (in order of dependencies)
DELETE FROM rental_order_services;
DELETE FROM rental_order_history;
DELETE FROM rental_payments;
DELETE FROM rental_commissions;
DELETE FROM rental_orders;
DELETE FROM rental_clients;

-- Verify deletion
SELECT 'rental_clients' as table_name, COUNT(*) as remaining FROM rental_clients
UNION ALL
SELECT 'rental_orders', COUNT(*) FROM rental_orders
UNION ALL
SELECT 'rental_payments', COUNT(*) FROM rental_payments;
