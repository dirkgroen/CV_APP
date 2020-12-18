



create PROCEDURE [stg].[usp_Instituut]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Instituut]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Instituut table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Instituut]
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
IF OBJECT_ID('stg.Instituut', 'U') IS NOT NULL 
DROP TABLE [stg].[Instituut];

--Connectie met Instituutbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'instituut.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Instituut]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id										INT

,                       count_medewerkers					NVARCHAR(100)
,                       created_at							NVARCHAR(100)
,                       engels								NVARCHAR(100)
,                       hoofditem							NVARCHAR(100)
,                       instituut_id						NVARCHAR(100)			'$.instituut.id' 
,                       instituut_vertalingen				NVARCHAR(100)			'$.instituut.vertalingen' 
,                       naam								NVARCHAR(100)

,                       nederlands							NVARCHAR(100)
,                       [status]							NVARCHAR(100)
,                       taal_id								NVARCHAR(100)			'$.taal.id'
,                       taal_name							NVARCHAR(100)			'$.taal.name'
,                       unapproved							NVARCHAR(100)
,                       updated_at							NVARCHAR(100)
,                       vertalingen							NVARCHAR(100)









)


END