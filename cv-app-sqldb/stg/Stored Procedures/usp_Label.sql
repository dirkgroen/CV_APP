



CREATE PROCEDURE [stg].[usp_Label]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Label]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Label table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Label]
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
IF OBJECT_ID('stg.Label', 'U') IS NOT NULL 
DROP TABLE [stg].[Label];

--Connectie met Labelbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'label.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Label]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id										INT
,                       engels								NVARCHAR(100)
,                       nederlands							NVARCHAR(100)
,                       naam								NVARCHAR(100)
,                       tekst								NVARCHAR(100)
,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)
,                       taal_id								NVARCHAR(100)			'$.taal.id'
,                       taal_name							NVARCHAR(100)			'$.taal.name'
,                       [label_id]							NVARCHAR(100)			'$.label.id'
,                       label_naam							NVARCHAR(100)			'$.label.naam'



)


END