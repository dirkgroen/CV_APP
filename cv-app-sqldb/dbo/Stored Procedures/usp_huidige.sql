





/*
###################################################################################################################################################################################
-- Object				: [dbo].[usp_Fail]
-- AangemaaktOp			: 20200630
-- Auteur				: Bijvank, Albert

-- Omschrijving:
De huidige looptabel wegschrijven naar een sql tabel, zodat deze kan worden gebruikt in stored procedure.

###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200630	ABij			Initiele versie
###################################################################################################################################################################################
*/

CREATE   PROCEDURE [dbo].[usp_huidige]



@Tablename AS NVARCHAR(100),
@Apikey AS NVARCHAR(150)

AS 

TRUNCATE TABLE dbo.API_CALLS_huidige;

INSERT INTO dbo.API_CALLS_huidige
VALUES (@Tablename , @Apikey )