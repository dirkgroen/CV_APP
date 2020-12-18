



create PROCEDURE [stg].[usp_Branche]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Branche]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Branche table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Branche]
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
IF OBJECT_ID('stg.Branche', 'U') IS NOT NULL 
DROP TABLE [stg].[Branche];

--Connectie met Branchebestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'branche.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Branche]
FROM
 OPENJSON ( @json )
WITH 
	(
	
			id									INT
,			sbi_code							NVARCHAR(150)

,			omschrijving						NVARCHAR(150)
,			unapproved							NVARCHAR(50)
,			vertalingen							NVARCHAR(150)
,			branche_id							NVARCHAR(150)		'$.branche.id'	
,			Branche_name						NVARCHAR(250)		'$.branche.vertalingen'
,			taal_id								NVARCHAR(50)		'$.taal.id'		
,			taal_naam							NVARCHAR(250)		'$.taal.name'	
,			count_medewerkers					NVARCHAR(250)
,			nederlands							NVARCHAR(150)
,			engels								NVARCHAR(150)

,			created_at							DATE






)


END