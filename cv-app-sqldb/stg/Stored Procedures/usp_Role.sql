



CREATE PROCEDURE [stg].[usp_Role]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Role]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Role table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Role]
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
IF OBJECT_ID('stg.Role', 'U') IS NOT NULL 
DROP TABLE [stg].[Role];

--Connectie met Rolebestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'role.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Role]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id									INT
,                       [name]								NVARCHAR(100)	
,                       impersonate							NVARCHAR(100)	
,                       create_filters_for_others			NVARCHAR(100)
,                       create_filters						NVARCHAR(100)	

,                       updated_at							NVARCHAR(100)
,                       created_at							NVARCHAR(100)




)


END