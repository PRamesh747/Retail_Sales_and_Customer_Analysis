---Project Overview.
/*This project focuses on analysing retail sales and customer data using SQL.
The database contains two main tables: Customers and Orders. 
These tables provide information about customer details, geographical locations, customer segments, product categories, order quantities, unit prices and order dates.
The objective of this project was to investigate business questions relating to customer activity, sales performance, revenue, product categories and customer-order relationships.
I developed 70 SQL queries, progressing from basic data retrieval and filtering to aggregate functions, different types of joins and subqueries.The project demonstrates how SQL can be used to extract information, combine related datas.*/
---------------------------------------------------------------------------------------------------

--Selecting the database

USE Imeta

--Understanding the data

SELECT *
FROM Customers;

SELECT *
FROM Orders;
-----------------------------------------------------------------------------------------
---Part A - Data Retrieval and Filtering 
--Business objective: Explore customer and order records and retrieve information based on specific business requirements.

--Q1  Show every column in Customers.

SELECT * FROM Customers

--Q2  Show CustomerName and City only.​

SELECT CustomerName, City from Customers

--Q3 Show all customers in London.​

SELECT * FROM Customers
WHERE City = 'London';

--Q4 Show unique Region values.

 SELECT DISTINCT Region FROM Customers

--Q5 List customers ordered by name A–Z.​

SELECT * FROM Customers
ORDER BY CustomerName ASC

--Q6 Show Business Customers

SELECT * FROM Customers
WHERE Segment = 'Business'

--Q7 Show customers from Leeds or Bristol.​

SELECT * FROM Customers
WHERE City = 'Leeds' OR City  = 'Bristol'

--Q8 List orders with Quantity at least 4.​

SELECT * FROM Orders
WHERE Quantity >= 4;

--Q9 Show Electronics orders, newest first.​

SELECT * FROM Orders
WHERE Category = 'Electronics'
ORDER BY OrderDate DESC;

--Q10 Show orders priced over £100, low to high.​

SELECT * FROM Orders
WHERE  UnitPrice > 100
ORDER BY UnitPrice ASC

------------------------------------------------------------------
---Part B – Aggregate Functions and Business Metrics
--Business objective: Calculate key business measures to understand customer numbers, order volumes, pricing and sales revenue.

--Q1 Count all Customers

SELECT COUNT(CustomerName) AS CustomerCount
FROM Customers

--Q2 Count all Orders

SELECT COUNT(OrderID) AS OrderCount
FROM Orders

--Q3 Count Orders with Non NULL Customer ID

SELECT COUNT(CustomerID) AS OrderswithCustomerID
FROM Orders

--Q4 Find the total quantity sold

SELECT SUM(Quantity) AS TotalQuantitySold
FROM Orders

--Q5 Find the average unit price

SELECT ROUND(AVG(UnitPrice), 2) AS AvgUnitPrice
FROM Orders

--Q6 Find the smallest and largest Unit price

SELECT ROUND(MAX(UnitPrice), 2)    AS    LargestUnitPrice,
       ROUND(MIN(UnitPrice), 2)    AS    SmallestUnitPrice
FROM Orders

--Q7 Count Customers in each region

SELECT Region, COUNT(*)   AS   CustomersInRegion
FROM Customers
GROUP BY Region

--Q8 Find sales revenue for each category

SELECT Category, SUM(Quantity * UnitPrice) AS SalesRevenue
FROM Orders
GROUP BY Category;

--Q9 Show Categories with over 15 orders

SELECT Category,COUNT(*) AS OrdersCount
FROM Orders
GROUP BY CATEGORY
HAVING COUNT(*) > 15;

--Q10 Show segments with at least 30 customers

SELECT Segment, COUNT(*) AS CustomerCount
FROM Customers
GROUP BY Segment
HAVING COUNT(*) >= 30;

------------------------------------------------------------------------

---Part C – INNER JOIN Analysis
--Business objective: Combine customer and order records to analyse transactions linked to existing customers.

--Q1 Show customer name with each matched OrderID.

SELECT c.CustomerName, o.OrderID FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q2  Show name, category and quantity for matched orders.

SELECT c.CustomerName, o.Category, o.Quantity FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q3 Count matched order rows.

SELECT COUNT(o.OrderID) FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q4 Show London customers’ matched orders.

SELECT c.CustomerName, o.OrderID FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.City = 'London';

--Q5 Show matched Electronics orders.

SELECT c.CustomerName, o.OrderID FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE o.Category = 'Electronics';

--Q6 Calculate revenue per matched order.

SELECT c.CustomerName, o.OrderID, o.Quantity * o.UnitPrice AS Revenue FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q7 Count matched orders per customer

SELECT c.CustomerName, COUNT(o.OrderID) AS TotalCustomerOrders FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

--Q8 Show matched orders with quantity at least 4.

SELECT c.CustomerName, o.OrderID, o.Quantity FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE o.Quantity >= 4;

--Q9 Show Business customers’ matched orders.

SELECT c.CustomerName, o.OrderID FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.Segment = 'Business'

--Q10 Show matched orders sorted newest first.

SELECT c.CustomerName, o.OrderID,o.OrderDate FROM Customers AS c
INNER JOIN Orders as o ON
c.CustomerID = o.CustomerID
ORDER BY o.OrderDate DESC;

-----------------------------------------------------------------------------------

---Part D – LEFT JOIN Analysis
--Business objective: Retain all customer records, including customers who may not have placed an order.

--Q1  Show all customers with any OrderID.

SELECT c.CustomerName, o.OrderID FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q2  Show customers who have no orders.

SELECT c.CustomerName, c.CustomerID FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

--Q3 Count customers with no orders.

SELECT COUNT(c.CustomerName) AS NoOrderCustomers FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

--Q4 Count orders per customer, including zero.

SELECT c.CustomerName, COUNT(o.OrderID) AS OrdersPerCustomer FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

--Q5 Show all customers and any order category.

SELECT c.CustomerName, o.Category  FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q6 Find total revenue by customer, including zeros.

SELECT c.CustomerName, o.Quantity * o.UnitPrice AS RevenuePerCustomer  FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q7 Show London customers even without orders.

SELECT c.CustomerName, c.CustomerID  FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.City = 'London';

--Q8 Count distinct customers who placed an order.

SELECT COUNT( DISTINCT c.CustomerName) AS DistinctCustomers FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE o.OrderID IS NOT NULL;

--Q9 List no-order customers alphabetically.

SELECT c.CustomerName FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
ORDER BY c.CustomerName ASC;

--Q10 Show customer IDs and their latest order date.

SELECT c.CustomerID, MAX(o.OrderDate) AS LatestOrder  FROM Customers AS c
LEFT JOIN Orders as o ON
c.CustomerID = o.CustomerID
GROUP BY c.CustomerID;

--------------------------------------------------------------------------------------

---Part E – RIGHT JOIN Analysis
--Business objective: Retain every order record, including transactions that do not have a matching customer record.

--Q1 Show every order with customer name if matched.

SELECT o.OrderID, c.CustomerName FROM Customers AS c
RIGHT JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q2 Find guest orders with no matching customer.

SELECT o.OrderID, c.CustomerID FROM Customers AS c
RIGHT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;

--Q3 Count guest orders.

SELECT COUNT(*) AS GuestOrders FROM Customers AS c
RIGHT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;

--Q4 Show all orders with customer city.

SELECT c.CustomerName, c.City FROM Customers AS c
RIGHT JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q5 Find guest-order revenue.

SELECT SUM(o.Quantity * o.UnitPrice) AS GuestOrderRevenue FROM Customers AS c
RIGHT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;

--Q6  Show guest orders and their categories.

SELECT o.Category, o.OrderID FROM Customers AS c
RIGHT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;

--Q7  Count all rows from the RIGHT JOIN.

SELECT COUNT(*) AS RowsRightJoin FROM Customers AS c
RIGHT JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q8 Show orders with NULL customer names.

SELECT c.CustomerName, o.OrderID FROM Customers AS c
RIGHT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.CustomerName IS NULL;

--Q9  Find guest orders with Quantity at least 3.

SELECT o.OrderID, o.Quantity FROM Customers AS c
RIGHT JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL AND o.Quantity >= 3;

--Q10 Re-create RIGHT JOIN using reversed LEFT JOIN.

SELECT o.OrderID, c.CustomerName FROM Orders AS o
LEFT JOIN Customers as c ON
o.CustomerID = c.CustomerID;

-------------------------------------------------------------------------

---Part F – FULL OUTER JOIN Analysis
--Business objective: Compare the complete customer and order datasets, including matched records and records that exist in only one table.

--Q1 Show all rows in the FULL OUTER JOIN.

SELECT o.OrderID, c.CustomerID FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q2 Show only rows with no match on either side.

SELECT o.OrderID, c.CustomerID FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL OR o.OrderID IS NULL;

--Q3 Count unmatched customers.

SELECT COUNT(*) AS UnmatchedCustomers FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

--Q4  Count guest orders in the full join.

SELECT COUNT(*) AS GuestOrders FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;

--Q5 Show customer names, order IDs and category.

SELECT c.CustomerName, o.OrderID, o.Category FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q6 Label each row as Matched, Customer only, or Order only.

SELECT o.OrderID, c.CustomerID,
CASE  
    WHEN o.OrderID IS NULL THEN 'CustomerOnly'
    WHEN c.CustomerID IS NULL THEN 'OrderOnly'
    ELSE 'Matched'
    END AS MatchStatus
FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q7  Count all FULL OUTER JOIN rows.

SELECT COUNT(*) AS TotalRecords FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID;

--Q8 Find unmatched customers in Wales.

SELECT c.CustomerName, c.CustomerID FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL AND Region = 'Wales';

--Q9 Show guest orders priced above £100.

SELECT o.UnitPrice, o.OrderID FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL AND o.UnitPrice > 100;

--Q10 Group all rows by match status and count them

SELECT 
CASE  
    WHEN o.OrderID IS NULL THEN 'CustomerOnly'
    WHEN c.CustomerID IS NULL THEN 'OrderOnly'
    ELSE 'Matched'
    END AS MatchStatus,
COUNT (*) AS MatchStatus
FROM Customers AS c
FULL OUTER JOIN Orders as o ON
c.CustomerID = o.CustomerID
GROUP BY 
CASE  
    WHEN o.OrderID IS NULL THEN 'CustomerOnly'
    WHEN c.CustomerID IS NULL THEN 'OrderOnly'
    ELSE 'Matched'
    END;

-------------------------------------------------------------------------------------------------

---Part G – Subquery Analysis
--Business objective: Use nested queries to compare individual customer and order records against calculated business measures.

--Q1 Show orders priced above the overall average.

SELECT * FROM Orders 
WHERE UnitPrice > (SELECT ROUND(AVG(UnitPrice),2) FROM Orders);

--Q2 Show orders with the maximum unit price.

SELECT * FROM Orders 
WHERE UnitPrice = (SELECT ROUND(MAX(UnitPrice),2) FROM Orders);

--Q3 Show customers who placed at least one order.

SELECT * FROM Customers 
WHERE CustomerID IN (SELECT CustomerID FROM Orders
WHERE CustomerID IS NOT NULL);

--Q4 Show customers without any order.

SELECT * FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders
WHERE CustomerID IS NULL)

--Q5 Show orders with quantity above the average.

SELECT * FROM Orders 
WHERE Quantity > (SELECT ROUND(AVG(Quantity),2) FROM Orders);

--Q6 Show customers who ordered Electronics.

SELECT * FROM Customers 
WHERE CustomerID IN
(SELECT CustomerID FROM Orders
WHERE Category = 'Electronics' AND CustomerID IS NOT NULL);

--Q7 Show orders from customers living in London.

SELECT * FROM Orders
WHERE CustomerID IN 
(SELECT CustomerID FROM Customers
WHERE City = 'London');

--Q8 Show orders with price below the minimum Electronics price.

SELECT * FROM Orders 
WHERE UnitPrice < 
(SELECT MIN(UnitPrice) FROM Orders 
WHERE Category = 'Electronics');

--Q9 Show customers with more than one order.

SELECT c.* FROM Customers c
WHERE
(SELECT COUNT(*) FROM Orders o
WHERE o.CustomerID = c.CustomerID) > 1

--Q10 Show customers whose total order revenue exceeds £500.

SELECT c.* FROM Customers c
WHERE
(SELECT SUM(o.Quantity * o.UnitPrice) FROM Orders o
WHERE c.CustomerID =o.CustomerID) > 500;