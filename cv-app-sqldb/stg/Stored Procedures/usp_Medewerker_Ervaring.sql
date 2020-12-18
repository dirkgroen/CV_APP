



CREATE PROCEDURE [stg].[usp_Medewerker_Ervaring]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Medewerker_Ervaring]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Medewerker_Ervaring table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Medewerker_Ervaring]
###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200730	ADB				Initiele versie
###################################################################################################################################################################################
*/


BEGIN

SET NOCOUNT ON 

--Declaratie variabelen
	  DECLARE @json				NVARCHAR(MAX)
      DECLARE @sqlStatement		NVARCHAR(MAX)


--drop table if exists
IF OBJECT_ID('stg.Medewerker_Ervaring', 'U') IS NOT NULL 
DROP TABLE [stg].[Medewerker_Ervaring];

--Connectie met Medewerker_Ervaringbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'medewerker_ervaring.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Medewerker_Ervaring]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id								INT

,						medewerker_id					NVARCHAR(100)			'$.medewerker.id' 
,						medewerker_naam					NVARCHAR(100)			'$.medewerker.naam' 
,                       functie_id						NVARCHAR(100)			'$.functie.id' 
,                       functie_vertalingen				NVARCHAR(100)			'$.functie.vertalingen' 
,                       branche_id						NVARCHAR(100)			'$.branche.id' 
,                       branche_vertalingen				NVARCHAR(100)			'$.branche.vertalingen' 
,                       organisatie_id					NVARCHAR(100)			'$.organisatie.id' 
,                       organisatie_vertalingen			NVARCHAR(100)			'$.organisatie.vertalingen' 
,                       creator_id						NVARCHAR(100)			'$.creator.id' 
,                       creator_name					NVARCHAR(100)			'$.creator.name' 
,                       record							NVARCHAR(100)			'$.record.id' 
,                       users_id						NVARCHAR(100)			'$.user.id' 
,                       users_name						NVARCHAR(100)			'$.user.name' 
,                       [action]						NVARCHAR(100)
,                       created_at						NVARCHAR(100)
,                       date_tot						NVARCHAR(100)
,                       date_van						NVARCHAR(100)
,                       export							NVARCHAR(100)
,                       frontpage						NVARCHAR(100)
,                       [location]						NVARCHAR(100)
,                       mutations						NVARCHAR(100)
,                       updated_at						NVARCHAR(100)






)


END