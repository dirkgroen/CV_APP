



CREATE PROCEDURE [stg].[usp_Afdeling]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Afdeling]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Afdeling table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Afdeling]
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
IF OBJECT_ID('stg.Afdeling', 'U') IS NOT NULL 
DROP TABLE [stg].[Afdeling];

--Connectie met Afdelingbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'afdeling.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Afdeling]
FROM
 OPENJSON ( @json )
WITH 
	(
	
			id									INT
,			nederlands							NVARCHAR(150)
,			engels								NVARCHAR(150)
,			count_medewerkers					INT	

,			taal_id								NVARCHAR(50)		'$.taal.id'		
,			taal_naam							NVARCHAR(250)		'$.taal.name'	
,			unapproved							NVARCHAR(50)
,			[status]							NVARCHAR(50)
,			naam								NVARCHAR(250)
,			afdeling_id							NVARCHAR(50)		'$.afdeling.id'
,			afdeling_name						NVARCHAR(250)		'$.afdeling.vertalingen'
,			hoofditem							NVARCHAR(50)
,			vertalingen							NVARCHAR(150)
,			created_at							DATE
,			updated_at							DATE

)


END