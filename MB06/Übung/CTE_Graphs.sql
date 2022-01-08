USE MASTER;
GO
IF EXISTS(SELECT * FROM sys.databases WHERE NAME = 'CTEExercise') BEGIN
	DROP DATABASE CTEExercise;
END;
GO
CREATE DATABASE CTEExercise;
ALTER DATABASE CTEExercise SET RECOVERY SIMPLE WITH NO_WAIT;
GO
USE CTEExercise;
GO


	CREATE TABLE pairs (
		from_city VARCHAR(255) NOT NULL,
		to_city VARCHAR(255) NOT NULL,
		distance INTEGER NOT NULL,
		PRIMARY KEY(from_city, to_city),
		CHECK (from_city < to_city)
	);


	INSERT INTO pairs
	VALUES
	('Bari','Bologna',672),
	('Bari','Genova',944),
	('Bari','Milano',881),
	('Bari','Napoli',257),
	('Bari','Palermo',708),
	('Bologna','Genova',190),
	('Bologna','Milano',200),
	('Bologna','Napoli',470),
	('Bologna','Palermo',730),
	('Bologna','Roma',300), 
	('Genova','Milano',120),
	('Genova','Napoli',590),
	('Genova','Palermo',790),
	('Genova','Roma',400),
	('Milano','Napoli',660),
	('Milano','Palermo',890),
	('Milano','Roma',480),
	('Napoli','Palermo',310),
	('Napoli','Roma',190),
	('Palermo','Roma',430);


	SELECT * FROM pairs;


-- Paths from Palermo to Milano...
;WITH both_ways (
    from_city,
    to_city,
    distance
) /* Working Table containing all ways */
AS (
    SELECT
        from_city,
        to_city,
        distance
    FROM pairs
UNION ALL
    SELECT
        to_city AS "from_city",
        from_city AS "to_city",
        distance
    FROM pairs
),
paths (
    from_city,
    to_city,
    distance,
    path,
    Step
)
AS (
    SELECT
        from_city,
        to_city,
        distance,
        CAST('['+from_city+']' AS varchar(MAX)) AS "path",
        1 Step
    FROM both_ways b1
    WHERE b1.from_city = 'Palermo' --<<< Start Node >>>
  UNION ALL
    SELECT
        b2.from_city,
        b2.to_city,
        p.distance + b2.distance,
        p.path + '['+b2.from_city+']',
        p.Step+1
    FROM both_ways b2
    JOIN paths p
         ON (p.to_city = b2.from_city
             AND CHARINDEX('['+b2.from_city+']',p.path)=0 /* Prevent re-tracing */
             AND p.Step < 6)
)
SELECT TOP 5
    REPLACE(REPLACE(REPLACE(path,'][',','),'[',''),']',',') + to_city AS "path",
    distance
FROM paths
WHERE to_city = 'Milano'  --<<< End node >>>

  AND CHARINDEX('[Napoli]',path)>0
  AND CHARINDEX('[Roma]',path)>0
  AND CHARINDEX('[Bari]',path)>0  -- <<< via... >>>

ORDER BY distance, path