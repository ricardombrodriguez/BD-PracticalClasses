USE p9g5;
GO

CREATE SCHEMA EMPRESA;
GO

CREATE TABLE EMPRESA.department (
	Dname VARCHAR(100) NOT NULL,
	Dnumber INT NOT NULL PRIMARY KEY,
	-- o mgr_ssn é criado depois
	Mgr_start_date DATE
);
GO

CREATE TABLE EMPRESA.employee (
	Fname VARCHAR(50) NOT NULL,
	Minit VARCHAR(2) NOT NULL,
	Lname VARCHAR(50) NOT NULL,
	Ssn INT NOT NULL PRIMARY KEY,
	Bdate DATE NOT NULL,
	Address VARCHAR(100) NOT NULL,
	Sex VARCHAR(20) NOT NULL,
	Salary INT NOT NULL,
	Super_ssn INT FOREIGN KEY REFERENCES EMPRESA.employee(Ssn),
	Dno INT NOT NULL FOREIGN KEY REFERENCES EMPRESA.department(Dnumber)

);
GO

ALTER TABLE EMPRESA.department ADD Mgr_ssn INT FOREIGN KEY REFERENCES EMPRESA.employee(Ssn);
GO

CREATE TABLE EMPRESA.dept_locations (
	Dnumber INT NOT NULL FOREIGN KEY REFERENCES EMPRESA.department(Dnumber),
	Dlocation VARCHAR(100) NOT NULL PRIMARY KEY
);
GO

CREATE TABLE EMPRESA.project (
	Pname VARCHAR(100) NOT NULL,
	Pnumber INT NOT NULL PRIMARY KEY,
	Plocation VARCHAR(100) NOT NULL,
	Dnum INT NOT NULL FOREIGN KEY REFERENCES EMPRESA.department(Dnumber)
);
GO

CREATE TABLE EMPRESA.works_on (
	Essn INT NOT NULL FOREIGN KEY REFERENCES EMPRESA.employee(Ssn),
	Pno INT NOT NULL FOREIGN KEY REFERENCES EMPRESA.project(Pnumber),
	Hours INT NOT NULL
);
GO

CREATE TABLE EMPRESA.dependent (
	Essn INT NOT NULL FOREIGN KEY REFERENCES EMPRESA.employee(Ssn),
	Dependent_name VARCHAR(100) NOT NULL PRIMARY KEY,
	Sex VARCHAR(20) NOT NULL,
	Bdate DATE NOT NULL,
	Relationship VARCHAR(100) NOT NULL

);
GO

INSERT INTO EMPRESA.department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Investigacao', 1, NULL, NULL);
INSERT INTO EMPRESA.department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Comercial', 2, NULL, NULL);
INSERT INTO EMPRESA.department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Logistica', 3, NULL, NULL);
INSERT INTO EMPRESA.department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Recurso Humanos', 4, NULL, NULL);
INSERT INTO EMPRESA.department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Desporto', 5, NULL, NULL);

SELECT * FROM EMPRESA.department

INSERT INTO EMPRESA.dept_locations (Dnumber, Dlocation) VALUES (2, 'Aveiro')
INSERT INTO EMPRESA.dept_locations (Dnumber, Dlocation) VALUES (3, 'Coimbra')

SELECT * FROM EMPRESA.dept_locations

INSERT INTO EMPRESA.employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex,Salary,Super_Ssn, Dno) VALUES ('Paula','A','Sousa',183623612,'2001-08-11','Rua da FRENTE','F',1450,null,3);
INSERT INTO EMPRESA.employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex,Salary,Super_Ssn, Dno) VALUES ('Carlos','D','Gomes',21312332,'2000-01-01','Rua XPTO','M',1200,null,1);
INSERT INTO EMPRESA.employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex,Salary,Super_Ssn, Dno) VALUES ('Juliana','A','Amaral',321233765,'1980-08-11','Rua BZZZZ','F',1350,null,3);
INSERT INTO EMPRESA.employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex,Salary,Super_Ssn, Dno) VALUES ('Maria','I','Pereira',342343434,'2001-05-01','Rua JANOTA','F',1250,21312332,1);	
INSERT INTO EMPRESA.employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex,Salary,Super_Ssn, Dno) VALUES ('Joao','G','Costa',41124234,'2001-01-01','Rua YGZ','M',1300,21312332,2);	
INSERT INTO EMPRESA.employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex,Salary,Super_Ssn, Dno) VALUES ('Ana','L','Silva',12652121,'1990-03-03','Rua ZIG ZAG','F',1400,21312332,2);	

SELECT * FROM EMPRESA.employee;


INSERT INTO EMPRESA.project (Pname,Pnumber,Plocation,Dnum) VALUES ('Aveiro Digital', 1, 'Aveiro', 3);
INSERT INTO EMPRESA.project (Pname,Pnumber,Plocation,Dnum) VALUES ('BD Open Day', 2, 'Espinho', 2);
INSERT INTO EMPRESA.project (Pname,Pnumber,Plocation,Dnum) VALUES ('Dicoogle', 3, 'Aveiro', 3);
INSERT INTO EMPRESA.project (Pname,Pnumber,Plocation,Dnum) VALUES ('GOPACS', 4, 'Aveiro', 3);

SELECT * FROM EMPRESA.project;


INSERT INTO EMPRESA.works_on (Essn, Pno, HOURS) VALUES (183623612, 1, 20);
INSERT INTO EMPRESA.works_on (Essn, Pno, HOURS) VALUES (183623612, 3, 10);
INSERT INTO EMPRESA.works_on (Essn, Pno, HOURS) VALUES (21312332, 1, 20);
INSERT INTO EMPRESA.works_on (Essn, Pno, HOURS) VALUES (321233765, 1, 25);
INSERT INTO EMPRESA.works_on (Essn, Pno, HOURS) VALUES (342343434, 1, 20);
INSERT INTO EMPRESA.works_on (Essn, Pno, HOURS) VALUES (342343434, 4, 25);
INSERT INTO EMPRESA.works_on (Essn, Pno, HOURS) VALUES (41124234, 2, 20);
INSERT INTO EMPRESA.works_on (Essn, Pno, HOURS) VALUES (41124234, 3, 30);

SELECT * FROM EMPRESA.works_on;

INSERT INTO EMPRESA.dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (21312332, 'Joana Costa', 'F', '2008-04-01', 'Filho');
INSERT INTO EMPRESA.dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (21312332, 'Maria Costa', 'F', '1990-10-05', 'Neto');
INSERT INTO EMPRESA.dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (21312332, 'Rui Costa', 'M', '2000-08-04', 'Neto');
INSERT INTO EMPRESA.dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (321233765, 'Filho Lindo', 'M', '2001-02-22', 'Filho');
INSERT INTO EMPRESA.dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (342343434, 'Rosa Lima', 'F', '2006-03-11', 'Filho');
INSERT INTO EMPRESA.dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (41124234, 'Ana Sousa', 'F', '2007-04-13', 'Neto');
INSERT INTO EMPRESA.dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (41124234, 'Gaspar Pinto', 'M', '2006-02-08', 'Sobrinho');

SELECT * FROM EMPRESA.department;

UPDATE EMPRESA.department SET Mgr_ssn = 21312332, Mgr_start_date = '2010-08-02' WHERE Dnumber = 1;
UPDATE EMPRESA.department SET Mgr_ssn = 321233765, Mgr_start_date = '2013-05-16' WHERE Dnumber = 2;
UPDATE EMPRESA.department SET Mgr_ssn = 41124234, Mgr_start_date = '2013-05-16' WHERE Dnumber = 3;
UPDATE EMPRESA.department SET Mgr_ssn = 12652121, Mgr_start_date = '2014-04-02' WHERE Dnumber = 4;