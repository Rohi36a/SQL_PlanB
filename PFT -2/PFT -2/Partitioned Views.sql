/*
SQL Server Partitioned Views enable you to logically split huge amount of data 
that exist in large tables into smaller pieces of data ranges, based on specific 
column values, and store this data ranges in the participating tables. 

To achieve this, a CHECK constraint should be defined on the partitioning column 
to divide the data into data ranges. QUERY OPTIMISER can ensure the best exeution plan.

A Distributed Partitioned View contains participating tables 
from multiple SQL Server instances, which can be used to distribute 
data processing load across multiple servers. 
*/

CREATE DATABASE  [SQL School.com]  
GO

USE [SQL School.com]  
GO



CREATE TABLE Shipments_Q1 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q1 CHECK (Ship_Quarter = 1),
CONSTRAINT PK_Shipments_Q1 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
 
GO
CREATE TABLE Shipments_Q2 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q2 CHECK (Ship_Quarter = 2),
CONSTRAINT PK_Shipments_Q2 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
 
GO
CREATE TABLE Shipments_Q3 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q3 CHECK (Ship_Quarter = 3),
CONSTRAINT PK_Shipments_Q3 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
 
GO
CREATE TABLE Shipments_Q4 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q4 CHECK (Ship_Quarter = 4),
CONSTRAINT PK_Shipments_Q4 PRIMARY KEY (Ship_Num, Ship_Quarter)
);


CREATE VIEW DBO.Shipments_Info
WITH SCHEMABINDING
AS
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q1
UNION ALL
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q2
UNION ALL
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q3
UNION ALL
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q4



INSERT INTO DBO.Shipments_Info VALUES(1117,'JOR',GETDATE(),1)
INSERT INTO DBO.Shipments_Info VALUES(1118,'JFK',GETDATE(),2)
INSERT INTO DBO.Shipments_Info VALUES(1119,'CAS',GETDATE(),3)
INSERT INTO DBO.Shipments_Info VALUES(1120,'BEY',GETDATE(),4)


select * FROM DBO.Shipments_Info

SELECT * FROM DBO.Shipments_Q1
SELECT * FROM DBO.Shipments_Q2
SELECT * FROM DBO.Shipments_Q3
SELECT * FROM DBO.Shipments_Q4





select * FROM DBO.Shipments_Info  WHERE Ship_Num = 1119


select * FROM DBO.Shipments_Info WHERE Ship_Quarter  = 4



SELECT * FROM SYSPROCESSES 

SET STATISTICS TIME ON
SELECT * FROM DBO.Shipments_Info WHERE [Ship_Num] = 1119
GO
SELECT * FROM DBO.Shipments_Info WHERE [Ship_Quarter] = 3
SET STATISTICS TIME OFF






