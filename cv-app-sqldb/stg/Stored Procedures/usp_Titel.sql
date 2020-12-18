



CReate PROCEDURE [stg].[usp_Titel]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Titel]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Titel table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Titel]
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
IF OBJECT_ID('stg.Titel', 'U') IS NOT NULL 
DROP TABLE [stg].[Titel];

--Connectie met Titelbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'titel.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Titel]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id									INT
,                       hoofditem							NVARCHAR(100)	
,                       soort								NVARCHAR(100)	
,                       [status]							NVARCHAR(100)
,                       unapproved							NVARCHAR(100)
,                       titel								NVARCHAR(100)
,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)




)


END