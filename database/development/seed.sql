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

-- ============================================================
-- 2. USERS
-- ============================================================

INSERT INTO users
(
    user_id,
    first_name,
    paternal_last_name,
    maternal_last_name,
    email,
    phone,
    password,
    role,
    branch_id,
    status
)
VALUES
(1, 'Carlos', 'Ramirez', 'Lopez',
 'admin@frija.com', '6641111111', '$2b$12$HASH_DE_PRUEBA',
 'ADMIN', 1, 'ACTIVE'),

(2, 'Ana', 'Garcia', 'Torres',
 'manager@frija.com', '6642222222', '$2b$12$HASH_DE_PRUEBA',
 'MANAGER', 1, 'ACTIVE'),

(3, 'Luis', 'Hernandez', 'Mora',
 'sales@frija.com', '6863333333', '$2b$12$HASH_DE_PRUEBA',
 'SALES', 2, 'ACTIVE'),

(4, 'Maria', 'Fernandez', 'Cruz',
 'inventory@frija.com', '8184444444', '$2b$12$HASH_DE_PRUEBA',
 'INVENTORY', 3, 'ACTIVE'),

(5, 'Jorge', 'Sanchez', 'Diaz',
 'customer@frija.com', '3315555555', '$2b$12$HASH_DE_PRUEBA',
 'CUSTOMER', NULL, 'ACTIVE');

-- ============================================================
-- 3. BRANDS
-- ============================================================

INSERT INTO brands (brand_id, name, country_of_origin, status)
VALUES
(1, 'Heineken', 'Netherlands', 'ACTIVE'),
(2, 'Corona', 'Mexico', 'ACTIVE'),
(3, 'Guinness', 'Ireland', 'ACTIVE');
-- ============================================================
-- 4. CATEGORIES
-- ============================================================
INSERT INTO categories
(category_id, name, description, status)
VALUES
(1, 'Lager', 'Light and refreshing beer', 'ACTIVE'),
(2, 'Pilsner', 'Crisp and balanced beer', 'ACTIVE'),
(3, 'Stout', 'Dark and roasted beer', 'ACTIVE');

-- ============================================================
-- 5. PRODUCTS
-- ============================================================
INSERT INTO products
(
    product_id,
    name,
    brand_id,
    category_id,
    presentation,
    content_ml,
    alcohol_content,
    sale_price,
    status
)
VALUES
(1, 'Heineken Original', 1, 1, 'Bottle', 355, 5.00, 35.00, 'ACTIVE'),
(2, 'Heineken Silver', 1, 2, 'Bottle', 355, 4.00, 37.00, 'ACTIVE'),
(3, 'Corona Extra', 2, 1, 'Bottle', 355, 4.50, 32.00, 'ACTIVE'),
(4, 'Corona Familiar', 2, 1, 'Bottle', 940, 4.50, 55.00, 'ACTIVE'),
(5, 'Guinness Draught', 3, 3, 'Can', 440, 4.20, 55.00, 'ACTIVE'),
(6, 'Guinness Extra Stout', 3, 3, 'Bottle', 330, 5.60, 48.00, 'ACTIVE');

-- ============================================================
-- 6. SUPPLIERS
-- ============================================================

INSERT INTO suppliers
(
    supplier_id,
    company_name,
    contact,
    phone,
    email,
    country,
    status
)
VALUES
(1, 'Heineken International', 'Peter Smith',
 '+31101234567', 'contact@heineken.com',
 'Netherlands', 'ACTIVE'),

(2, 'Grupo Modelo', 'Roberto Garcia',
 '+525512345678', 'contact@grupomodelo.com',
 'Mexico', 'ACTIVE'),

(3, 'Guinness Brewery', 'James Wilson',
 '+35312345678', 'contact@guinness.com',
 'Ireland', 'ACTIVE');

-- ============================================================
-- 7. IMPORTS
-- ============================================================
INSERT INTO imports
(
    import_id,
    supplier_id,
    import_date,
    document_number,
    status
)
VALUES
(1, 1, '2026-10-15', 'IMP-2026-001', 'RECEIVED'),
(2, 2, '2026-10-20', 'IMP-2026-002', 'IN_TRANSIT'),
(3, 3, '2026-10-25', 'IMP-2026-003', 'PENDING');

-- ============================================================
-- 8. IMPORT_DETAILS
-- ============================================================

INSERT INTO import_details
(
    import_detail_id,
    import_id,
    product_id,
    quantity,
    unit_cost
)
VALUES
(1, 1, 1, 500, 22.00),
(2, 1, 2, 300, 23.00),
(3, 2, 3, 600, 20.00),
(4, 2, 4, 200, 38.00),
(5, 3, 5, 250, 36.00),
(6, 3, 6, 350, 31.00);

-- ============================================================
-- 9. INVENTORY
-- ============================================================
INSERT INTO inventory
(inventory_id, branch_id, product_id, stock, minimum_stock)
VALUES
(1, 1, 1, 150, 25),
(2, 1, 2, 100, 20),
(3, 1, 3, 200, 30),
(4, 2, 3, 180, 25),
(5, 2, 4, 80, 15),
(6, 3, 5, 120, 20),
(7, 3, 6, 90, 15),
(8, 4, 1, 110, 25);

-- ============================================================
-- 10. SALES
-- ============================================================

INSERT INTO sales
(
    sale_id,
    branch_id,
    salesperson_id,
    customer_id,
    `date`,
    subtotal,
    tax,
    total,
    status
)
VALUES
(1, 2, 3, 5, '2026-11-01 10:30:00',
 320.00, 51.20, 371.20, 'PAID'),

(2, 2, 3, 5, '2026-11-02 12:15:00',
 550.00, 88.00, 638.00, 'PAID'),

(3, 2, 3, 5, '2026-11-03 16:45:00',
 480.00, 76.80, 556.80, 'PENDING');

-- ============================================================
-- 11. SALE_DETAILS
-- ============================================================

INSERT INTO sale_details
(
    sale_detail_id,
    sale_id,
    product_id,
    quantity,
    unit_price
)
VALUES
(1, 1, 3, 10, 32.00),
(2, 2, 4, 10, 55.00),
(3, 3, 6, 10, 48.00);

-- ============================================================
-- 12. PAYMENTS
-- ============================================================

INSERT INTO payments
(
    payment_id,
    sale_id,
    payment_method,
    amount,
    payment_date,
    status
)
VALUES
(1, 1, 'CASH', 371.20, '2026-11-01 10:35:00', 'COMPLETED'),
(2, 2, 'CARD', 638.00, '2026-11-02 12:20:00', 'COMPLETED'),
(3, 3, 'TRANSFER', 556.80, '2026-11-03 16:50:00', 'PENDING');

-- ============================================================
-- 13. SHIPMENTS
-- ============================================================

INSERT INTO shipments
(
    shipment_id,
    customer_id,
    branch_id,
    shipment_date,
    delivery_date,
    delivery_address,
    status
)
VALUES
(1, 5, 1, '2026-11-01 11:00:00',
 '2026-11-01 14:00:00',
 'Zona Centro, Tijuana', 'DELIVERED'),

(2, 5, 2, '2026-11-02 13:00:00',
 '2026-11-02 17:00:00',
 'Zona Centro, Mexicali', 'SHIPPED'),

(3, 5, 4, '2026-11-03 09:00:00',
 NULL,
 'Zona Centro, Guadalajara', 'PENDING');

-- ============================================================
-- 14. SHIPMENT_DETAILS
-- ============================================================

INSERT INTO shipment_details
(
    shipment_detail_id,
    shipment_id,
    product_id,
    quantity
)
VALUES
(1, 1, 1, 12),
(2, 1, 3, 6),
(3, 2, 4, 8),
(4, 2, 2, 10),
(5, 3, 5, 6);

-- ============================================================
-- 15. INVENTORY_MOVEMENTS
-- ============================================================

INSERT INTO inventory_movements
(
    movement_id,
    branch_id,
    product_id,
    type,
    quantity,
    date,
    reason
)
VALUES
(1, 1, 1, 'IN', 100, '2026-11-01 08:00:00',
 'Initial stock entry'),

(2, 1, 3, 'IN', 150, '2026-11-01 08:30:00',
 'Initial stock entry'),

(3, 1, 1, 'OUT', 20, '2026-11-02 10:00:00',
 'Product sale'),

(4, 2, 3, 'IN', 120, '2026-11-02 09:00:00',
 'Supplier delivery'),

(5, 2, 4, 'OUT', 15, '2026-11-02 14:00:00',
 'Product sale'),

(6, 3, 5, 'IN', 80, '2026-11-03 08:00:00',
 'Supplier delivery'),

(7, 3, 6, 'ADJUSTMENT', 5, '2026-11-03 15:00:00',
 'Inventory correction'),

(8, 4, 1, 'IN', 60, '2026-11-03 09:00:00',
 'Stock replenishment');
