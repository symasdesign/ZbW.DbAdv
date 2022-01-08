USE master;
GO

-- We can reference a CTE multiple times, unlike with derived
-- tables where they must be defined for each reference

-- Before (derived tables)
SELECT  c.last_execution_time_by_hour - 1 AS min_hour ,
        c.last_execution_time_by_hour AS max_hour ,
        ( c.sum_execution_count +
			ISNULL (p.sum_execution_count, 0) ) / 2
				AS two_hour_average_execution_count
FROM (
	SELECT	DATEPART (hour, last_execution_time) AS
				last_execution_time_by_hour ,
			SUM (execution_count) AS sum_execution_count
	FROM sys.dm_exec_query_stats
	GROUP BY DATEPART (hour, last_execution_time)
) AS c
LEFT OUTER JOIN (
	SELECT	DATEPART (hour, last_execution_time) AS
				last_execution_time_by_hour ,
			SUM (execution_count) AS sum_execution_count
	FROM sys.dm_exec_query_stats
	GROUP BY DATEPART (hour, last_execution_time)
) AS p
	ON c.last_execution_time_by_hour - 1 =
		p.last_execution_time_by_hour;

-- After (CTEs)
WITH CTE_Stats_by_Hour (
	last_execution_time_by_hour, sum_execution_count )
AS (
	SELECT	DATEPART (hour, last_execution_time) ,
			SUM (execution_count)
			-- notice I don't have to alias the two columns
	FROM sys.dm_exec_query_stats
	GROUP BY DATEPART (hour, last_execution_time)
)
SELECT	c.last_execution_time_by_hour - 1 AS min_hour ,
		c.last_execution_time_by_hour AS max_hour ,
		( c.sum_execution_count +
			ISNULL (p.sum_execution_count, 0) ) / 2
				AS two_hour_average_execution_count
FROM CTE_Stats_by_Hour AS c
LEFT OUTER JOIN CTE_Stats_by_Hour AS p
	ON c.last_execution_time_by_hour - 1 =
		p.last_execution_time_by_hour;
	
-- As an aside - what do the execution plans look like?