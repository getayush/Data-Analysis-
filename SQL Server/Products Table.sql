CREATE TABLE Products (
    ProductID CHAR(1) PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
('A', 'Widget X', 'Gadgets', 25.75),
('B', 'Widget Y', 'Gadgets', 15.50),
('C', 'Gizmo Z', 'Tools', 22.90),
('D', 'Gizmo W', 'Tools', 19.95),
('E', 'Thing A', 'Apparel', 9.99),
('F', 'Thing B', 'Apparel', 12.49),
('G', 'Gadget A', 'Electronics', 45.00),
('H', 'Gadget B', 'Electronics', 55.00),
('I', 'Tool A', 'Hardware', 17.75),
('J', 'Tool B', 'Hardware', 21.25),
('K', 'Accessory A', 'Jewelry', 75.00),
('L', 'Accessory B', 'Jewelry', 95.00),
('M', 'Appliance A', 'Home Goods', 299.99),
('N', 'Appliance B', 'Home Goods', 349.99),
('O', 'Software A', 'Software', 129.99),
('P', 'Software B', 'Software', 199.99);

select * from Products