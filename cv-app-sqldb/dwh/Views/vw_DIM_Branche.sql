






CREATE VIEW [dwh].[vw_DIM_Branche] AS

/*
###################################################################################################################################################################################
-- Object				: [dwh].[vw_DIM_Branche]
-- AangemaaktOp			: 20200803
-- Auteur				: Bijvank, Albert

-- Doel
Dimensietabel Branche

-- Notitie: 
N.v.t.


###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200803	ABij			Initiele versie
###################################################################################################################################################################################
*/

--Onbekend regel
SELECT 

		AK_Branche =								CAST('-1' AS INT)	  
,		BrancheOmschrijving =						'[*Onbekend]'	



UNION ALL 

  SELECT DISTINCT

		AK_Branche =								CAST([id] AS INT)	  
,		BrancheOmschrijving =						ISNULL(nederlands, omschrijving)						

  FROM [stg].[Branche] B
  WHERE branche_id IS NULL