# Retail_Sales_and_Customer_Analysis
# Retail Sales and Customer Analysis – SQL Project

**Project Type:** Data Analytics – SQL Project  
**Database:** Retail Sales Database  
**SQL Environment:** Microsoft SQL Server Management Studio (SSMS)  
**SQL Language:** T-SQL  
**Total SQL Queries:** 70

## 1. Project Overview

This project focuses on analysing retail sales and customer data using SQL.

The database contains two main tables: `Customers` and `Orders`. These tables provide information about customer details, geographical locations, customer segments, product categories, order quantities, unit prices and order dates.

The objective of this project was to investigate business questions relating to customer activity, sales performance, revenue, product categories and customer-order relationships.

I developed 70 SQL queries, progressing from basic data retrieval and filtering to aggregate functions, different types of joins and subqueries.

The project demonstrates how SQL can be used to extract information, combine related datasets, identify unmatched records and calculate business measures to support commercial reporting and decision-making.

## 2. Business Objectives

The main objectives were to:

1. Explore customer and order data.
2. Analyse customer distribution across cities, regions and business segments.
3. Calculate order volumes and sales revenue.
4. Compare sales performance across product categories.
5. Identify customers with and without recorded orders.
6. Analyse customer purchasing frequency and order values.
7. Understand relationships between customers and their transactions.
8. Identify orders that do not have a matching customer record.
9. Use subqueries to compare individual transactions and customers against overall business measures.
10. Apply SQL techniques to answer practical business questions.

## 3. Database Overview

The project uses two main relational tables.

| Table | Business information |
|---|---|
| `Customers` | Customer ID, customer name, city, region and customer segment |
| `Orders` | Order ID, customer ID, category, quantity, unit price and order date |

The `CustomerID` field is used to connect customer records with their corresponding orders.

### Example: Understanding the data

```sql
SELECT *
FROM Customers;

SELECT *
FROM Orders;
```

## 4. SQL Analysis and Business Questions

### Part A – Data Retrieval and Filtering

**Business objective:** Explore customer and order records and retrieve information based on specific business requirements.

**Q1. What customer information is available in the database?**

Retrieve all columns from the Customers table.

```sql
SELECT *
FROM Customers;
```

**Q2. What are the customer names and their locations?**

Retrieve customer names and cities to review the geographical distribution of customers.

```sql
SELECT CustomerName, City
FROM Customers;
```

**Q3. Which customers are based in London?**

Identify customers located in London.

```sql
SELECT *
FROM Customers
WHERE City = 'London';
```

**Q4. What are the unique regions represented in the customer database?**

Identify distinct regions to understand the geographical coverage of the customer base.

```sql
SELECT DISTINCT Region
FROM Customers;
```

**Q5. How can customers be listed alphabetically?**

Sort customer records by customer name from A to Z.

```sql
SELECT *
FROM Customers
ORDER BY CustomerName ASC;
```

**Q6. Which customers belong to the Business segment?**

Filter the customer database to identify business customers.

```sql
SELECT *
FROM Customers
WHERE Segment = 'Business';
```

**Q7. Which customers are based in Leeds or Bristol?**

Retrieve customers from either of the two specified cities.

```sql
SELECT *
FROM Customers
WHERE City = 'Leeds'
   OR City = 'Bristol';
```

**Q8. Which orders have a quantity of at least four units?**

Identify transactions where the quantity ordered is four or more.

```sql
SELECT *
FROM Orders
WHERE Quantity >= 4;
```

**Q9. Which Electronics orders were placed most recently?**

Filter orders by the Electronics category and sort them by order date, newest first.

```sql
SELECT *
FROM Orders
WHERE Category = 'Electronics'
ORDER BY OrderDate DESC;
```

**Q10. Which orders have a unit price above £100?**

Identify higher-priced orders and sort them from the lowest qualifying price to the highest.

```sql
SELECT *
FROM Orders
WHERE UnitPrice > 100
ORDER BY UnitPrice ASC;
```

**Business relevance:** These queries provide an initial understanding of customer profiles, geographical coverage, customer segments, product categories and transaction characteristics.

---

### Part B – Aggregate Functions and Business Metrics

**Business objective:** Calculate key business measures to understand customer numbers, order volumes, pricing and sales revenue.

**Q1. How many customers are recorded in the database?**

```sql
SELECT COUNT(CustomerName) AS CustomerCount
FROM Customers;
```

**Q2. How many orders have been recorded?**

```sql
SELECT COUNT(OrderID) AS OrderCount
FROM Orders;
```

**Q3. How many orders have a recorded Customer ID?**

```sql
SELECT COUNT(CustomerID) AS OrdersWithCustomerID
FROM Orders;
```

**Q4. What is the total quantity of products sold?**

```sql
SELECT SUM(Quantity) AS TotalQuantitySold
FROM Orders;
```

**Q5. What is the average unit price of the products ordered?**

```sql
SELECT ROUND(AVG(UnitPrice), 2) AS AvgUnitPrice
FROM Orders;
```

**Q6. What are the highest and lowest unit prices?**

```sql
SELECT
    ROUND(MAX(UnitPrice), 2) AS LargestUnitPrice,
    ROUND(MIN(UnitPrice), 2) AS SmallestUnitPrice
FROM Orders;
```

**Q7. How many customers belong to each region?**

```sql
SELECT
    Region,
    COUNT(*) AS CustomersInRegion
FROM Customers
GROUP BY Region;
```

**Q8. What is the sales revenue generated by each product category?**

Calculate revenue using quantity multiplied by unit price.

```sql
SELECT
    Category,
    SUM(Quantity * UnitPrice) AS SalesRevenue
FROM Orders
GROUP BY Category;
```

**Q9. Which product categories have more than 15 orders?**

```sql
SELECT
    Category,
    COUNT(*) AS OrdersCount
FROM Orders
GROUP BY Category
HAVING COUNT(*) > 15;
```

**Q10. Which customer segments have at least 30 customers?**

```sql
SELECT
    Segment,
    COUNT(*) AS CustomerCount
FROM Customers
GROUP BY Segment
HAVING COUNT(*) >= 30;
```

**Business relevance:** Aggregate analysis supports management reporting by summarising customer numbers, transaction volumes, product quantities, average prices and category-level revenue.

---

### Part C – INNER JOIN Analysis

**Business objective:** Combine customer and order records to analyse transactions linked to existing customers.

An INNER JOIN returns records where the join condition matches in both tables.

**Q1. Which customers are linked to each order?**

```sql
SELECT
    c.CustomerName,
    o.OrderID
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q2. Which customers purchased products in each category, and in what quantities?**

```sql
SELECT
    c.CustomerName,
    o.Category,
    o.Quantity
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q3. How many order records are matched to customer records?**

```sql
SELECT COUNT(o.OrderID)
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q4. Which orders are associated with London customers?**

```sql
SELECT
    c.CustomerName,
    o.OrderID
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.City = 'London';
```

**Q5. Which customers placed Electronics orders?**

```sql
SELECT
    c.CustomerName,
    o.OrderID
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.Category = 'Electronics';
```

**Q6. What is the revenue generated by each matched customer order?**

```sql
SELECT
    c.CustomerName,
    o.OrderID,
    o.Quantity * o.UnitPrice AS Revenue
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q7. How many orders has each matched customer placed?**

```sql
SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS TotalCustomerOrders
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;
```

**Q8. Which matched customer orders have a quantity of at least four?**

```sql
SELECT
    c.CustomerName,
    o.OrderID,
    o.Quantity
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.Quantity >= 4;
```

**Q9. Which orders were placed by Business segment customers?**

```sql
SELECT
    c.CustomerName,
    o.OrderID
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.Segment = 'Business';
```

**Q10. How can matched customer orders be displayed in date order, newest first?**

```sql
SELECT
    c.CustomerName,
    o.OrderID,
    o.OrderDate
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate DESC;
```

**Business relevance:** Joining customer and order information allows a business to understand purchasing activity, analyse customer-level transactions and calculate revenue associated with matched customer records.

---

### Part D – LEFT JOIN Analysis

**Business objective:** Retain all customer records, including customers who may not have placed an order.

A LEFT JOIN returns all records from the left table and matching records from the right table. Where no match exists, the right-hand table columns return NULL.

**Q1. Can we display all customers and any associated order IDs?**

```sql
SELECT
    c.CustomerName,
    o.OrderID
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q2. Which customers have never placed an order?**

```sql
SELECT
    c.CustomerName,
    c.CustomerID
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
```

**Q3. How many customers have no recorded orders?**

```sql
SELECT
    COUNT(c.CustomerName) AS NoOrderCustomers
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
```

**Q4. How many orders has each customer placed, including customers with zero orders?**

```sql
SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS OrdersPerCustomer
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;
```

**Q5. What product categories are associated with each customer?**

```sql
SELECT
    c.CustomerName,
    o.Category
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q6. What revenue is associated with each customer and order?**

```sql
SELECT
    c.CustomerName,
    o.Quantity * o.UnitPrice AS RevenuePerCustomer
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q7. Can we retrieve London customers even if they have not placed an order?**

```sql
SELECT
    c.CustomerName,
    c.CustomerID
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.City = 'London';
```

**Q8. How many distinct customers have placed an order?**

```sql
SELECT
    COUNT(DISTINCT c.CustomerName) AS DistinctCustomers
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NOT NULL;
```

**Q9. Which customers have no orders, listed alphabetically?**

```sql
SELECT
    c.CustomerName
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
ORDER BY c.CustomerName ASC;
```

**Q10. What is the latest recorded order date for each customer?**

```sql
SELECT
    c.CustomerID,
    MAX(o.OrderDate) AS LatestOrder
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID;
```

**Business relevance:** LEFT JOIN analysis helps identify inactive customers, customers without recorded transactions and differences in purchasing activity across the customer base. This can support customer engagement and retention analysis.

---

### Part E – RIGHT JOIN Analysis

**Business objective:** Retain every order record, including transactions that do not have a matching customer record.

A RIGHT JOIN returns all records from the right-hand table and matching records from the left-hand table.

**Q1. Can we display every order with a customer name where a match exists?**

```sql
SELECT
    o.OrderID,
    c.CustomerName
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q2. Which orders do not have a matching customer record?**

```sql
SELECT
    o.OrderID,
    c.CustomerID
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;
```

**Q3. How many orders do not have a matching customer?**

```sql
SELECT
    COUNT(*) AS GuestOrders
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;
```

**Q4. Can we display all orders with their associated customer information?**

```sql
SELECT
    c.CustomerName,
    c.City
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q5. What revenue is generated by orders without a matching customer?**

```sql
SELECT
    SUM(o.Quantity * o.UnitPrice) AS GuestOrderRevenue
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;
```

**Q6. What categories are associated with orders that have no matching customer?**

```sql
SELECT
    o.Category,
    o.OrderID
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;
```

**Q7. How many rows are returned when all orders are retained in a RIGHT JOIN?**

```sql
SELECT
    COUNT(*) AS RowsRightJoin
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q8. Which orders have a NULL customer name?**

```sql
SELECT
    c.CustomerName,
    o.OrderID
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CustomerName IS NULL;
```

**Q9. Which unmatched customer orders have a quantity of at least three?**

```sql
SELECT
    o.OrderID,
    o.Quantity
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL
  AND o.Quantity >= 3;
```

**Q10. Can the same result be produced using a LEFT JOIN with the table order reversed?**

```sql
SELECT
    o.OrderID,
    c.CustomerName
FROM Orders AS o
LEFT JOIN Customers AS c
    ON o.CustomerID = c.CustomerID;
```

**Business relevance:** This analysis can help identify transactions without corresponding customer records. These records may require investigation as part of data quality, transaction reconciliation or customer record management.

---

### Part F – FULL OUTER JOIN Analysis

**Business objective:** Compare the complete customer and order datasets, including matched records and records that exist in only one table.

A FULL OUTER JOIN returns matching records and unmatched records from both tables.

**Q1. What records are returned when all customers and orders are combined?**

```sql
SELECT
    o.OrderID,
    c.CustomerID
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q2. Which records do not have a match in either table?**

```sql
SELECT
    o.OrderID,
    c.CustomerID
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL
   OR o.OrderID IS NULL;
```

**Q3. How many customers do not have any matching order?**

```sql
SELECT
    COUNT(*) AS UnmatchedCustomers
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
```

**Q4. How many orders do not have a matching customer?**

```sql
SELECT
    COUNT(*) AS GuestOrders
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;
```

**Q5. Can we display customer names, order IDs and product categories from both datasets?**

```sql
SELECT
    c.CustomerName,
    o.OrderID,
    o.Category
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q6. Can we classify records as Matched, Customer Only or Order Only?**

```sql
SELECT
    o.OrderID,
    c.CustomerID,
    CASE
        WHEN o.OrderID IS NULL THEN 'CustomerOnly'
        WHEN c.CustomerID IS NULL THEN 'OrderOnly'
        ELSE 'Matched'
    END AS MatchStatus
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q7. How many total records are returned by the FULL OUTER JOIN?**

```sql
SELECT
    COUNT(*) AS TotalRecords
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

**Q8. Which unmatched customers are located in Wales?**

```sql
SELECT
    c.CustomerName,
    c.CustomerID
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
  AND Region = 'Wales';
```

**Q9. Which unmatched orders have a unit price above £100?**

```sql
SELECT
    o.UnitPrice,
    o.OrderID
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL
  AND o.UnitPrice > 100;
```

**Q10. How many records belong to each match category?**

```sql
SELECT
    CASE
        WHEN o.OrderID IS NULL THEN 'CustomerOnly'
        WHEN c.CustomerID IS NULL THEN 'OrderOnly'
        ELSE 'Matched'
    END AS MatchStatus,
    COUNT(*) AS MatchStatusCount
FROM Customers AS c
FULL OUTER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    CASE
        WHEN o.OrderID IS NULL THEN 'CustomerOnly'
        WHEN c.CustomerID IS NULL THEN 'OrderOnly'
        ELSE 'Matched'
    END;
```

**Business relevance:** FULL OUTER JOIN analysis can support data reconciliation by identifying customers without orders, orders without customers and records that successfully match between datasets.

---

### Part G – Subquery Analysis

**Business objective:** Use nested queries to compare individual customer and order records against calculated business measures.

Subqueries allow one query to use the result of another query as part of its filtering or analysis.

**Q1. Which orders have a unit price above the overall average?**

```sql
SELECT *
FROM Orders
WHERE UnitPrice >
    (SELECT ROUND(AVG(UnitPrice), 2)
     FROM Orders);
```

**Q2. Which orders have the maximum unit price?**

```sql
SELECT *
FROM Orders
WHERE UnitPrice =
    (SELECT ROUND(MAX(UnitPrice), 2)
     FROM Orders);
```

**Q3. Which customers have placed at least one order?**

```sql
SELECT *
FROM Customers
WHERE CustomerID IN
    (SELECT CustomerID
     FROM Orders
     WHERE CustomerID IS NOT NULL);
```

**Q4. Which customers have not placed an order?**

```sql
SELECT *
FROM Customers
WHERE CustomerID IN
    (SELECT CustomerID
     FROM Orders
     WHERE CustomerID IS NULL);
```

**Q5. Which orders have a quantity above the overall average quantity?**

```sql
SELECT *
FROM Orders
WHERE Quantity >
    (SELECT ROUND(AVG(Quantity), 2)
     FROM Orders);
```

**Q6. Which customers have purchased Electronics products?**

```sql
SELECT *
FROM Customers
WHERE CustomerID IN
    (SELECT CustomerID
     FROM Orders
     WHERE Category = 'Electronics'
       AND CustomerID IS NOT NULL);
```

**Q7. Which orders were placed by customers living in London?**

```sql
SELECT *
FROM Orders
WHERE CustomerID IN
    (SELECT CustomerID
     FROM Customers
     WHERE City = 'London');
```

**Q8. Which orders have a unit price below the minimum Electronics unit price?**

```sql
SELECT *
FROM Orders
WHERE UnitPrice <
    (SELECT MIN(UnitPrice)
     FROM Orders
     WHERE Category = 'Electronics');
```

**Q9. Which customers have placed more than one order?**

```sql
SELECT c.*
FROM Customers AS c
WHERE
    (SELECT COUNT(*)
     FROM Orders AS o
     WHERE o.CustomerID = c.CustomerID) > 1;
```

**Q10. Which customers have generated more than £500 in total order revenue?**

```sql
SELECT c.*
FROM Customers AS c
WHERE
    (SELECT SUM(o.Quantity * o.UnitPrice)
     FROM Orders AS o
     WHERE c.CustomerID = o.CustomerID) > 500;
```

**Business relevance:** Subqueries allow businesses to compare individual transactions against overall averages, identify customers meeting specific purchasing criteria and analyse customer activity using calculated measures.

---

## 5. SQL Skills Demonstrated

The project covers a range of SQL concepts, progressing from basic data retrieval to more advanced relational analysis.

| SQL Skill | How it was applied |
|---|---|
| SELECT | Retrieving relevant customer and order information |
| SELECT * | Exploring complete table records |
| DISTINCT | Identifying unique regions |
| WHERE | Filtering customers and orders |
| AND / OR | Applying multiple filtering conditions |
| Comparison operators | Identifying transactions based on quantity and price |
| ORDER BY | Sorting customer names, prices and order dates |
| COUNT() | Counting customers and orders |
| COUNT(DISTINCT) | Counting distinct customers |
| SUM() | Calculating total quantities and sales revenue |
| AVG() | Calculating average prices and quantities |
| MIN() / MAX() | Identifying minimum and maximum values |
| ROUND() | Rounding numerical results |
| GROUP BY | Summarising results by region, category and segment |
| HAVING | Filtering aggregated results |
| INNER JOIN | Combining matching customer and order records |
| LEFT JOIN | Retaining all customers, including those without orders |
| RIGHT JOIN | Retaining all orders, including those without customers |
| FULL OUTER JOIN | Comparing complete datasets and identifying unmatched records |
| IS NULL | Identifying missing matching records |
| IS NOT NULL | Excluding records with missing customer IDs |
| Table Aliases | Improving query readability |
| CASE WHEN | Classifying matched and unmatched records |
| IN | Filtering records using subquery results |
| Scalar Subqueries | Comparing individual values against aggregate results |
| Correlated Subqueries | Analysing customer-level order counts and revenue |

## 6. Business Applications

The analysis demonstrates how SQL can support several areas of retail business operations.

### Customer Analysis
- Understand customer distribution by region and segment.
- Identify customers with no recorded orders.
- Identify frequent and high-value customers.
- Examine customer purchasing activity.

### Sales Performance
- Calculate total quantities sold.
- Compare average and maximum unit prices.
- Calculate revenue by product category.
- Identify orders with higher-than-average prices or quantities.

### Data Quality and Reconciliation
- Identify orders without matching customer records.
- Identify customers without corresponding orders.
- Compare records across customer and order tables.
- Classify matched and unmatched records.

### Commercial Reporting
- Summarise order volumes.
- Analyse revenue by category.
- Compare customer segments.
- Identify transactions that meet specific commercial thresholds.

## 7. Tools and Technologies

- **Microsoft SQL Server:** Database management and query execution.
- **SQL Server Management Studio (SSMS):** Writing and executing SQL queries.
- **SQL:** Data retrieval, filtering, aggregation, joins and subquery analysis.
- **GitHub:** Project documentation and portfolio presentation.

## 8. Project Conclusion

This project provided practical experience in using SQL to analyse customer and retail transaction data.

I progressed from basic data retrieval and filtering to aggregate functions, relational joins and subqueries.

By applying INNER JOIN, LEFT JOIN, RIGHT JOIN and FULL OUTER JOIN, I explored how customer and order datasets can be combined and how unmatched records can be identified.

I also used aggregate functions and subqueries to calculate business measures, compare transactions against average values and identify customers based on purchasing activity.

The project strengthened my ability to translate business requirements into SQL queries and use relational data to investigate commercial and operational questions.

## 9. Further Development

Potential extensions include:

- Calculating total customer lifetime revenue.
- Analysing repeat purchasing and customer retention.
- Comparing revenue across customer segments and regions.
- Identifying the highest-revenue product categories.
- Analysing monthly and quarterly sales trends.
- Building customer segmentation reports.
- Developing Power BI dashboards using customer and order metrics.
- Extending the analysis using CTEs and window functions.

## Author

**Poornisha Ramesh**

Qualified finance professional developing practical skills in data analytics, SQL, Excel and Power BI.

This project forms part of my data analytics learning and professional portfolio.

Linkedin: https://www/Linkedin.com/poornisha-ramesh

GitHub: [PRamesh747](https://github.com/PRamesh747)
