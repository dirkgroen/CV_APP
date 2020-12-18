




CREATE PROCEDURE [stg].[usp_Medewerker_Kennis]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Medewerker_Kennis]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Medewerker_Kennis table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Medewerker_Kennis]
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
IF OBJECT_ID('stg.Medewerker_Kennis', 'U') IS NOT NULL 
DROP TABLE [stg].[Medewerker_Kennis];

--Connectie met Medewerker_Kennisbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'medewerker_kenni.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Medewerker_Kennis]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id											INT


,                       medewerker_kennis						NVARCHAR(100)			'$.medewerker_kennis.id'
,                       kennis_controle_id						NVARCHAR(100)			'$.kennis_controle.id'
,                       kennis_controle_vertalingen				NVARCHAR(100)			'$.kennis_controle.vertalingen'
,                       updated_at								NVARCHAR(100)

,                       export									NVARCHAR(100)
,                       created_at								NVARCHAR(100)
,                       ervaring_info							NVARCHAR(100)			'$.ervaring_info.id'
,                       score_kennis							NVARCHAR(100)
,                       medewerker_id							NVARCHAR(100)			'$.medewerker.id'
,                       medewerker_naam							NVARCHAR(100)			'$.medewerker.naam'



)


END