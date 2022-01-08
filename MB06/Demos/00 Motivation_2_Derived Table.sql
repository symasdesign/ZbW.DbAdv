use AdventureWorks2016;

-- ohne CTE - mit Derived Tables
SELECT 
  sp.FirstName + ' ' + sp.LastName AS FullName,
  sp.City,
  ts.NetSales,
  td.SalesQuota,
  td.QuotaDiff
FROM Sales.vSalesPerson AS sp
  INNER JOIN 
	  (
		  SELECT SalesPersonID, ROUND(SUM(SubTotal), 2) as NetSales
			FROM Sales.SalesOrderHeader
			WHERE SalesPersonID IS NOT NULL
			  AND OrderDate BETWEEN '2014-01-01 00:00:00.000' 
				AND '2015-12-31 23:59:59.000'
			GROUP BY SalesPersonID
	  ) AS ts
    ON sp.BusinessEntityID = ts.SalesPersonID
  INNER JOIN 
	  (
		  SELECT ts.SalesPersonID,
			  CASE 
				WHEN sp.SalesQuota IS NULL THEN 0
				ELSE sp.SalesQuota
			  END as SalesQuota, 
			  CASE 
				WHEN sp.SalesQuota IS NULL THEN ts.NetSales
				ELSE ts.NetSales - sp.SalesQuota
			  END as QuotaDiff
			FROM 
				(
					  SELECT SalesPersonID, ROUND(SUM(SubTotal), 2) as NetSales
					FROM Sales.SalesOrderHeader
					WHERE SalesPersonID IS NOT NULL
					  AND OrderDate BETWEEN '2014-01-01 00:00:00.000' 
						AND '2015-12-31 23:59:59.000'
					GROUP BY SalesPersonID
				) AS ts
			  INNER JOIN Sales.SalesPerson AS sp
			  ON ts.SalesPersonID = sp.BusinessEntityID
	  ) AS td
    ON sp.BusinessEntityID = td.SalesPersonID
ORDER BY ts.NetSales DESC;


-- mit CTE
-- nun gibts die Derived-TAble ts nur noch 1x - zudem sind diese in der CTE und die effektive Abfrage ist viel übersichtlicher

;WITH 
  cteTotalSales (SalesPersonID, NetSales)
  AS
  (
    SELECT SalesPersonID, ROUND(SUM(SubTotal), 2)
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
      AND OrderDate BETWEEN '2014-01-01 00:00:00.000' 
        AND '2015-12-31 23:59:59.000'
    GROUP BY SalesPersonID
  ),
  cteTargetDiff (SalesPersonID, SalesQuota, QuotaDiff)
  AS
  (
    SELECT ts.SalesPersonID,
      CASE 
        WHEN sp.SalesQuota IS NULL THEN 0
        ELSE sp.SalesQuota
      END, 
      CASE 
        WHEN sp.SalesQuota IS NULL THEN ts.NetSales
        ELSE ts.NetSales - sp.SalesQuota
      END
    FROM cteTotalSales AS ts
      INNER JOIN Sales.SalesPerson AS sp
      ON ts.SalesPersonID = sp.BusinessEntityID
  )
SELECT 
  sp.FirstName + ' ' + sp.LastName AS FullName,
  sp.City,
  ts.NetSales,
  td.SalesQuota,
  td.QuotaDiff
FROM Sales.vSalesPerson AS sp
  INNER JOIN cteTotalSales AS ts
    ON sp.BusinessEntityID = ts.SalesPersonID
  INNER JOIN cteTargetDiff AS td
    ON sp.BusinessEntityID = td.SalesPersonID
ORDER BY ts.NetSales DESC