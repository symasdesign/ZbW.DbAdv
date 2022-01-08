USE tempdb;
GO

-- Triggers and CTEs

-- Demo tables
CREATE TABLE dbo.event_response
(
    event_id INT PRIMARY KEY CLUSTERED IDENTITY (1,1),
	event_name SYSNAME,
	event_date DATETIME2 (7)  DEFAULT SYSDATETIME ()
);
GO

CREATE TABLE dbo.concurrent_event_requests
(
    concurrent_event_requests_id INT
		PRIMARY KEY CLUSTERED IDENTITY (1,1),
	event_date DATETIME2 (7)  DEFAULT SYSDATETIME (),
	session_id SMALLINT,
    status NVARCHAR (30),
    login_name NVARCHAR (128),
    text NVARCHAR (max)
);
GO

CREATE TRIGGER dbo.trigger_event_response
ON dbo.event_response
AFTER INSERT
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
		WHERE r.status IN (
			N'running', N'runnable', N'suspended' )
	)
	INSERT dbo.concurrent_event_requests (
		session_id ,
		status ,
		login_name ,
		text)
    SELECT	session_id ,
			status ,
			login_name ,
			text
    FROM CTE_Requests;

GO

INSERT  dbo.event_response ( event_name )
VALUES ('Something happened!');
GO

SELECT event_id, event_name, event_date
FROM dbo.event_response;

SELECT	concurrent_event_requests_id,
		event_date,
		session_id,
		status,
		login_name,
		text
FROM dbo.concurrent_event_requests;
GO

-- Cleanup
DROP TABLE tempdb.dbo.event_response;

DROP TABLE tempdb.dbo.concurrent_event_requests;
GO
