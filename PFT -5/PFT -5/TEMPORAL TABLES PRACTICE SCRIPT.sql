CREATE DATABASE dbTemporalTables

USE dbTemporalTables 

create table Employee
(
Emp_ID int PRIMARY KEY CLUSTERED, 
Emp_name varchar(15),
Emp_desc varchar(100),
[ValidFrom] datetime2 (2) GENERATED ALWAYS AS ROW START,  -- A TIMESTAMP COLUMN
[ValidTo] datetime2 (2) GENERATED ALWAYS AS ROW END,	  -- A TIMESTAMP COLUMN
PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)   -- THIS IS A COMPUTED COLUMN
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.EmployeeHistory)); 


SELECT * FROM Employee					-- 0 ROWS
SELECT * FROM EmployeeHistory			-- 0 ROWS

insert into Employee(Emp_ID,Emp_name,Emp_desc) values ( 1001,'Steve Ley' ,'Program Manager , 5+ Exp, Excellent Communication Skills')
insert into Employee(Emp_ID,Emp_name,Emp_desc) values ( 1002,'Jonathan' ,'Executive Manager , 10+ Exp, Excellent Domain Skills')
insert into Employee(Emp_ID,Emp_name,Emp_desc) values ( 1003,'Jonathan Little' ,'Executive Manager , 10+ Exp, Excellent Domain Skills')
insert into Employee(Emp_ID,Emp_name,Emp_desc) values ( 1004, 'Little' ,'Executive Manager , 10+ Exp, Excellent Domain Skills')
insert into Employee(Emp_ID,Emp_name,Emp_desc) values ( 1005,'Jona' ,'Executive Manager , 10+ Exp, Excellent Domain Skills')
insert into Employee(Emp_ID,Emp_name,Emp_desc) values ( 1006,'Jonathan L' ,'Executive Manager , 10+ Exp, Excellent  Domain Skills')
insert into Employee(Emp_ID,Emp_name,Emp_desc) values ( 1007,'GEORE' ,'Executive Manager , 10+ Exp, Excellent Domain Skills')
insert into Employee(Emp_ID,Emp_name,Emp_desc) values ( 1008,'JEFF' ,'Executive Manager , 10+ Exp, Excellent Domain Skills')

SELECT * FROM Employee					-- 8 ROWS
SELECT * FROM EmployeeHistory			-- 0 ROWS

UPDATE Employee SET Emp_name = 'Steve'
where Emp_Id = 1001


SELECT * FROM Employee					-- 8 ROWS
SELECT * FROM EmployeeHistory			-- 1 ROWS


/*
VALIDFROM COLUMN @ BASE TABLE :	CONTAINS ROW INSERTED DATE  IF THERE IS NO ENTRIY FOR THE ROW IN HISTORY TABLE
								CONTAINS ROW UPDATE DATE  IF THERE IS AN ENTRIY FOR THE ROW IN HISTORY TABLE   */


UPDATE Employee SET Emp_name = 'Steves'
where Emp_Id = 1001


SELECT * FROM Employee					-- 8 ROWS
SELECT * FROM EmployeeHistory			-- 2 ROWS











 

