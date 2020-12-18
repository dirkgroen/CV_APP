




/*
###################################################################################################################################################################################
-- Object                : [dwh].[vw_DIM_Kennis]
-- AangemaaktOp          : 20200804
-- Auteur                : Bijvank, Albert

-- Doel
Feitentabel Kennis 
-- Notitie: 
N.v.t.

###################################################################################################################################################################################
--    Versie    Datum        Ontwikkelaar    Aanpassing
--    1.0        20200804    ABij            Initiele versie
###################################################################################################################################################################################
*/
 
CREATE VIEW [dwh].[vw_DIM_Kennis]
AS
	
	
	SELECT DISTINCT
	--    KEYS
		AK_KennisControle =							ISNULL(K.[kennis_controle_id],'-1')


,		Akkoord =									ISNULL(KC.[approved],'[*Onbekend]')
,		KennisCategorie =							ISNULL(KC.[categorie_name],'[*Onbekend]')
,		Kennis =									ISNULL(KC.[nederlands_alternatieve_expression],'[*Onbekend]')
,		MedewerkerAantal =							ISNULL(KC.[medewerker_aantal],'-1')


  FROM [stg].[Medewerker_Kennis] AS K
	 LEFT JOIN [stg].[Kennis_Controle] AS KC ON 
		KC.id = K.kennis_controle_id