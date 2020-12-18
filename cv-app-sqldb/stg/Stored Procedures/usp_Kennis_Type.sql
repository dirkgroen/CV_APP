



CREATE PROCEDURE [stg].[usp_Kennis_Type]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Kennis_Type]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Kennis_Type table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Kennis_Type]
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
IF OBJECT_ID('stg.Kennis_Type', 'U') IS NOT NULL 
DROP TABLE [stg].[Kennis_Type];

--Connectie met Kennis_Typebestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'kennis_type.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Kennis_Type]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id										INT
,                       translations_all					NVARCHAR(100)
,                       sortindex							NVARCHAR(100)
,                       [name]								NVARCHAR(100)
,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)








)


END