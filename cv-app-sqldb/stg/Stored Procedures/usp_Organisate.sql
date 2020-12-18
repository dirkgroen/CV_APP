



CREATE PROCEDURE [stg].[usp_Organisate]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Organisate]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Organisate table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Organisate]
###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200731	ADB				Initiele versie
###################################################################################################################################################################################
*/


BEGIN

SET NOCOUNT ON 

--Declaratie variabelen
	  DECLARE @json				NVARCHAR(MAX)
      DECLARE @sqlStatement		NVARCHAR(MAX)


--drop table if exists
IF OBJECT_ID('stg.Organisate', 'U') IS NOT NULL 
DROP TABLE [stg].[Organisate];

--Connectie met Organisatebestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'organisate.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Organisate]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id									INT
,                       nederlands							NVARCHAR(100)	
,                       nederlands_alternatieve_expression	NVARCHAR(100)	
,                       engels_alternatieve_expression		NVARCHAR(100)
,                       vertalingen							NVARCHAR(100)	
,                       count_medewerkers					NVARCHAR(100)

,                       unapproved							NVARCHAR(100)
,                       engels								NVARCHAR(100)	
,                       hoofditem							NVARCHAR(100)
,                       approved							NVARCHAR(100)	
	
,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)




)


END