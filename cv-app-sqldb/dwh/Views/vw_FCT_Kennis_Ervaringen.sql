










/*
###################################################################################################################################################################################
-- Object                : [dwh].[vw_FCT_Kennis_Ervaring]
-- AangemaaktOp          : 20200804
-- Auteur                : Bijvank, Albert

-- Doel
Feitentabel Kennis_Ervaring 
-- Notitie: 
N.v.t.

###################################################################################################################################################################################
--    Versie    Datum        Ontwikkelaar    Aanpassing
--    1.0        20200804    ABij            Initiele versie
###################################################################################################################################################################################
*/
 
CREATE VIEW [dwh].[vw_FCT_Kennis_Ervaringen] 
AS
	
SELECT 

-- KEYS
		AK_Kennis_Ervaring	=						ISNULL(E.[id],-1)
,		AK_Medewerker	=							ISNULL(E.[medewerker_id],-1)
,		AK_Branche	=								ISNULL(E.[branche_id],-1)
,		AK_Functie	=								ISNULL([functie_id],-1)
,		AK_Organisatie	=							ISNULL([organisatie_id],-1)
,		AK_Kennis_medewerker =						ISNULL(KE.medewerker_kennis_id,-1)
,		AK_Kennis =									ISNULL(MKE.kennis_controle_id,-1)


-- 
,	 Huidig =										CASE WHEN [date_tot] IS NULL THEN 'Ja' ELSE 'Nee' END


--Meetwaarden
 ,		Kennis_ErvaringAantal	=						1
 ,		Begindatum	=							CAST(ISNULL([date_van],'99991231') AS DATE)
 ,		Einddatum =								CAST(ISNULL([date_tot],'99991231') AS DATE)

     

  
  FROM [stg].Medewerker_Kennis_Ervaring KE

  -- JOIN Ervaring_INFO
		LEFT JOIN [stg].Ervaring_Info EI ON
		EI.id = KE.ervaring_info_id 

		-- JOIN Medewerker_Ervaring
		LEFT JOIN [stg].Medewerker_Ervaring E ON
		EI.ervaring = e.id

 -- JOIN Kennis
		LEFT JOIN [stg].Medewerker_Kennis MKE ON
		KE.medewerker_kennis_id = MKE.id 


		WHERE  
		KE.ervaring_info_id IS NOT NULL 
		AND KE.medewerker_kennis_id IS NOT NULL
		AND E.id IS NOT NULL
		AND E.[medewerker_id] IS NOT NULL	
		AND MKE.[medewerker_id] IS NOT NULL 
		AND MKE.[kennis_controle_id] IS NOT NULL