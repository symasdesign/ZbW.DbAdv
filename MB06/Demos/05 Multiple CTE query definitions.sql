USE master;
GO

-----------------------------------------------------------------

-- Does this work?
WITH CTE_Views_Triggers (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.all_views

	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.triggers
)
SELECT	name ,
		object_id ,
		type_desc
FROM CTE_Views_Triggers;
GO

-----------------------------------------------------------------

-- Does this work?
WITH CTE_Views_Triggers (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.all_views
	UNION ALL
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.triggers
)
SELECT	name ,
		object_id ,
		type_desc
FROM CTE_Views_Triggers;
GO

-- For multiple query definitions, we can use UNION ALL, UNION,
-- INTERSECT, or EXCEPT

-- And alternatively, we can define multiple CTEs