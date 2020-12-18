





/*
###################################################################################################################################################################################
-- Object                : [dwh].[vw_FCT_Kennis]
-- AangemaaktOp          : 20200804
-- Auteur                : Bijvank, Albert

-- Doel
Feitentabel abonnementen 
-- Notitie: 
N.v.t.

###################################################################################################################################################################################
--    Versie    Datum        Ontwikkelaar    Aanpassing
--    1.0        20200804    ABij            Initiele versie
###################################################################################################################################################################################
*/
 
CREATE VIEW [dwh].[vw_FCT_Kennis] 
AS
	
	
	SELECT 
	--    KEYS
		AK_Kennis	=								K.[id]
,		AK_KennisControle =							ISNULL(K.[kennis_controle_id],-1)
,		AK_Medewerker =								ISNULL(K.[medewerker_id],-1)




   -- Meetwaarden
,		Kennis_Score =								K.[score_kennis]							
,		Kennis_Omschrijving =						CASE 
													WHEN 		K.[score_kennis]	= 5 THEN 'Expert'
													WHEN 		K.[score_kennis]	= 4 THEN 'Senior'
													WHEN 		K.[score_kennis]	= 3 THEN 'Medior'
													WHEN 		K.[score_kennis]	= 2 THEN 'Junior'
													WHEN 		K.[score_kennis]	= 1 THEN 'Basis' ELSE 'Onbekend' END
	FROM [stg].[Medewerker_Kennis] AS K
			LEFT JOIN [stg].[Kennis_Controle] AS KC ON 
					KC.id = K.kennis_controle_id



	WHERE	K.[medewerker_id] IS NOT NULL AND 
			K.[kennis_controle_id] IS NOT NULL