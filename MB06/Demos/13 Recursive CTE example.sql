USE tempdb;
GO

-- Let's create a sample table with a simple parent/child hierarchy

CREATE TABLE dbo.ProductHierarchy
(
    ProductHierarchyID INT NOT NULL
                            PRIMARY KEY CLUSTERED
                            IDENTITY(1, 1) ,
    ProductID INT NOT NULL ,
    ParentProductID INT NULL
);
GO

INSERT  dbo.ProductHierarchy
        ( ProductID, ParentProductID )
VALUES  ( 1, NULL ),
        ( 2, 1 ),
        ( 3, 1 ),
        ( 4, 2 ),
        ( 5, 4 ),
        ( 6, 4 ),
        ( 7, 4 );
GO

-- Now let's use a recursive CTE in order to traverse the hierarchy
WITH CTE_Products (
	ProductID, ParentProductID, ProductLevel )
AS (
	SELECT	ProductID ,
            ParentProductID ,
            0 AS ProductLevel
    FROM dbo.ProductHierarchy
    WHERE ParentProductID IS NULL
    UNION ALL
    SELECT	pn.ProductID ,
            pn.ParentProductID ,
            p1.ProductLevel + 1
    FROM dbo.ProductHierarchy AS pn
    INNER JOIN CTE_Products AS p1
		ON p1.ProductID = pn.ParentProductID
)
SELECT	ProductID ,
        ParentProductID ,
        ProductLevel
FROM CTE_Products
ORDER BY ParentProductID;
GO

-- Cleanup
DROP TABLE dbo.ProductHierarchy;
GO

