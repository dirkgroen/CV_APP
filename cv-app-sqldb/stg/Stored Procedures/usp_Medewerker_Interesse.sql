



CREATE PROCEDURE [stg].[usp_Medewerker_Interesse]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Medewerker_Interesse]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Medewerker_Interesse table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Medewerker_Interesse]
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
IF OBJECT_ID('stg.Medewerker_Interesse', 'U') IS NOT NULL 
DROP TABLE [stg].[Medewerker_Interesse];

--Connectie met Medewerker_Interessebestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'medewerker_interesse.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Medewerker_Interesse]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id									INT
,                       bron								NVARCHAR(100)
,                       parent_version_id					NVARCHAR(100)			'$.parent_version.id'
,                       naam								NVARCHAR(100)
,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)

,                       Medewerker_id						NVARCHAR(100)			'$.medewerker.id'
,                       Medewerker_naam						NVARCHAR(100)			'$.medewerker.naam'
,                       creator_id							NVARCHAR(100)			'$.creator.id' 
,                       creator_name						NVARCHAR(100)			'$.creator.name' 
,                       actief								NVARCHAR(100)




)


END