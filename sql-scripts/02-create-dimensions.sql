-- 02-create-dimensions.sql
-- DDL Измерения (модель Снежинка / Snowflake)

CREATE TABLE IF NOT EXISTS dim_supplier_location (
    location_id SERIAL PRIMARY KEY,
    address VARCHAR,
    city VARCHAR,
    country VARCHAR
);

CREATE TABLE IF NOT EXISTS dim_supplier (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR,
    contact VARCHAR,
    email VARCHAR,
    phone VARCHAR,
    location_id INT REFERENCES dim_supplier_location(location_id)
);

CREATE TABLE IF NOT EXISTS dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR,
    product_category VARCHAR,
    pet_category VARCHAR,
    product_weight NUMERIC,
    product_color VARCHAR,
    product_size VARCHAR,
    product_brand VARCHAR,
    product_material VARCHAR,
    product_description TEXT,
    product_rating NUMERIC,
    product_reviews INT,
    product_release_date DATE,
    product_expiry_date DATE,
    supplier_id INT REFERENCES dim_supplier(supplier_id)
);

CREATE TABLE IF NOT EXISTS dim_customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    age INT,
    email VARCHAR,
    country VARCHAR,
    postal_code VARCHAR,
    pet_type VARCHAR,
    pet_name VARCHAR,
    pet_breed VARCHAR
);

CREATE TABLE IF NOT EXISTS dim_seller (
    seller_id INT PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    country VARCHAR,
    postal_code VARCHAR
);

CREATE TABLE IF NOT EXISTS dim_store (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR,
    location VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    phone VARCHAR,
    email VARCHAR
);

CREATE TABLE IF NOT EXISTS dim_date (
    date_id INT PRIMARY KEY,
    sale_date DATE,
    day INT,
    month INT,
    year INT,
    quarter INT
);
