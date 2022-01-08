use Northwind;


-- ohne CTE
begin transaction;

-- Damit der Delete kein Fehler erzeugt
-- wird unten mit dem Rollback auch wieder hergestellt.
delete from [Order Details];

DELETE FROM dbo.Orders
FROM dbo.Orders o
inner join 
(
    SELECT  c.CustomerID, o.OrderID,
       ROW_NUMBER() OVER(PARTITION BY c.CustomerID 
                         ORDER BY o.OrderDate DESC) AS 'RowN'
    FROM dbo.Customers c
    INNER JOIN dbo.Orders o ON o.CustomerID = c.CustomerID
) co on o.OrderID = co.OrderID
WHERE co.RowN > 1
AND co.CustomerID = 'VINET';


-- VINET hat 5 Bestellungen - jetzt noch eine
select * from dbo.Customers c 
INNER JOIN dbo.Orders o ON o.CustomerID = c.CustomerID
where c.CustomerID = 'VINET';

rollback;



-- mit CTE
begin transaction;

-- Damit der Delete kein Fehler erzeugt
-- wird unten mit dem Rollback auch wieder hergestellt.
delete from [Order Details];

;WITH CustomerOrders AS (
    SELECT  c.CustomerID, o.OrderID,
       ROW_NUMBER() OVER(PARTITION BY c.CustomerID 
                         ORDER BY o.OrderDate DESC) AS 'RowN'
    FROM dbo.Customers c
    INNER JOIN dbo.Orders o ON o.CustomerID = c.CustomerID
)
--SELECT * 
DELETE FROM dbo.Orders
FROM dbo.Orders o
inner join CustomerOrders co on o.OrderID = co.OrderID
WHERE co.RowN > 1
AND co.CustomerID = 'VINET'

-- VINET hat 5 Bestellungen - jetzt noch eine
select * from dbo.Customers c 
INNER JOIN dbo.Orders o ON o.CustomerID = c.CustomerID
where c.CustomerID = 'VINET'

rollback;