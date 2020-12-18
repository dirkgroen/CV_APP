


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE   PROCEDURE [dbo].[usp_offset]
AS
/*
###################################################################################################################################################################################
-- Object				: [dbo].[[usp_offset]]
-- AangemaaktOp			: 20200701
-- Auteur				: Bijvank, Albert

-- Doel
Loopen door de duizendtallen en api get regels wegschrijven die kunnen worden gebruikt om de api offset call te maken.  

-- Voorbeeldaanroep:
EXEC	[dbo].[usp_idcheck]
###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200609	ABij			Initiele versie
###################################################################################################################################################################################
*/

TRUNCATE TABLE [API_CALLS_OFFSET];

IF OBJECT_ID('dbo.[API_CALLS_OFFSETAPI]', 'U') IS NOT NULL 
DROP TABLE dbo.[API_CALLS_OFFSETAPI];

DECLARE @maxaantal INT


SET @maxaantal = (SELECT MAX([Aantal])
FROM [dbo].[API_CALLS_ID_Aantal])


DECLARE @Counter INT 
DECLARE @Offset INT 
DECLARE @Limit INT 

SET @Counter=1
SET @Offset  = 0
SET @Limit  = 1000

WHILE ( @Counter <= @maxaantal)
BEGIN
  INSERT INTO [API_CALLS_OFFSET]
  SELECT @Counter ,  CONVERT(VARCHAR,'?limit=1000&offset='+ CONVERT(VARCHAR,@Offset))
  IF @Counter >=@maxaantal
  BEGIN
  BREAK
  END
    SET @Counter  = @Counter  + 1
	SET @Offset  = @Offset  + 1000
	SET @Limit  = @Limit 
END


SELECT 
  LEFT(A.[TableName],LEN(A.[TableName])-5) + O.TableName AS Tablename,
 'api/models/' + LEFT(A.[TableName], LEN(A.[TableName])-5) + 's/records' + O.API_Key AS APIKEY
  
INTO [API_CALLS_OFFSETAPI]  
FROM [dbo].[API_CALLS_ID_Aantal] A 
  LEFT JOIN [dbo].[API_CALLS_OFFSET] O ON  
  O.[TableName] <= A.[Aantal]