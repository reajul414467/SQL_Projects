create database Company_db;
USE Company_db;

create table Products(
Product_ID INT primary key,
Product_Name varchar (100),
Category varchar (50)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    customer_id INT,
    region VARCHAR(50),
    product_id INT,
    quantity INT,
    sales_amount DECIMAL(10,2),
    order_date DATE,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);

INSERT INTO product VALUES
(101,'Laptop','Electronics'),
(102,'Mouse','Electronics'),
(103,'Keyboard','Electronics'),
(104,'Chair','Furniture'),
(105,'Table','Furniture'),
(106,'Notebook','Stationery'),
(107,'Pen','Stationery'),
(108,'Monitor','Electronics'),
(109,'Printer','Electronics'),
(110,'Cabinet','Furniture');

INSERT INTO product VALUES
(111, 'Calculator', 'Electronics'),
(112, 'Camera', 'Electronics');

INSERT INTO customers VALUES
(1,'Rahim'),
(2,'Karim'),
(3,'Nusrat'),
(4,'Sadia'),
(5,'Hasan'),
(6,'Jamal'),
(7,'Mim'),
(8,'Tanvir'),
(9,'Rafi'),
(10,'Sakib');

INSERT INTO customers values
(11, 'Reaj'),
(12, 'Reja');

INSERT INTO sales VALUES
(1001,1,'Dhaka',101,2,1200,'2025-01-10'),
(1002,2,'Dhaka',102,5,500,'2025-01-15'),
(1003,3,'Chattogram',104,3,900,'2025-02-01'),
(1004,4,'Khulna',106,10,300,'2025-02-05'),
(1005,5,'Rajshahi',108,2,700,'2025-03-11'),
(1006,6,'Dhaka',109,1,800,'2025-03-15'),
(1007,7,'Sylhet',110,2,1000,'2025-04-08'),
(1008,8,'Chattogram',101,1,600,'2025-04-18'),
(1009,9,'Khulna',103,4,400,'2025-05-12'),
(1010,10,'Rajshahi',105,1,500,'2025-05-20'),
(1011,2,'Dhaka',107,20,200,'2025-06-02'),
(1012,5,'Sylhet',108,3,900,'2025-06-15'),
(1013,6,'Dhaka',101,2,1200,'2025-07-01'),
(1014,8,'Chattogram',104,2,700,'2025-07-10'),
(1015,10,'Khulna',109,1,850,'2025-07-18');

INSERT INTO sales VALUES
(1016,11,'Dhaka',111,2,900,'2025-11-18'),
(1017,12,'Cumilla',112,3,1100,'2025-12-15');

describe sales;
show create table sales

SELECT * FROM product;
SELECT * FROM customers;
SELECT * FROM sales;

SELECT
s.order_id,
c.customer_name,
p.product_name,
p.category,
s.region,
s.quantity,
s.sales_amount,
s.order_date
FROM sales s
INNER JOIN customers c
ON s.customer_id = c.customer_id
INNER JOIN product p
ON s.product_id = p.product_id;

Select avg(sales_amount)
from sales;

SELECT product_name
FROM product
WHERE product_id IN
(
SELECT product_id
FROM sales
WHERE sales_amount >
(
SELECT AVG(sales_amount)
FROM sales
)
);

Select region,
sum(sales_amount) as Total_Sales
From sales
group by Region;

SELECT *
FROM
(
SELECT
region,
SUM(sales_amount) AS Total_Sales
FROM sales
GROUP BY region
) AS RegionSales
WHERE Total_Sales >
(
SELECT AVG(region_total)
FROM
(
SELECT SUM(sales_amount) AS region_total
FROM sales
GROUP BY region
) AS AvgTable
);

SELECT
s.region,
p.category,
SUM(s.sales_amount) AS Total_Sales
FROM sales s
JOIN product p
ON s.product_id = p.product_id
GROUP BY
s.region,
p.category;

SELECT
region,
SUM(sales_amount) AS Total_Sales
FROM sales
GROUP BY region
HAVING SUM(sales_amount) > 1500;


SELECT
(
SELECT SUM(sales_amount)
FROM sales
) AS Total_Sales,

(
SELECT AVG(sales_amount)
FROM sales
) AS Average_Sales;

Select
month(order_date) as Month,
Sum(Sales_amount) as Total_sales
from sales
group by month (order_date)
order by month;

SELECT
c.customer_name,
SUM(s.sales_amount) AS Total_Sales
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY Total_Sales DESC
LIMIT 5;

SELECT * FROM product;

SELECT * FROM customers;

SELECT * FROM sales;

SELECT COUNT(*) FROM product;

SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM sales;