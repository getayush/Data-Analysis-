-- LAG()
SELECT SaleID,
	   Product
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