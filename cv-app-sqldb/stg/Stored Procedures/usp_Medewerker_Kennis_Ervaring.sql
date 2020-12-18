



CREATE PROCEDURE [stg].[usp_Medewerker_Kennis_Ervaring]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Medewerker_Kennis_Ervaring]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Medewerker_Kennis_Ervaring table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Medewerker_Kennis_Ervaring]
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
IF OBJECT_ID('stg.Medewerker_Kennis_Ervaring', 'U') IS NOT NULL 
DROP TABLE [stg].[Medewerker_Kennis_Ervaring];

--Connectie met Medewerker_Kennis_Ervaringbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'medewerker_kennis_ervaring.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Medewerker_Kennis_Ervaring]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id									INT
,                       medewerker_kennis_id				NVARCHAR(100)			'$.medewerker_kennis.id'
,                       ervaring_info_id					NVARCHAR(100)			'$.ervaring_info.id'
,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)


)


END