USE tempdb;
GO

-- Stored procedures and CTEs
CREATE PROCEDURE dbo.Running_Requests
AS
	WITH CTE_Requests (
		session_id, status, login_name, text )
	AS (
		SELECT	r.session_id ,
				r.status ,
				s.login_name ,
				t.text
		FROM sys.dm_exec_requests AS r
		INNER JOIN sys.dm_exec_sessions AS s
			ON s.session_id = r.session_id
		INNER JOIN sys.dm_exec_connections AS c
			ON s.session_id = c.session_id
		CROSS APPLY sys.dm_exec_sql_text (
			c.most_recent_sql_handle) AS t
		WHERE    r.status IN (
			N'running', N'runnable', N'suspended' )
	)
    SELECT	session_id ,
			status ,
			login_name ,
			text
    FROM CTE_Requests;
GO

EXECUTE dbo.Running_Requests;
GO

-- Cleanup
DROP PROCEDURE dbo.Running_Requests;
GO