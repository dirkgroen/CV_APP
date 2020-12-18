








/*
###################################################################################################################################################################################
-- Object                : [dwh].[vw_FCT_Ervaring]
-- AangemaaktOp          : 20200804
-- Auteur                : Bijvank, Albert

-- Doel
Feitentabel Ervaring 
-- Notitie: 
N.v.t.

###################################################################################################################################################################################
--    Versie    Datum        Ontwikkelaar    Aanpassing
--    1.0        20200804    ABij            Initiele versie
###################################################################################################################################################################################
*/
 
CREATE VIEW [dwh].[vw_FCT_Ervaringen] 
AS
	
SELECT 

-- KEYS
		AK_Ervaring	=								ISNULL([id],-1)
,		AK_Medewerker	=							ISNULL([medewerker_id],-1)
,		AK_Branche	=								ISNULL([branche_id],-1)
,		AK_Functie	=								ISNULL([functie_id],-1)
,		AK_Organisatie	=							ISNULL([organisatie_id],-1)


-- 
,	 Huidig =										CASE WHEN [date_tot] IS NULL THEN 'Ja' ELSE 'Nee' END


--Meetwaarden
 ,		ErvaringAantal	=						1
 ,		Begindatum	=							CAST(ISNULL([date_van],'99991231') AS DATE)
 ,		Einddatum =								CAST(ISNULL([date_tot],'99991231') AS DATE)

     

  FROM [stg].[Medewerker_Ervaring]

  WHERE [medewerker_id] IS NOT NULL