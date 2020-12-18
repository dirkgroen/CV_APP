




Create PROCEDURE [stg].[usp_Kennis_Controle]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Kennis_Controle]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Kennis_Controle table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Kennis_Controle]
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
IF OBJECT_ID('stg.Kennis_Controle', 'U') IS NOT NULL 
DROP TABLE [stg].[Kennis_Controle];

--Connectie met Kennis_Controlebestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'kennis_controle.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Kennis_Controle]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id											INT
,                       engels										NVARCHAR(100)
,                       medewerker_aantal							NVARCHAR(100)
,                       approved									NVARCHAR(100)
,                       engels_alternatieve_expression				NVARCHAR(100)
,                       updated_at									NVARCHAR(100)
,                       hoofditem									NVARCHAR(100)
,                       nederlands									NVARCHAR(100)
,                       unapproved									NVARCHAR(100)
,                       categorie_id								NVARCHAR(100)			'$.categorie.id'
,                       categorie_name								NVARCHAR(100)			'$.categorie.name'
,                       vertalingen									NVARCHAR(100)			
,                       nederlands_alternatieve_expression			NVARCHAR(100)
,                       [name]										NVARCHAR(100)
,                       created_at									NVARCHAR(100)





)


END