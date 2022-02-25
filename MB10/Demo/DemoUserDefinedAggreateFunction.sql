USE AdventureWorks2016;
GO

----- START 1x: muss nur 1x ausgeführt werden ------
--Enable CLR configuration
EXEC sp_configure 'clr enabled',1;
RECONFIGURE;
GO

--Add DLL to SQL 
CREATE ASSEMBLY CustomAggregate FROM
 'E:\...\CustomAggregate\CustomAggregate\bin\Debug\CustomAggregate.dll' WITH PERMISSION_SET = SAFE; 
GO

--Create the UDF
CREATE Aggregate Median (@value INT) RETURNS INT
EXTERNAL NAME CustomAggregate.Median;
GO
----- ENDE 1x -----------------------------------------



--The detail count for each order
SELECT SalesOrderID, COUNT(*) AS DetailCount
FROM Sales.SalesOrderDetail
WHERE SalesOrderID BETWEEN 43660 AND 43670
GROUP BY SalesOrderID
ORDER BY COUNT(*);
-- Row 6 contains the medium detail count





--What is the median detail count?
WITH Details AS (	
	SELECT SalesOrderID, COUNT(*) AS DetailCount
	FROM Sales.SalesOrderDetail
	WHERE SalesOrderID BETWEEN 43660 AND 43670
	GROUP BY SalesOrderID)
SELECT dbo.Median(DetailCount) AS MedianCount
FROM Details;




--Display the details with the median
SELECT SalesOrderID, COUNT(*) AS DetailCount,
	dbo.Median(COUNT(*)) OVER() AS MedianDetailCount
FROM Sales.SalesOrderDetail
WHERE SalesOrderID BETWEEN 43660 AND 43670
GROUP BY SalesOrderID;


--Clean up
DROP AGGREGATE dbo.Median;
DROP ASSEMBLY CustomAggregate;
EXEC sp_configure 'clr enabled', 0;
RECONFIGURE;
