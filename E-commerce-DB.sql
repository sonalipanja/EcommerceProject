-- Create Database
CREATE DATABASE ecommerce;

-- Use the Database
USE ecommerce;

-- Create Tables

-- 1. users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 3. categories table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- 4. orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 5. order_items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 6. payments table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 7. shipments table
CREATE TABLE shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipment_status VARCHAR(50),
    tracking_number VARCHAR(100),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 8. reviews table
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 9. discounts table
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_code VARCHAR(50) NOT NULL,
    discount_percentage DECIMAL(5, 2) NOT NULL,
    valid_until DATE
);

-- 10. inventory table
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    stock INT DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Insert categories
INSERT INTO categories (category_name) VALUES 
('Electronics'), ('Clothing'), ('Books'), ('Toys');

-- Insert products
INSERT INTO products (product_name, description, price, category_id, stock) VALUES 
('Smartphone', 'Latest model smartphone', 699.99, 1, 50),
('T-Shirt', '100% cotton t-shirt', 19.99, 2, 200),
('Novel', 'Fiction book by famous author', 9.99, 3, 100),
('Toy Car', 'Battery-operated toy car', 24.99, 4, 150);

-- Insert users
INSERT INTO users (username, email, password) VALUES 
('johndoe', 'john@example.com', 'password123'),
('janedoe', 'jane@example.com', 'password456');

-- Insert orders
INSERT INTO orders (user_id, total_amount, payment_status) VALUES 
(1, 719.99, 'Paid'),
(2, 29.98, 'Pending');

-- Insert order_items
INSERT INTO order_items (order_id, product_id, quantity, price_per_unit) VALUES 
(1, 1, 1, 699.99),
(2, 2, 2, 19.99);

-- Insert payments
INSERT INTO payments (order_id, payment_method, amount) VALUES 
(1, 'Credit Card', 719.99);

-- Insert shipments
INSERT INTO shipments (order_id, shipment_status, tracking_number) VALUES 
(1, 'Shipped', 'TRACK123');

-- Insert reviews
INSERT INTO reviews (product_id, user_id, rating, comment) VALUES 
(1, 1, 5, 'Excellent product!'),
(2, 2, 4, 'Good quality t-shirt.');

-- Insert discounts
INSERT INTO discounts (discount_code, discount_percentage, valid_until) VALUES 
('SAVE10', 10.00, '2024-12-31');

-- Insert inventory updates
INSERT INTO inventory (product_id, stock) VALUES 
(1, 50),
(2, 200),
(3, 100),
(4, 150);

select *
from ecommerce.categories;
select *
from discounts;
select *
from inventory;


