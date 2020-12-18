



CREATE PROCEDURE [stg].[usp_Opleiding_Soort]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Opleiding_Soort]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Opleiding_Soort table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Opleiding_Soort]
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
IF OBJECT_ID('stg.Opleiding_Soort', 'U') IS NOT NULL 
DROP TABLE [stg].[Opleiding_Soort];

--Connectie met Opleiding_Soortbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'opleiding_soort.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Opleiding_Soort]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id									INT
,                       [label]								NVARCHAR(100)	
,                       engels_alternatieve_expression		NVARCHAR(100)	
,                       engels								NVARCHAR(100)	
,                       nederlands							NVARCHAR(100)	
,                       taal_id								NVARCHAR(100)			'$.taal.id'
,                       taal_name							NVARCHAR(100)			'$.taal.name'
		
,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)




)


END