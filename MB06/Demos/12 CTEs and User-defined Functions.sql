USE tempdb;
GO


-- Scalar user-defined function
CREATE FUNCTION dbo.total_concurrent_requests ( )
RETURNS SMALLINT
AS
    BEGIN

		DECLARE @output_count SMALLINT;

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
		SELECT  @output_count = COUNT(*)
		FROM CTE_Requests;

        RETURN(@output_count);
    END
GO

SELECT  dbo.total_concurrent_requests() AS
	concurrent_request_count;
GO

-- Multi-statement table-valued function
CREATE FUNCTION dbo.mstvf_concurrent_requests ( )
RETURNS @concurrent_requests TABLE
(
	session_id SMALLINT ,
    status NVARCHAR(30) ,
    login_name NVARCHAR(128) ,
    text NVARCHAR(MAX)
)
AS
    BEGIN
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
            WHERE r.status IN (
				N'running', N'runnable', N'suspended' )
		)
        INSERT  @concurrent_requests
        SELECT	session_id ,
                status ,
                login_name ,
                text
        FROM CTE_Requests;

        RETURN
    END
GO

SELECT	session_id ,
        status ,
        login_name ,
        text
FROM dbo.mstvf_concurrent_requests();
GO

-- Inline table-valued user-defined function
CREATE FUNCTION dbo.itvf_concurrent_requests ( )
RETURNS TABLE
AS 
RETURN
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
        WHERE r.status IN (
			N'running', N'runnable', N'suspended' )
	)
    SELECT  session_id ,
            status ,
            login_name ,
            text
    FROM CTE_Requests;
GO

SELECT  session_id ,
        status ,
        login_name ,
        text
FROM dbo.itvf_concurrent_requests();

-- Cleanup
DROP FUNCTION dbo.total_concurrent_requests;
DROP FUNCTION dbo.mstvf_concurrent_requests;
DROP FUNCTION dbo.itvf_concurrent_requests;
GO
