-- PostgreSQL example in DBeaver
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price NUMERIC(10,2) CHECK (price > 0),
    stock_quantity INT DEFAULT 0
);

-- MySQL example in DBeaver
DELIMITER //
CREATE PROCEDURE UpdateProductStock(IN p_product_id INT, IN p_quantity INT)
BEGIN
    UPDATE products 
    SET stock_quantity = stock_quantity + p_quantity
    WHERE product_id = p_product_id;
    
    SELECT product_name, stock_quantity 
    FROM products
    WHERE product_id = p_product_id;
END //
DELIMITER ;

-- SQLite example in DBeaver
CREATE TABLE IF NOT EXISTS logs (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    action TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER,
    details TEXT
);

-- Oracle example in DBeaver
CREATE OR REPLACE TRIGGER trg_product_audit
AFTER INSERT OR UPDATE OR DELETE ON products
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO product_audit VALUES ('INSERT', :NEW.product_id, SYSDATE);
    ELSIF UPDATING THEN
        INSERT INTO product_audit VALUES ('UPDATE', :NEW.product_id, SYSDATE);
    ELSIF DELETING THEN
        INSERT INTO product_audit VALUES ('DELETE', :OLD.product_id, SYSDATE);
    END IF;
END;
