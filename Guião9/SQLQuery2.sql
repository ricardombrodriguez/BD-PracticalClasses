!-- a)USE AdventureWorks2012;CREATE TABLE mytemp (
	rid BIGINT /*IDENTITY (1, 1)*/ NOT NULL,
	at1 INT NULL,
	at2 INT NULL,
	at3 INT NULL,	
	lixo varchar(100) NULL
);ALTER TABLE mytemp ADD CONSTRAINT PK_RID PRIMARY KEY CLUSTERED (rid);-- b)-- Record the Start Time
DECLARE @start_time DATETIME, @end_time DATETIME;
SET @start_time = GETDATE();
PRINT @start_time

-- Generate random records
DECLARE @val as int = 1;
DECLARE @nelem as int = 50000;

SET nocount ON

WHILE @val <= @nelem
BEGIN
	DBCC DROPCLEANBUFFERS; -- need to be sysadmin

	INSERT mytemp (rid, at1, at2, at3, lixo)
	SELECT cast((RAND()*@nelem*40000) as int), cast((RAND()*@nelem) as int),
		cast((RAND()*@nelem) as int), cast((RAND()*@nelem) as int),
		'lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo';
	SET @val = @val + 1;
END
PRINT 'Inserted ' + str(@nelem) + ' total records'

-- Duration of Insertion Process
 SET @end_time = GETDATE();
PRINT 'Milliseconds used: ' + CONVERT(VARCHAR(20), DATEDIFF(MILLISECOND,
@start_time, @end_time));

-- Resultados:
-- Fragmentação dos indices: 99,27 %
-- Ocupação das páginas: 69,44 %
-- Milliseconds used: 65606




-- c)

DELETE FROM mytemp;
ALTER TABLE mytemp ADD CONSTRAINT PK_RID PRIMARY KEY CLUSTERED (rid) WITH (FILLFACTOR = 65);

-- Resultados:
-- Fragmentação dos indices: 98,92 %
-- Ocupação das páginas: 68,78 %
-- Milliseconds used: 121860

-----------------------------

DELETE FROM mytemp;
ALTER TABLE mytemp ADD CONSTRAINT PK_RID PRIMARY KEY CLUSTERED (rid) WITH (FILLFACTOR = 80);

-- Resultados:
-- Fragmentação dos indices: 98,93 %
-- Ocupação das páginas: 68,12 %
-- Milliseconds used: 132743

-----------------------------

DELETE FROM mytemp;
ALTER TABLE mytemp ADD CONSTRAINT PK_RID PRIMARY KEY CLUSTERED (rid) WITH (FILLFACTOR = 90);

-- Resultados:
-- Fragmentação dos indices: 99.01%
-- Ocupação das páginas: 69,88%
-- Milliseconds used: 85021

-----------------------------

-- d)

DROP TABLE mytemp
CREATE TABLE mytemp (
	rid BIGINT IDENTITY (1, 1) NOT NULL,
	at1 INT NULL,
	at2 INT NULL,
	at3 INT NULL,	
	lixo varchar(100) NULL
);

-- Record the Start Time
DECLARE @start_time DATETIME, @end_time DATETIME;
SET @start_time = GETDATE();
PRINT @start_time

-- Generate random records
DECLARE @val as int = 1;
DECLARE @nelem as int = 50000;

SET nocount ON

WHILE @val <= @nelem
BEGIN
	DBCC DROPCLEANBUFFERS; -- need to be sysadmin

	INSERT mytemp (at1, at2, at3, lixo)
	SELECT cast((RAND()*@nelem) as int),
		cast((RAND()*@nelem) as int), cast((RAND()*@nelem) as int),
		'lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo';
	SET @val = @val + 1;
END
PRINT 'Inserted ' + str(@nelem) + ' total records'

-- Duration of Insertion Process
 SET @end_time = GETDATE();
PRINT 'Milliseconds used: ' + CONVERT(VARCHAR(20), DATEDIFF(MILLISECOND,
@start_time, @end_time));


-- Resultados:
-- Milliseconds used: 125366


-- e)

DROP TABLE mytemp
CREATE TABLE mytemp (
	rid BIGINT IDENTITY (1, 1) NOT NULL,
	at1 INT NULL,
	at2 INT NULL,
	at3 INT NULL,	
	lixo varchar(100) NULL
);

CREATE CLUSTERED INDEX AT1 ON mytemp(at1);
CREATE CLUSTERED INDEX AT2 ON mytemp(at2);
CREATE CLUSTERED INDEX AT3 ON mytemp(at3);
CREATE CLUSTERED INDEX LIXO ON mytemp(lixo);


-- Record the Start Time
DECLARE @start_time DATETIME, @end_time DATETIME;
SET @start_time = GETDATE();
PRINT @start_time

-- Generate random records
DECLARE @val as int = 1;
DECLARE @nelem as int = 50000;

SET nocount ON

WHILE @val <= @nelem
BEGIN
	DBCC DROPCLEANBUFFERS; -- need to be sysadmin

	INSERT mytemp (rid, at1, at2, at3, lixo)
	SELECT cast((RAND()*@nelem*40000) as int), cast((RAND()*@nelem) as int),
		cast((RAND()*@nelem) as int), cast((RAND()*@nelem) as int),
		'lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo';
	SET @val = @val + 1;
END
PRINT 'Inserted ' + str(@nelem) + ' total records'

-- Duration of Insertion Process
 SET @end_time = GETDATE();
PRINT 'Milliseconds used: ' + CONVERT(VARCHAR(20), DATEDIFF(MILLISECOND,
@start_time, @end_time));

-- Resultados:

-- Sem índices -> tempo: 77607
-- Com índices -> tempo: 107265



