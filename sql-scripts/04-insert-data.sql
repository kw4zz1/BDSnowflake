-- 04-insert-data.sql
-- DML Заполнение данных из Staging Area

INSERT INTO dim_supplier_location (address, city, country)
SELECT DISTINCT supplier_address, supplier_city, supplier_country
FROM staging_data
WHERE supplier_address IS NOT NULL;

INSERT INTO dim_supplier (name, contact, email, phone, location_id)
SELECT DISTINCT s.supplier_name, s.supplier_contact, s.supplier_email, s.supplier_phone, loc.location_id
FROM staging_data s
JOIN dim_supplier_location loc 
  ON s.supplier_address = loc.address AND s.supplier_city = loc.city AND s.supplier_country = loc.country;

INSERT INTO dim_product (product_id, product_name, product_category, pet_category, product_weight, product_color, product_size, product_brand, product_material, product_description, product_rating, product_reviews, product_release_date, product_expiry_date, supplier_id)
SELECT DISTINCT ON (s.sale_product_id)
       s.sale_product_id, s.product_name, s.product_category, s.pet_category, s.product_weight, s.product_color, s.product_size, s.product_brand, s.product_material, s.product_description, s.product_rating, s.product_reviews, s.product_release_date, s.product_expiry_date,
       sup.supplier_id
FROM staging_data s
LEFT JOIN dim_supplier sup ON s.supplier_name = sup.name AND s.supplier_email = sup.email;

INSERT INTO dim_customer (customer_id, first_name, last_name, age, email, country, postal_code, pet_type, pet_name, pet_breed)
SELECT DISTINCT ON (sale_customer_id) 
       sale_customer_id, customer_first_name, customer_last_name, customer_age, customer_email, customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed
FROM staging_data;

INSERT INTO dim_seller (seller_id, first_name, last_name, email, country, postal_code)
SELECT DISTINCT ON (sale_seller_id)
       sale_seller_id, seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code
FROM staging_data;

INSERT INTO dim_store (store_name, location, city, state, country, phone, email)
SELECT DISTINCT store_name, store_location, store_city, store_state, store_country, store_phone, store_email
FROM staging_data;

INSERT INTO dim_date (date_id, sale_date, day, month, year, quarter)
SELECT DISTINCT 
    TO_CHAR(sale_date, 'YYYYMMDD')::INT, 
    sale_date, 
    EXTRACT(DAY FROM sale_date), 
    EXTRACT(MONTH FROM sale_date), 
    EXTRACT(YEAR FROM sale_date), 
    EXTRACT(QUARTER FROM sale_date)
FROM staging_data WHERE sale_date IS NOT NULL;

INSERT INTO fact_sales (date_id, customer_id, seller_id, product_id, store_id, sale_quantity, sale_total_price, product_price, inventory_quantity)
SELECT 
    TO_CHAR(s.sale_date, 'YYYYMMDD')::INT,
    s.sale_customer_id,
    s.sale_seller_id,
    s.sale_product_id,
    st.store_id,
    s.sale_quantity,
    s.sale_total_price,
    s.product_price,
    s.product_quantity
FROM staging_data s
JOIN dim_store st 
  ON s.store_name = st.store_name AND s.store_city = st.city AND s.store_email = st.email;
