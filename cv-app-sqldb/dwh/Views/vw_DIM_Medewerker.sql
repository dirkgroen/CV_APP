


/*
###################################################################################################################################################################################
-- Object                : [dwh].[vw_DIM_Medewerker]
-- AangemaaktOp          : 20200804
-- Auteur                : Bijvank, Albert

-- Doel
Feitentabel medewerker
-- Notitie: 
N.v.t.

###################################################################################################################################################################################
--    Versie    Datum        Ontwikkelaar    Aanpassing
--    1.0        20200804    ABij            Initiele versie
###################################################################################################################################################################################
*/

CREATE VIEW [dwh].[vw_DIM_Medewerker]
AS


WITH CTE AS (
	SELECT DISTINCT
    AK_Medewerker =									ISNULL(CAST([medewerker_id] AS INT), '-1')
    FROM [stg].[Medewerker])



	SELECT 
		AK_Medewerker =							D_M.AK_Medewerker		
		,Collega =								M.[naam]
		,Titel =								M.[titel]
		,Titel_Na =								M.[titel_achter]
		,Voornaam =								M.[voornaam]
		,Achternaam =							M.[achternaam]
		,Leeftijd =								CAST(DATEDIFF(MONTH,M.[geboortedatum],GETDATE()) /12 AS decimal(18,0)) 
		,Land =									M.land
		,Woonplaats =							M.woonplaats
		,Afdeling =								ISNULL(A.nederlands,'[*Onbekend]')
		,Profielfoto =							ISNULL(M.[profiel_foto_base64],NULL)
		
	FROM CTE AS D_M
	LEFT JOIN [stg].[Medewerker] AS M ON
	D_M.AK_Medewerker = M.ID
	LEFT JOIN STG.Afdeling AS A ON
	A.ID = M.afdeling_id
	WHERE 1=1
	-- Export velden zijn altijd hoofd dimensie regel
	AND ervaring_sinds_export IS NOT NULL