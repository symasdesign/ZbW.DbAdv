USE [tempdb];
GO

-- Let's create a sample table with a simple parent/child hierarchy

-- tempdb: table exists for the current connection

		CREATE TABLE [dbo].[ProductHierarchy]
		(
		    [ProductHierarchyID] INT NOT NULL
		                            PRIMARY KEY CLUSTERED
		                            IDENTITY(1, 1) ,
		    [ProductID] INT NOT NULL ,
		    [ParentProductID] INT NULL
		);
GO

		INSERT  [dbo].[ProductHierarchy]
		        ( [ProductID], [ParentProductID] )
		VALUES  ( 1, NULL ),
		        ( 2, 1 ),
		        ( 3, 1 ),
		        ( 4, 2 ),
		        ( 5, 4 ),
		        ( 6, 4 ),
		        ( 7, 4 );
		GO


-- ohne CTE - es muss bekannt sein, wieviele Hierarchien
-- pro Hierarchie einen Union mit Derived Table
SELECT p0.ProductId, p0.ParentProductID, 0 AS ProductLevel
FROM [dbo].[ProductHierarchy] p0
WHERE p0.ParentProductId IS NULL
UNION ALL
SELECT p1.ProductId, p1.ParentProductID, 1 AS ProductLevel
FROM [dbo].[ProductHierarchy] p1
JOIN (SELECT p0.ProductId, p0.ParentProductID, 0 AS ProductLevel
      FROM [dbo].[ProductHierarchy] p0
      WHERE p0.ParentProductId IS NULL) p0
  ON p1.ParentProductId = p0.ProductId
UNION ALL
SELECT p2.ProductId, p2.ParentProductID, 2 AS ProductLevel
FROM [dbo].[ProductHierarchy] p2
JOIN (SELECT p1.ProductId, p1.ParentProductID, 1 AS ProductLevel
      FROM [dbo].[ProductHierarchy] p1
      JOIN (SELECT p0.ProductId, p0.ParentProductID, 0 AS ProductLevel
      FROM [dbo].[ProductHierarchy] p0
      WHERE p0.ParentProductId IS NULL) p0
        ON p1.ParentProductId = p0.ProductId) p1
  ON p2.ParentProductId = p1.ProductId
UNION ALL
SELECT p3.ProductId, p3.ParentProductID, 3 AS ProductLevel
FROM [dbo].[ProductHierarchy] p3
JOIN  (SELECT p2.ProductId, p2.ParentProductID, 2 AS ProductLevel
       FROM [dbo].[ProductHierarchy] p2
       JOIN (SELECT p1.ProductId, p1.ParentProductID, 1 AS ProductLevel
             FROM [dbo].[ProductHierarchy] p1
             JOIN (SELECT p0.ProductId, p0.ParentProductID, 0 AS ProductLevel
                    FROM [dbo].[ProductHierarchy] p0
                    WHERE p0.ParentProductId IS NULL) p0
              ON p1.ParentProductId = p0.ProductId) p1
        ON p2.ParentProductId = p1.ProductId) p2
  ON p3.ParentProductId = p2.ProductId;
  
  
-- mit CTE -> Rekursiv  
-- Now let's use a recursive CTE in order to traverse the hierarchy
		WITH [CTE_Products] (
			[ProductID], [ParentProductID], [ProductLevel] )
		AS (
			SELECT	[ProductID] ,
		            [ParentProductID] ,
		            0 AS [ProductLevel]
		    FROM [dbo].[ProductHierarchy]
		    WHERE [ParentProductID] IS NULL
		    UNION ALL
		    SELECT	[pn].[ProductID] ,
		            [pn].[ParentProductID] ,
		            [p1].[ProductLevel] + 1
		    FROM [dbo].[ProductHierarchy] AS [pn]
		    INNER JOIN [CTE_Products] AS [p1]
				ON [p1].[ProductID] = [pn].[ParentProductID]
		)
		SELECT	[ProductID] ,
		        [ParentProductID] ,
		        [ProductLevel]
		FROM [CTE_Products]
		ORDER BY [ParentProductID];
		GO

-- Cleanup
DROP TABLE [dbo].[ProductHierarchy];
GO

