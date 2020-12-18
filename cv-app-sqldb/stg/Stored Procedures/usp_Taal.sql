



CREATE PROCEDURE [stg].[usp_Taal]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Taal]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Taal table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Taal]
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
IF OBJECT_ID('stg.Taal', 'U') IS NOT NULL 
DROP TABLE [stg].[Taal];

--Connectie met Taalbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'taal.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Taal]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id									INT
,                       [label]								NVARCHAR(100)	
,                       acronym								NVARCHAR(100)	
,                       taal_van_vertaling_id				NVARCHAR(100)			'$.taal_van_vertaling.id' 
,                       taal_van_vertaling_name				NVARCHAR(100)			'$.taal_van_vertaling.name' 
,                       logo_inactive_file					NVARCHAR(100)			'$.logo_inactive.filename' 
,                       logo_inactive_url					NVARCHAR(100)			'$.logo_inactive.url' 
,                       logo_file							NVARCHAR(100)			'$.logo.filename' 
,                       logo_url							NVARCHAR(100)			'$.logo.url' 


,                       vertaalde_taal_id					NVARCHAR(100)			'$.vertaalde_taal.id' 
,                       vertaalde_taal_name					NVARCHAR(100)			'$.vertaalde_taal.name' 


,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)




)


END