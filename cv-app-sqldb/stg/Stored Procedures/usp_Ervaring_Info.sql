



create PROCEDURE [stg].[usp_Ervaring_Info]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Ervaring_Info]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Ervaring_Info table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Ervaring_Info]
###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200529	ADB				Initiele versie
###################################################################################################################################################################################
*/


BEGIN

SET NOCOUNT ON 

--Declaratie variabelen
	  DECLARE @json				NVARCHAR(MAX)
      DECLARE @sqlStatement		NVARCHAR(MAX)


--drop table if exists
IF OBJECT_ID('stg.Ervaring_Info', 'U') IS NOT NULL 
DROP TABLE [stg].[Ervaring_Info];

--Connectie met Ervaring_Infobestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'ervaring_info.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Ervaring_Info]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id										INT
,                       actief								NVARCHAR(100)
,                       branche_id							NVARCHAR(100)			'$.branche.id' 
,                       branche_vertalingen					NVARCHAR(100)			'$.branche.vertalingen' 
,                       bron								NVARCHAR(100)
,                       created_at							NVARCHAR(100)
,                       creator_id							NVARCHAR(100)			'$.creator.id' 
,                       creator_name						NVARCHAR(100)			'$.creator.name'
,                       datum_sortering						NVARCHAR(100)
,                       datum_tot							NVARCHAR(100)
,                       datum_van							NVARCHAR(100)
,                       engels								NVARCHAR(100)
,                       ervaring							NVARCHAR(100)			'$.ervaring.id' 
,                       ervaring_geldige_datum				NVARCHAR(100)			'$.ervaring_geldige_datum.id' 
,                       naam								NVARCHAR(100)

,                       nederlands							NVARCHAR(100)
,                       nederlands_alternative_expression	NVARCHAR(100)
,                       project								NVARCHAR(100)
,                       updated_at							NVARCHAR(100)









)


END