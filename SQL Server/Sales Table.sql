CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Product CHAR(1),
    Date DATE,
    Amount INT
)

select * from Sales

INSERT INTO Sales (SaleID, Product, Date, Amount) VALUES
(1, 'A', '2024-04-01', 100),
(2, 'B', '2024-04-01', 200),
(3, 'C', '2024-04-02', 150),
(4, 'D', '2024-04-02', 300),
(5, 'E', '2024-04-03', 250),
(6, 'F', '2024-04-03', 100),
(7, 'G', '2024-04-04', 200),
(8, 'H', '2024-04-04', 200),
(9, 'I', '2024-04-05', 300),
(10, 'J', '2024-04-05', 150),
(11, 'K', '2024-04-06', 400),
(12, 'L', '2024-04-06', 100),
(13, 'M', '2024-04-07', 500),
(14, 'N', '2024-04-07', 100),
(15, 'O', '2024-04-08', 200),
(16, 'P', '2024-04-08', 300),
(17, 'Q', '2024-04-09', 400),
(18, 'R', '2024-04-09', 500),
(19, 'S', '2024-04-10', 250),
(20, 'T', '2024-04-10', 150);

-- LAG()
SELECT SaleID,
	   Product,
	   Date,
	   Amount,
	   LAG(Amount, 3) OVER (Order BY SaleID) As LagAmount
FROM Sales

-- LEAD()
SELECT SaleID,
	   Product,
	   Date,
	   Amount,
	   LEAD(Amount, 4) OVER (Order BY SaleID) As LagAmount
FROM Sales

-- ROW NUMBER() and PARTITION BY()
-- Row Number assigns Unique number to each row
-- Each partition created by PARTITION BY will have its own separate set of row numbers starting from 1.
SELECT SaleID,
       Product,
       Date,
       Amount,
       ROW_NUMBER() OVER (PARTITION BY Date ORDER BY SaleID) AS RowNum
FROM Sales;

-- RANK(), DRANK(), NTILE(), PERCENT_RANK(), CUME_DIST()
SELECT 
    SaleID,
    Product,
    Date,
    Amount,
    RANK() OVER (ORDER BY Amount DESC) AS Rank,
    DENSE_RANK() OVER (ORDER BY Amount DESC) AS DenseRank,
    NTILE(10) OVER (ORDER BY Amount DESC) AS Ntile4,
    PERCENT_RANK() OVER (ORDER BY Amount DESC) AS PercentRank,
    CUME_DIST() OVER (ORDER BY Amount DESC) AS CumeDist
FROM 
    Sales

-- Running Total
SELECT 
  SaleID,
  Product,
  Date,
  Amount,
  SUM(Amount) OVER (ORDER BY Date, SaleID) AS RunningTotal
FROM 
  Sales

-- Moving Average
SELECT 
  SaleID,
  Product,
  Date,
  Amount,
  AVG(Amount) OVER (ORDER BY Date, SaleID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM 
  Sales

SELECT 
  SaleID,
  Product,
  Date,
  Amount,
  AVG(Amount) OVER (ORDER BY Date, SaleID ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM 
  Sales

SELECT 
  SaleID,
  Product,
  Date,
  Amount,
  AVG(Amount) OVER (ORDER BY Date, SaleID ROWS BETWEEN 3 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM 
  Sales

-- Cumulative Stats
	 -- Cumulative Average
SELECT 
  SaleID,
  Product,
  Date,
  Amount,
  AVG(Amount) OVER (ORDER BY Date, SaleID) AS CumulativeAvg
FROM 
  Sales

-- Cumulative Stats
	-- Cumulative Maximum
SELECT 
  SaleID,
  Product,
  Date,
  Amount,
  MAX(Amount) OVER (ORDER BY Date, SaleID) AS CumulativeMax
FROM 
  Sales