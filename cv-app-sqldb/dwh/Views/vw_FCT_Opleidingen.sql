






/*
###################################################################################################################################################################################
-- Object                : [dwh].[vw_FCT_Opleiding]
-- AangemaaktOp          : 20200807
-- Auteur                : Bijvank, Albert

-- Doel
Feitentabel abonnementen 
-- Notitie: 
N.v.t.

###################################################################################################################################################################################
--    Versie    Datum        Ontwikkelaar    Aanpassing
--    1.0        20200807    ABij            Initiele versie
###################################################################################################################################################################################
*/
 
CREATE VIEW [dwh].[vw_FCT_Opleidingen] 
AS
	
	
	SELECT 
	--    KEYS
		AK_Opleiding	=								O.[opleiding_id]
,		AK_OpleidingTID =								O.[id]
,		AK_Medewerker =									ISNULL(O.[medewerker_id],-1)


,Beginjaar =											[jaar_van]
,Eindjaar =												[jaar_tot]
,Diploma_Certificaat =									CASE WHEN	[diploma_certificaat] = 'true' THEN 'Ja'
														WHEN	[diploma_certificaat] = 'false' THEN 'Nee' ELSE '[*Onbekend]' END 

,Opleidings_soort =										ISNULL(OP.engels_alternatieve_expression,'[*Onbekend]')
,Instituut =											ISNULL(ISNULL(INS.Nederlands,INS.Engels),'[*Onbekend]')
   -- Meetwaarden
,		Opleiding_Aantal =								1						


	FROM [stg].[Medewerker_Opleiding] AS O
			LEFT JOIN [stg].Opleiding_Soort AS OP ON 
					O.[opleiding_soort_id] = OP.id
			LEFT JOIN [stg].Instituut AS INS ON 
					O.instituut_id = INS.id


	WHERE	O.[medewerker_id] IS NOT NULL