



CREATE PROCEDURE [stg].[usp_Opleiding]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Opleiding]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Opleiding table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Opleiding]
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
IF OBJECT_ID('stg.Opleiding', 'U') IS NOT NULL 
DROP TABLE [stg].[Opleiding];

--Connectie met Opleidingbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'opleiding.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Opleiding]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id								INT



,                       approved									NVARCHAR(100)
,                       count_medewerkers							NVARCHAR(100)
,                       created_at									NVARCHAR(100)
,                       engels										NVARCHAR(100)
,                       engels_alternatieve_expression				NVARCHAR(100)
,                       hoofditem									NVARCHAR(100)
,                       [label]										NVARCHAR(100)

,                       nederlands									NVARCHAR(100)
,                       nederlands_alternatieve_expression			NVARCHAR(100)
,                       omschrijving								NVARCHAR(100)
,                       opleiding_id								NVARCHAR(100)			'$.opleiding.id'
,                       opleiding_vertalingen						NVARCHAR(100)			'$.opleiding.vertalingen'
,                       opleiding_soort								NVARCHAR(100)			'$.opleiding_soort.id'
,                       taal_id										NVARCHAR(100)			'$.taal.id'
,                       taal_name									NVARCHAR(100)			'$.taal.name'
,                       unapproved									NVARCHAR(100)
,                       updated_at									NVARCHAR(100)

,                       vertalingen_opleiding_soort					NVARCHAR(100)





)


END