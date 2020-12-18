






/*
###################################################################################################################################################################################
-- Object				: [dbo].[usp_Fail]
-- AangemaaktOp			: 20200630
-- Auteur				: Bijvank, Albert

--Omschrijving:
Wordt gebruikt in Azure DataFactory om tabellen die niet kunnen laden weg te schrijven. 


###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200630	ABij			Initiele versie
###################################################################################################################################################################################
*/

CREATE   PROCEDURE [dbo].[usp_Fail]

@Tablename AS NVARCHAR(100),
@Apikey AS NVARCHAR(150)

AS 

INSERT INTO dbo.API_CALLS_FAIL
VALUES (@Tablename , @Apikey,GETDATE() )