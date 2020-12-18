




/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Run_Stage]
-- AangemaaktOp			: 20200506
-- Auteur				: Groen, Dirk

-- Doel
Procedure die alle procedures in opgegeven database en schema stuk voor stuk aftrapt
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC usp_Run_Stage 'univehack', 'stg'

###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200506	DJG				Initiele versie
###################################################################################################################################################################################
*/

CREATE   PROCEDURE [dbo].[usp_Run_Stage]
AS

IF OBJECT_ID('dbo.ListOfProcedures', 'U') IS NOT NULL 
DROP TABLE dbo.ListOfProcedures

DECLARE @sql_select NVARCHAR(MAX);

SET @sql_select =

N'SELECT ROUTINE_SCHEMA+''.''+SPECIFIC_NAME AS sproc
INTO dbo.ListOfProcedures
  FROM INFORMATION_SCHEMA.ROUTINES
 WHERE ROUTINE_TYPE = ''PROCEDURE'' AND ROUTINE_SCHEMA=''stg'';'


EXEC sp_executesql @sql_select;


DECLARE @sql NVARCHAR(MAX);
SET @sql = (SELECT N'exec ' + sproc +N';
' FROM [dbo].[ListOfProcedures]
FOR XML PATH(''), TYPE).value(N'.', 'NVARCHAR(MAX)');

EXEC sp_executesql @sql;


--IF OBJECT_ID('dbo.ListOfProcedures', 'U') IS NOT NULL 
--DROP TABLE dbo.ListOfProcedures