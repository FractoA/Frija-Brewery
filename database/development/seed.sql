-- ============================================================
-- IMPORTED BEER DISTRIBUTOR
-- DEVELOPMENT DATABASE - TEST DATA
-- ============================================================

USE imported_beer_distributor_dev;

-- ============================================================
-- 1. BRANCHES
-- ============================================================

INSERT INTO branches
(branch_id, name, city, address, phone, status)
VALUES
(1, 'Tijuana Branch', 'Tijuana', 'Zona Centro', '6641234567', 'ACTIVE'),
(2, 'Mexicali Branch', 'Mexicali', 'Zona Centro', '6861234567', 'ACTIVE'),
(3, 'Monterrey Branch', 'Monterrey', 'Zona Centro', '8181234567', 'ACTIVE'),
(4, 'Guadalajara Branch', 'Guadalajara', 'Zona Centro', '3311234567', 'ACTIVE');
