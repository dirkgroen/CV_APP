







CREATE VIEW [dwh].[vw_DIM_Opleiding] AS

/*
###################################################################################################################################################################################
-- Object				: [dwh].[vw_DIM_Opleiding]
-- AangemaaktOp			: 20200807
-- Auteur				: Bijvank, Albert

-- Doel
Dimensietabel Opleiding

-- Notitie: 
N.v.t.


###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200807	ABij			Initiele versie
###################################################################################################################################################################################
*/

--Onbekend regel
SELECT 

		AK_Opleiding =								CAST('-1' AS INT)	  
,		OpleidingOmschrijving =						'[*Onbekend]'	
,		Akkoord =									'[*Onbekend]'	


UNION ALL 

  SELECT DISTINCT

		AK_Opleiding =								CAST([id] AS INT)	  
,		OpleidingOmschrijving =						ISNULL(nederlands, omschrijving)						
,		Akkoord =									[approved]
  FROM [stg].[Opleiding] B
  WHERE Opleiding_id IS NULL