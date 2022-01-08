USE master;
GO

-- We can define multiple CTEs, but have a choice of actually
-- referencing some or all
WITH CTE_Views (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.all_views
),
CTE_Triggers (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.triggers
)
SELECT	name ,
		object_id ,
		type_desc
FROM CTE_Views;
GO

-- And of course, we can reference all defined CTEs within the
-- same execution scope
WITH CTE_Views (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.all_views
),
CTE_Triggers (
	object_id, name, type_desc )
AS (
	SELECT	object_id ,
			name ,
			type_desc
	FROM sys.triggers
)
SELECT	name ,
		object_id ,
		type_desc
FROM CTE_Views
UNION
SELECT	name ,
		object_id ,
		type_desc
FROM CTE_Triggers;
GO