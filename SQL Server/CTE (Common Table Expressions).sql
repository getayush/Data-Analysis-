-- Q1) Find all transactions in the top three selling categories.
-- CTE to find the top three selling categories
WITH TopCategories AS (
    SELECT TOP 3 p.Category
    FROM Products p
    INNER JOIN Sales s ON s.Product = p.ProductID
    GROUP BY p.Category
    ORDER BY SUM(s.Amount) DESC
)
-- CTE to filter all transactions in these top categories
SELECT s.SaleID, s.Date, s.Product, s.Amount, p.ProductName, p.Category
FROM Sales s
INNER JOIN Products p ON s.Product = p.ProductID
WHERE p.Category IN (SELECT Category FROM TopCategories);


-- Q2) Calculate the average sales amount for each category and display only those categories whose average sales exceed the overall average.
-- CTE to calculate the average sales by category
WITH AvgSalesByCategory AS ( 
    SELECT p.Category, AVG(s.Amount) AS AvgAmount
    FROM Sales s
    INNER JOIN Products p ON s.Product = p.ProductID
    GROUP BY p.Category
),
-- CTE to calculate the overall average sales
OverallAvgSales AS (
    SELECT AVG(AvgAmount) AS OverallAvg
    FROM AvgSalesByCategory
)
-- Main query to compare the average sales of each category to the overall average and selects categories where the average sales are higher.
SELECT a.Category, a.AvgAmount
FROM AvgSalesByCategory a, OverallAvgSales
WHERE a.AvgAmount > OverallAvgSales.OverallAvg;


--Q3) List all products and their total sales, ranked from highest to lowest within each category.
-- CTE to calculate TotalSalesPerProduct
WITH TotalSalesPerProduct AS (
    SELECT 
        p.ProductName, 
        p.Category,  
        SUM(s.Amount) AS TotalSales,
        RANK() OVER (PARTITION BY p.Category ORDER BY SUM(s.Amount) DESC) AS ProductRank
    FROM Products p
    INNER JOIN Sales s ON p.ProductID = s.Product
    GROUP BY p.ProductName, p.Category  
)
SELECT * FROM TotalSalesPerProduct -- Main query to select all from the CTE
ORDER BY Category, ProductRank;


--Q4) Identify products that have never been sold and are priced above the average price of all products listed in the Products table.
-- CTE to find Average Price for All Products
WITH AveragePriceAllProducts AS (
	SELECT AVG(p.Price) as AvgPrice
	FROM Products p)

SELECT p.ProductName, p.Price
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.Product
WHERE s.SaleID IS NULL  -- Ensures the product was never sold
AND p.Price > (SELECT AvgPrice FROM AveragePriceAllProducts)  
ORDER BY p.Price DESC  


--Q5) For each product, calculate the average sales amount before the first sale that exceeded $1000. (Average Sales Before First Major Sale)
-- CTE to find First Major Sale
WITH FirstMajorSale AS (
    SELECT 
        p.ProductID, 
        MIN(s.Date) as FirstMajorSaleDate  -- First sale date over $1000
    FROM Sales s
    INNER JOIN Products p ON s.Product = p.ProductID
    WHERE s.Amount > 1000
    GROUP BY p.ProductID
),
AvgSalesBeforeMajor AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        AVG(s.Amount) AS AvgSalesBeforeMajor
    FROM Sales s
    INNER JOIN Products p ON s.Product = p.ProductID
    INNER JOIN FirstMajorSale fms ON p.ProductID = fms.ProductID
    WHERE s.Date < fms.FirstMajorSaleDate  -- Only consider sales before the major sale
    GROUP BY p.ProductID, p.ProductName
)
SELECT * FROM AvgSalesBeforeMajor;
(
	SELECT AVG(s.Amount)
	FROM Sales s
)