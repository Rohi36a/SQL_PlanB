
CREATE TABLE Documents
(
 id INT IDENTITY(1,1) NOT NULL,
 title NVARCHAR(100) NOT NULL,
 doctype NCHAR(4) NOT NULL,
 docexcerpt NVARCHAR(1000) NOT NULL,
 doccontent VARBINARY(MAX) NOT NULL,  -- UPTO 2 GB OF DATA CAN BE STORED IN THS COOLUMN - PER VALUE
 CONSTRAINT PK_Documents PRIMARY KEY CLUSTERED(id)
);



INSERT INTO dbo.Documents
(title, doctype, docexcerpt, doccontent)
SELECT N'Columnstore Indices and Batch Processing',
 N'docx',
 N'You should use a columnstore index on your fact tables,
 putting all columns of a fact table in a columnstore index.
 In addition to fact tables, very large dimensions could benefit
 from columnstore indices as well.
 Do not use columnstore indices for small dimensions. ',
 bulkcolumn
FROM OPENROWSET(BULK 'E:\sqlschool\PlanB\PFT -3\PFT -3\SOURCE DOCS\ColumnstoreIndicesAndBatchProcessing.docx',
 SINGLE_BLOB) AS doc;


INSERT INTO dbo.Documents
(title, doctype, docexcerpt, doccontent)
SELECT N'Introduction to Data Mining',
 N'docx',
 N'Using Data Mining is becoming more a necessity for every company
 and not an advantage of some rare companies anymore. ',
 bulkcolumn
FROM OPENROWSET(BULK 'E:\sqlschool\PlanB\PFT -3\PFT -3\SOURCE DOCS\IntroductionToDataMining.docx',
 SINGLE_BLOB) AS doc;


INSERT INTO dbo.Documents
(title, doctype, docexcerpt, doccontent)
SELECT N'Why Is Bleeding Edge a Different Conference',
 N'docx',
 N'During high level presentations attendees encounter many questions.
 For the third year, we are continuing with the breakfast Q&A session.
 It is very popular, and for two years now,
 we could not accommodate enough time for all questions and discussions! ',
 bulkcolumn
FROM OPENROWSET(BULK 'E:\sqlschool\PlanB\PFT -3\PFT -3\SOURCE DOCS\WhyIsBleedingEdgeADifferentConference.docx',
 SINGLE_BLOB) AS doc;


INSERT INTO dbo.Documents
(title, doctype, docexcerpt, doccontent)
SELECT N'Additivity of Measures',
 N'docx',
 N'Additivity of measures is not exactly a data warehouse design problem.
 However, you have to realize which aggregate functions you will use
 in reports for which measure, and which aggregate functions
 you will use when aggregating over which dimension.',
 bulkcolumn
FROM OPENROWSET(BULK 'E:\sqlschool\PlanB\PFT -3\PFT -3\SOURCE DOCS\AdditivityOfMeasures.docx',
 SINGLE_BLOB) AS doc;

 -- BLOB : BINARY LARGE OBJECT DATA


 SELECT * FROM Documents


 -- REQ: HOW TO SEARCH THE TABLE CONTAINING ALL DOCUMENT DATA?
 -- REQ: HOW TO SEARCH THE binary DATA FOR MEANINGFUL CHARACTER VALUES?


 -- USING UI : WE DEFINED A FT INDEX

 -- HOW TO USE THE FT INDEX FOR ACTUAL QUERIES?
 SELECT * FROM [dbo].[Documents]
 WHERE
 CONTAINS(docexcerpt, 'Data')


SELECT * FROM [dbo].[Documents]
WHERE
CONTAINS(docexcerpt, 'Data')


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(doccontent, N'data OR index');  -- ERROR


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'data OR index');


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(doccontent, N'data AND NOT mining'); -- ERROR


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'data AND NOT mining');


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'data OR (fact AND warehouse)');  -- MULTIPLE OPERATORS


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'"data warehouse"');  -- USING PHRASE


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'"add*"');   -- USING PREFIX


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'NEAR(problem, data)');   -- CLOSE PROXIMITY


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'NEAR(problem, data, 5)');   -- MAXIMUM PROXIMITY LEVEL


-- INFLECTIONAL FORMS : VARIOUS FORMS OF A WORD. GO  = GONE, GOING, WENT...

SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'presentation');


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'FORMSOF(INFLECTIONAL, presentation)');
GO


SELECT D.id, D.title, CT.[RANK], D.docexcerpt
FROM CONTAINSTABLE(dbo.Documents, docexcerpt,
 N'data OR level') AS CT
 INNER JOIN dbo.Documents AS D
 ON CT.[KEY] = D.id
ORDER BY CT.[RANK] DESC;


SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE CONTAINS(docexcerpt, N'presentation');			-- REPORTS EXACT MATCH



SELECT id, title, docexcerpt
FROM dbo.Documents
WHERE FREETEXT(docexcerpt, N'presentation');			-- REPORTS EXACT & CLOSEST MATCH




/*

MISC INFO:

	1.	BY DEFAULT, FTS SERVICE IS STARTED.
		IF NOT, WE CAN ALSO START THE SERVICE MANUALLY.
			RUN >> SERVICES.MSC >> SQL SERVER FULL TEXT FILTER DAEMON LAUNCHER SERVICE >> RIGHT CLICK : START

	2.  BY DEFALT, DATABASE IS ENABLED FOR FTS.
		IF NOT, WE CAN ALSO ENABLE THE DATABASE FOR FTS MANUALLY.

		EXEC SP_FULLTEXT_DATABASE @ACTION = 'ENABLE'


	3. WE CAN VERIFY THE FT INSTALLATION:

		SELECT SERVERPROPERTY('IsFullTextInstalled')    -- 1 : MEANS FTS IS INSTALLED ON THIS INSTANCE
														-- 0 : MEANS FTS IS NOT INSTALLED ON THIS INSTANCE


	4. FULLTEXT FILTERS:
	--  FT Filters are installed in your instance
	SELECT document_type, path FROM sys.fulltext_document_types;


	5. HOW TO REPORT LIST OF ALL LANGUAGES SUPPORTED BY FTS?
	SELECT lcid, name FROM sys.fulltext_languages
	ORDER BY name;			-- LCID : LOCALE ID 


	6. HOW TO REPORT STOPWORDS INFORMATION?
	
	SELECT * FROM sys.fulltext_stoplists;
	SELECT stoplist_id, stopword, language FROM sys.fulltext_stopwords;


	7. HOW TO DISABLE FTS FOR THE DATABASE?
	EXEC SP_FULLTEXT_DATABASE @ACTION = 'DISABLE'  */








