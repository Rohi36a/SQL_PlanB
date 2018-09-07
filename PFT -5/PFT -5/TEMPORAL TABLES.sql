
TEMPORAL TABLES: 

	A NEW FEATURE FROM SQL SERVER 2016 AND HIGHER VERSIONS.
	A MECHANISM TO CREATE ADDITIONAL HISTORY "TRACKING" TABLES BASED ON THE COMMITTED DML OPERATIONS.

	WHENVER WE CREATE A BASE TABLE, ONE "HISTORY TABLE "  / "TEMPORAL TABLE" IS AUTO CREATED.
	IF WE PERFORM ANY INSERTS / UPDATES / DELETES ON THE BASE TABLE THEN ALL THE PREVIOUS VERSION OF DATA
	IS MAINTAINED IN TEMPORAL TABLES. 

		EX: IF ORIGINAL VALUE OF A COLUMN IS a
		    WE PERFORMED AN UPDATE TO VALUE  b
		    THEN THE TEMPORAL TABLE CONTAINS VALUE a WHILE THE BASE TABLE CONTAINS UPDATED VALUE b
		

HOW TO IMPLEMENT TEMPORAL TABLES?
	
	STEP 1: DEFINE A TABLE WITH PRIMARY KEY  = CLUSTERED INDEX

	STEP 2: WHILE DEIFNING THE BASE TABLE, INCLUDE TEMPORAL TABLE CREATION OPTION

	STEP 3: PERFORM INSERTS AND THEN UPDATES TO THE BASE TABLE
		LOG ON TO TEMPORAL TABLE AND VERIFY THE CHANGES.


PURPOSE OF TEMPORAL TABLES?
	USED FOR HISTORICAL DATA TRACKING
	USED FOR TRACKING CHANGES IN CASE OF ETL & DWH DESIGN  (DATAWAREHOUSE)
					ETL : EXTRACTTION OF DATA	
						TRANSFORMATION OF DATA
							LOADING OF DATA.

	THIS TEMPORAL TABLES IS AN ALTERNATIVE FOR "CDC" : CHANGE DATA CAPTURE


