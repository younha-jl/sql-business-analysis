-- Create Customers Table
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    age INT
);

-- Create Sales Table
CREATE TABLE sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    customer_id VARCHAR(50),
    product_category VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10, 2),
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);