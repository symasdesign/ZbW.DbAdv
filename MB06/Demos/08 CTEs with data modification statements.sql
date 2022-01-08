USE master;
GO

-- We've seen examples of SELECT in prior demos

-- Demo (temporary) table
CREATE TABLE #all_views
(
	name SYSNAME ,
    object_id INT ,
    type_desc NVARCHAR(60)
);
GO

-- INSERT
WITH CTE_Views (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.all_views
)
INSERT  #all_views
( name ,
	object_id ,
    type_desc
)
SELECT	name ,
        object_id ,
        type_desc
FROM CTE_Views;
GO

-- UPDATE
WITH CTE_Views (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.all_views
)
UPDATE #all_views
	SET name = v.name
FROM #all_views AS t
INNER JOIN CTE_Views AS v
	ON t.object_id = v.object_id;
GO

-- DELETE
WITH CTE_Views (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.all_views
)
DELETE #all_views
FROM #all_views AS t
INNER JOIN CTE_Views AS v
	ON t.object_id = v.object_id;
GO

-- MERGE
WITH CTE_Views (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.all_views
)
MERGE #all_views AS t
USING CTE_Views AS s
	ON t.object_id = s.object_id
WHEN NOT MATCHED
	THEN INSERT (
		object_id ,
		name ,
		type_desc
	)
	VALUES (	s.object_id ,
				s.name ,
				s.type_desc
	) ;
GO

SELECT	name ,
		object_id ,
		type_desc
FROM #all_views;
GO

-- Cleanup
DROP TABLE #all_views;
GO
