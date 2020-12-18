






CREATE VIEW [dwh].[vw_DIM_Organisatie] AS

/*
###################################################################################################################################################################################
-- Object				: [dwh].[vw_DIM_Organisatie]
-- AangemaaktOp			: 20200803
-- Auteur				: Bijvank, Albert

-- Doel
Dimensietabel Organisatie

-- Notitie: 
N.v.t.


###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200803	ABij			Initiele versie
###################################################################################################################################################################################
*/

--Onbekend regel
SELECT 

		AK_Organisatie =							CAST('-1' AS INT)	  
,		OrganisatieOmschrijving =					'[*Onbekend]'	
,		Akkoord =									'[*Onbekend]'
,		MedewerkersAantal =							'-1'	

UNION ALL 

  SELECT 

		AK_Organisatie =							CAST([id] AS INT)	  
,		OrganisatieOmschrijving =					ISNULL([nederlands_alternatieve_expression],[engels_alternatieve_expression])		
,		Akkoord =									ISNULL([approved], '[*Onbekend]')			
,		MedewerkersAantal =							ISNULL([count_medewerkers], '-1')			

  FROM [stg].[Organisate]