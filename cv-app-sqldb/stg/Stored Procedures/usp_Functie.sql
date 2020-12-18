




CREATE PROCEDURE [stg].[usp_Functie]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Functie]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Functie table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Functie]
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
IF OBJECT_ID('stg.Functie', 'U') IS NOT NULL 
DROP TABLE [stg].[Functie];

--Connectie met Functiebestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'functie.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Functie]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id									INT
,                       nederlands							NVARCHAR(100)
,                       updated_at							NVARCHAR(100)
,                       vertalingen							NVARCHAR(100)
,                       functie_id							NVARCHAR(100)			'$.functie.id'
,                       functie_vertalingen					NVARCHAR(100)			'$.functie.vertalingen'
,                       hoofditem							NVARCHAR(100)
,                       taal_id								NVARCHAR(100)			'$.taal.id'
,                       taal_name							NVARCHAR(100)			'$.taal.name'
,                       created_at							NVARCHAR(100)
,                       [name]								NVARCHAR(100)
,                       engels								NVARCHAR(100)
,                       omschrijving						NVARCHAR(100)
,                       approved							NVARCHAR(100)
,                       unapproved							NVARCHAR(100)
,                       on_profile							NVARCHAR(100)
,                       count_medewerkers					NVARCHAR(100)




)


END