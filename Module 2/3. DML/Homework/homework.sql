-- Question No. 2
CREATE TABLE customers (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    phone VARCHAR(15) UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE orders (
    id INT NOT NULL AUTO_INCREMENT,
    date DATE, PRIMARY KEY(id)
);

CREATE TABLE order_details (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    item_id INT NOT NULL
);

ALTER TABLE order_details ADD FOREIGN KEY (order_id) REFERENCES orders (id);
ALTER TABLE order_details ADD FOREIGN KEY (customer_id) REFERENCES customers (id);
ALTER TABLE order_details ADD FOREIGN KEY (item_id) REFERENCES items (id);

-- Question No. 3
INSERT INTO `customers` VALUES (1,'Tjandra Darmo','+6281311709980'),(2,'Erick Budiawan','+6281311708880'),(3,'Budiawan','+628131238880'),(4,'Agnes Agustin','+628134898880'),(5,'Crystal','+6281319908880');

INSERT INTO `orders` VALUES (1,'2020-02-20'),(2,'2021-03-21'),(3,'2020-12-21'),(4,'2021-01-21'),(5,'2020-05-11');

INSERT INTO `order_details` VALUES (1,5,1),(1,5,2),(1,5,3),(1,5,4),(2,4,5),(2,4,6),(2,4,7),(2,4,8),(3,3,8),(3,3,1),(3,3,3),(3,3,5),(4,2,5),(4,2,7),(4,2,8),(5,1,1),(5,1,2),(5,1,5);

-- Question No. 4
SELECT orders.id AS 'Order ID', orders.date AS 'Order Date', customers.name AS 'Customer name', customers.phone AS 'Customer phone', SUM(items.price) AS 'Total', GROUP_CONCAT(items.name SEPARATOR
', ') AS 'Items bought'  FROM orders JOIN order_details ON order_details.order_id = orders.id JOIN customers ON customers.id = order_details.customer_id JOIN items ON order_details.item_id = items.id GRO
UP BY orders.id, customers.name, customers.phone;