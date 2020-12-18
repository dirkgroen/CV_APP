








CREATE   PROCEDURE [dbo].[usp_idcheck]
AS
/*
###################################################################################################################################################################################
-- Object				: [dbo].[usp_idcheck]
-- AangemaaktOp			: 20200701
-- Auteur				: Bijvank, Albert

-- Doel
Tellen regels, deze splitsen in duizendtallen. En wegschrijven van deze data in ID_Aantal tabel.

-- Voorbeeldaanroep:
EXEC	[dbo].[usp_idcheck]
###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200609	ABij			Initiele versie
###################################################################################################################################################################################
*/



BEGIN

SET NOCOUNT ON 


--Declaratie variabelen
DECLARE @var1				NVARCHAR(MAX)
DECLARE @Var2				NVARCHAR(MAX)
DECLARE @JSON				NVARCHAR(MAX)
DECLARE @SQLSTATEMENT		NVARCHAR(MAX)
DECLARE @File				NVARCHAR(MAX)  SET @File =  (SELECT CONCAT([TableName],'.json') FROM [dbo].[API_CALLS_Huidige])
DECLARE @Apikey				NVARCHAR(MAX)  SET @Apikey =  (SELECT [API_Key] FROM [dbo].[API_CALLS_Huidige])



 SET @SQLSTATEMENT = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
 FROM OPENROWSET(bulk ''' + @File + ''', DATA_SOURCE=''EXTDS_CV_Blob_ID'', SINGLE_NCLOB
 ) AS azureblob'
 EXEC dbo.sp_executesql @SQLSTATEMENT, N'@json NVARCHAR(MAX) OUTPUT', @JSON OUTPUT


-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

----Met OPENJSON het bestand regel voor regel uitlezen



INSERT INTO dbo.API_CALLS_ID_Aantal
SELECT  
@File, @Apikey,(COUNT(*)/1000)+1 AS Aantal
FROM
	OPENJSON (@JSON)
WITH 
	(
	id								INT  
	 )





END