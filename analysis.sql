CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    transaction_date DATE,
    customer_id VARCHAR(20),
    gender VARCHAR(10),
    age INT,
    product_category VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10, 2),
    total_amount DECIMAL(10, 2)
);

-- create dim_customers table if does'nt exist
CREATE TABLE IF NOT EXISTS dim_customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    age INT
);

-- injection
INSERT INTO dim_customers (customer_id, gender, age)
SELECT DISTINCT customer_id, gender, age 
FROM retail_sales;

CREATE TABLE IF NOT EXISTS dim_products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_category VARCHAR(50),
    price_per_unit DECIMAL(10, 2)
);

INSERT INTO dim_products (product_category, price_per_unit)
SELECT DISTINCT product_category, price_per_unit 
FROM retail_sales;


CREATE TABLE IF NOT EXISTS fact_sales (
    transaction_id INT PRIMARY KEY,
    transaction_date DATE,
    customer_id VARCHAR(20),
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id)
);
