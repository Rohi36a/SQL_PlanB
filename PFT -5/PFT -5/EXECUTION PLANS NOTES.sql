CREATE DATABASE execTestDB 

use execTestDB

SELECT * INTO tblExecAnalysis FROM SYSMESSAGES 


SELECT * FROM tblExecAnalysis



SELECT * FROM SYS.DM_EXEC_QUERY_STATS  

SELECT * FROM SYS.DM_EXEC_QUERY_STATS  
ORDER BY  TOTAL_WORKER_TIME  DESC 


SELECT * FROM SYS.DM_EXEC_CACHED_PLANS		-- THIS IS A MEMORY OBJECT USED TO SPECIFY PARSE PLANS, EXECUTION PLANS
											-- PROCEDURE CACHE

SELECT * FROM SYS.dm_exec_query_plan (0x06001200E8DC5C22907C92B19D00000001000000000000000000000000000000000000000000000000000000)




-- SAMPLE QUERY FOR EXECUTION PLAN ANALYSIS:
SELECT  [cp].[refcounts] 
       ,[cp].[usecounts] 
       ,[cp].[objtype] 
       ,[st].[dbid] 
       ,[st].[objectid] 
       ,[st].[text] 
       ,[qp].[query_plan] 
FROM    sys.dm_exec_cached_plans cp 
        CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st 
        CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp ; 


DBCC FREEPROCCACHE()

SELECT * FROM SYS.DM_EXEC_CACHED_PLANS



--- HOW TO CONTROL THE EXECUTION PLANS?
SELECT * FROM tblExecAnalysis   -- TABLE SCAN


SELECT * FROM tblExecAnalysis
WHERE 
ERROR > 10000


CREATE NONCLUSTERED INDEX NCIX_EXEC_PLAN_RECM
ON [dbo].[tblExecAnalysis] ([error])
INCLUDE ([severity],[dlevel],[description],[msglangid])


SELECT * FROM tblExecAnalysis
WHERE 
ERROR > 10000

DROP INDEX [tblExecAnalysis].NCIX_EXEC_PLAN_RECM 



-- EXAMPLE FOR EXEC PLANS WITH JOIN OPTIONS:
SELECT * FROM tblExecAnalysis AS T1
JOIN
tblExecAnalysis AS T2
ON
T1.[ERROR] = T2.[ERROR] 
WHERE 
T1.[ERROR] < 1000
OPTION (MERGE JOIN )
GO


SELECT * FROM tblExecAnalysis AS T1
JOIN
tblExecAnalysis AS T2
ON
T1.[ERROR] = T2.[ERROR] 
WHERE 
T1.[ERROR] < 1000
OPTION (LOOP JOIN )


