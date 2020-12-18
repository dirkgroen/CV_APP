







CREATE VIEW [dwh].[vw_DIM_Functie] AS

/*
###################################################################################################################################################################################
-- Object				: [dwh].[vw_DIM_Functie]
-- AangemaaktOp			: 20200803
-- Auteur				: Bijvank, Albert

-- Doel
Dimensietabel Functie

-- Notitie: 
N.v.t.


###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200803	ABij			Initiele versie
###################################################################################################################################################################################
*/

--Onbekend regel
SELECT 

		AK_Functie =								CAST('-1' AS INT)	  
,		FunctieOmschrijving =						'[*Onbekend]'	
,		Akkoord =									'[*Onbekend]'
,		MedewerkersAantal =							'-1'	

UNION ALL 

  SELECT 

		AK_Functie =								CAST([id] AS INT)	  
,		FunctieOmschrijving =						ISNULL(nederlands, omschrijving)		
,		Akkoord =									ISNULL([approved], '[*Onbekend]')			
,		MedewerkersAantal =							ISNULL([count_medewerkers], '-1')			

  FROM [stg].[Functie] F
  WHERE functie_id IS NULL