



CREATE PROCEDURE [stg].[usp_Medewerker_Opleiding]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Medewerker_Opleiding]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Medewerker_Opleiding table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Medewerker_Opleiding]
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
IF OBJECT_ID('stg.Medewerker_Opleiding', 'U') IS NOT NULL 
DROP TABLE [stg].[Medewerker_Opleiding];

--Connectie met Medewerker_Opleidingbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'medewerker_opleiding.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Medewerker_Opleiding]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id									INT
,                       jaar_van							NVARCHAR(100)
,                       instituut_id						NVARCHAR(100)			'$.instituut.id' 
,                       instituut_vertalingen				NVARCHAR(100)			'$.instituut.vertalingen' 
,                       frontpage							NVARCHAR(100)
,                       export								NVARCHAR(100)
,						medewerker_id						NVARCHAR(100)			'$.medewerker.id' 
,						medewerker_naam						NVARCHAR(100)			'$.medewerker.naam' 
,                       opleiding_id						NVARCHAR(100)			'$.opleiding.id'
,                       opleiding_vertalingen				NVARCHAR(100)			'$.opleiding.vertalingen'
,                       opleiding_soort_id					NVARCHAR(100)			'$.opleiding_soort.id'
,                       jaar_tot							NVARCHAR(100)
,                       diploma_certificaat					NVARCHAR(100)
,                       creator_id								NVARCHAR(100)			'$.creator.id' 
,                       creator_name							NVARCHAR(100)			'$.creator.name' 

,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)


)


END