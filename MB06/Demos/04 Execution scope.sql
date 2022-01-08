USE master;
GO

-----------------------------------------------------------------

-- Does this work?
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
	WHERE r.status IN ( N'running', N'runnable', N'suspended' )
)
GO

SELECT	session_id ,
		status ,
		login_name ,
		text
FROM CTE_Requests;
GO

-----------------------------------------------------------------

-- And does this work?
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
	WHERE r.status IN ( N'running', N'runnable', N'suspended' )
)
SELECT	session_id ,
		status ,
		login_name ,
		text
FROM CTE_Requests
WHERE session_id = @@SPID;

SELECT	session_id ,
		status ,
		login_name ,
		text
FROM CTE_Requests
WHERE session_id <> @@SPID;
GO

-----------------------------------------------------------------

-- And this?
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
	WHERE r.status IN ( N'running', N'runnable', N'suspended' )
)
SELECT	session_id ,
		status ,
		login_name ,
		text
FROM CTE_Requests
WHERE session_id = @@SPID
UNION ALL
SELECT  session_id ,
		status ,
		login_name ,
		text
FROM CTE_Requests
WHERE session_id <> @@SPID;
GO