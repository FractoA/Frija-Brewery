-- IMPORTED BEER DISTRIBUTOR
-- DATABASE SCHEMA

CREATE DATABASE IF NOT EXISTS imported_beer_distributor_dev
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE imported_beer_distributor_dev;

-- ============================================================
-- 1. BRANCHES
-- ============================================================

CREATE TABLE branches (
    branch_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    address VARCHAR(150) NOT NULL,
    phone VARCHAR(15),
    status ENUM('ACTIVE','INACTIVE','CLOSED')
        NOT NULL DEFAULT 'ACTIVE',

    INDEX idx_branch_city (city)
) ENGINE=InnoDB;


-- ============================================================
-- 2. USERS
-- ============================================================

CREATE TABLE users (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    paternal_last_name VARCHAR(50) NOT NULL,
    maternal_last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(255),
    role ENUM(
        'ADMIN',
        'MANAGER',
        'SALES',
        'INVENTORY',
        'CUSTOMER'
    ) NOT NULL,
    branch_id INT UNSIGNED NULL,
    status ENUM(
        'ACTIVE',
        'SUSPENDED',
        'BLOCKED'
    ) NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT fk_user_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id),

    INDEX idx_user_branch (branch_id),
    INDEX idx_user_role (role),
    INDEX idx_user_status (status)
) ENGINE=InnoDB;


-- ============================================================
-- 3. BRANDS
-- ============================================================

CREATE TABLE brands (
    brand_id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE,
    country_of_origin VARCHAR(50) NOT NULL,
    status ENUM('ACTIVE','INACTIVE')
        NOT NULL DEFAULT 'ACTIVE'
) ENGINE=InnoDB;


-- ============================================================
-- 4. CATEGORIES
-- ============================================================

CREATE TABLE categories (
    category_id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(40) NOT NULL UNIQUE,
    description VARCHAR(150),
    status ENUM('ACTIVE','INACTIVE')
        NOT NULL DEFAULT 'ACTIVE'
) ENGINE=InnoDB;


-- ============================================================
-- 5. PRODUCTS
-- ============================================================

CREATE TABLE products (
    product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand_id SMALLINT UNSIGNED NOT NULL,
    category_id SMALLINT UNSIGNED NOT NULL,
    presentation VARCHAR(30) NOT NULL,
    content_ml SMALLINT UNSIGNED NOT NULL,
    alcohol_content DECIMAL(4,2) NOT NULL,
    sale_price DECIMAL(10,2) NOT NULL,
    status ENUM(
        'ACTIVE',
        'INACTIVE',
        'DISCONTINUED'
    ) NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT fk_product_brand
        FOREIGN KEY (brand_id)
        REFERENCES brands(brand_id),

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    INDEX idx_product_brand (brand_id),
    INDEX idx_product_category (category_id),
    INDEX idx_product_status (status)
) ENGINE=InnoDB;


-- ============================================================
-- 6. SUPPLIERS
-- ============================================================

CREATE TABLE suppliers (
    supplier_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    contact VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    country VARCHAR(50) NOT NULL,
    status ENUM(
        'ACTIVE',
        'INACTIVE',
        'SUSPENDED'
    ) NOT NULL DEFAULT 'ACTIVE',

    INDEX idx_supplier_country (country),
    INDEX idx_supplier_status (status)
) ENGINE=InnoDB;


-- ============================================================
-- 7. IMPORTS
-- ============================================================

CREATE TABLE imports (
    import_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT UNSIGNED NOT NULL,
    import_date DATE NOT NULL,
    document_number VARCHAR(30) NOT NULL UNIQUE,
    status ENUM(
        'PENDING',
        'IN_TRANSIT',
        'RECEIVED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'PENDING',

    CONSTRAINT fk_import_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id),

    INDEX idx_import_supplier (supplier_id),
    INDEX idx_import_date (import_date),
    INDEX idx_import_status (status)
) ENGINE=InnoDB;


-- ============================================================
-- 8. IMPORT_DETAILS
-- ============================================================

CREATE TABLE import_details (
    import_detail_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    import_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    unit_cost DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_import_detail_import
        FOREIGN KEY (import_id)
        REFERENCES imports(import_id),

    CONSTRAINT fk_import_detail_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT uk_import_detail
        UNIQUE (import_id, product_id),

    INDEX idx_import_detail_product (product_id)
) ENGINE=InnoDB;


-- ============================================================
-- 9. INVENTORY
-- ============================================================

CREATE TABLE inventory (
    inventory_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    stock INT UNSIGNED NOT NULL DEFAULT 0,
    minimum_stock INT UNSIGNED NOT NULL DEFAULT 0,
    last_update TIMESTAMP
        NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_inventory_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id),

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT uk_inventory
        UNIQUE (branch_id, product_id),

    INDEX idx_inventory_product (product_id)
) ENGINE=InnoDB;


-- ============================================================
-- 10. SALES
-- ============================================================

CREATE TABLE sales (
    sale_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id INT UNSIGNED NOT NULL,
    salesperson_id INT UNSIGNED NOT NULL,
    customer_id INT UNSIGNED,
    date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    subtotal DECIMAL(12,2) NOT NULL,
    tax DECIMAL(12,2) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    status ENUM(
        'PENDING',
        'PAID',
        'CANCELLED'
    ) NOT NULL DEFAULT 'PENDING',

    CONSTRAINT fk_sale_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id),

    CONSTRAINT fk_sale_salesperson
        FOREIGN KEY (salesperson_id)
        REFERENCES users(user_id),

    CONSTRAINT fk_sale_customer
        FOREIGN KEY (customer_id)
        REFERENCES users(user_id),

    INDEX idx_sale_branch (branch_id),
    INDEX idx_sale_salesperson (salesperson_id),
    INDEX idx_sale_customer (customer_id),
    INDEX idx_sale_date (date),
    INDEX idx_sale_status (status)
) ENGINE=InnoDB;


-- ============================================================
-- 11. SALE_DETAILS
-- ============================================================

CREATE TABLE sale_details (
    sale_detail_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sale_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity SMALLINT UNSIGNED NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_sale_detail_sale
        FOREIGN KEY (sale_id)
        REFERENCES sales(sale_id),

    CONSTRAINT fk_sale_detail_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT uk_sale_detail
        UNIQUE (sale_id, product_id),

    INDEX idx_sale_detail_product (product_id)
) ENGINE=InnoDB;


-- ============================================================
-- 12. PAYMENTS
-- ============================================================

CREATE TABLE payments (
    payment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sale_id INT UNSIGNED NOT NULL,
    payment_method ENUM(
        'CASH',
        'CARD',
        'TRANSFER'
    ) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM(
        'PENDING',
        'COMPLETED',
        'REJECTED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'PENDING',

    CONSTRAINT fk_payment_sale
        FOREIGN KEY (sale_id)
        REFERENCES sales(sale_id),

    INDEX idx_payment_sale (sale_id),
    INDEX idx_payment_status (status)
) ENGINE=InnoDB;


-- ============================================================
-- 13. SHIPMENTS
-- ============================================================

CREATE TABLE shipments (
    shipment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id INT UNSIGNED NOT NULL,
    branch_id INT UNSIGNED NOT NULL,
    shipment_date DATETIME,
    delivery_date DATETIME,
    delivery_address VARCHAR(150) NOT NULL,
    status ENUM(
        'PENDING',
        'PREPARING',
        'SHIPPED',
        'DELIVERED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'PENDING',

    CONSTRAINT fk_shipment_customer
        FOREIGN KEY (customer_id)
        REFERENCES users(user_id),

    CONSTRAINT fk_shipment_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id),

    INDEX idx_shipment_customer (customer_id),
    INDEX idx_shipment_branch (branch_id),
    INDEX idx_shipment_status (status)
) ENGINE=InnoDB;


-- ============================================================
-- 14. SHIPMENT_DETAILS
-- ============================================================

CREATE TABLE shipment_details (
    shipment_detail_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    shipment_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,

    CONSTRAINT fk_shipment_detail_shipment
        FOREIGN KEY (shipment_id)
        REFERENCES shipments(shipment_id),

    CONSTRAINT fk_shipment_detail_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT uk_shipment_detail
        UNIQUE (shipment_id, product_id),

    INDEX idx_shipment_detail_product (product_id)
) ENGINE=InnoDB;


-- ============================================================
-- 15. INVENTORY_MOVEMENTS
-- ============================================================

CREATE TABLE inventory_movements (
    movement_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    type ENUM(
        'IN',
        'OUT',
        'ADJUSTMENT'
    ) NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reason VARCHAR(100),

    CONSTRAINT fk_movement_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id),

    CONSTRAINT fk_movement_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    INDEX idx_movement_branch (branch_id),
    INDEX idx_movement_product (product_id),
    INDEX idx_movement_date (date)
) ENGINE=InnoDB;
