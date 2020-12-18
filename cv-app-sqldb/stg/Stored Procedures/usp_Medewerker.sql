



CREATE PROCEDURE [stg].[usp_Medewerker]

AS

/*
###################################################################################################################################################################################
-- Object				: [stg].[usp_Medewerker]
-- AangemaaktOp			: 20200728
-- Auteur				: Bijvank, Albert

-- Doel
Met OPENROWSET en OPENJSON Medewerker table beschikbaar stellen vanuit blob in SQL server. 
Deze storedprocedure is onderdeel van de staging laag in dit platform
-- Notitie: 
N.v.t.

-- Voorbeeldaanroep:
EXEC	[stg].[usp_Medewerker]
###################################################################################################################################################################################
--	Versie	Datum		Ontwikkelaar	Aanpassing
--	1.0		20200529	ADB				Initiele versie
###################################################################################################################################################################################
*/


BEGIN

SET NOCOUNT ON 

--Declaratie variabelen
	  DECLARE @json				NVARCHAR(MAX)
      DECLARE @sqlStatement		NVARCHAR(MAX)


--drop table if exists
IF OBJECT_ID('stg.Medewerker', 'U') IS NOT NULL 
DROP TABLE [stg].[Medewerker];

--Connectie met Medewerkerbestand 
SET @SQLStatement = N'SELECT @json = CAST(bulkcolumn AS NVARCHAR(MAX))
FROM OPENROWSET(bulk ''' + 'medewerker.json' + ''', DATA_SOURCE=''EXTDS_CV_Blob'', SINGLE_NCLOB) AS azureblob'
EXEC dbo.sp_executesql @SQLStatement, N'@json NVARCHAR(MAX) OUTPUT', @json OUTPUT

-- Testregel openjson
--SELECT value FROM OPENJSON(@json)

--Met OPENJSON het bestand regel voor regel uitlezen
SELECT 
* 
INTO [stg].[Medewerker]
FROM
 OPENJSON ( @json )
WITH 
	(
	


                        id										INT
,						medewerker_id							NVARCHAR(100)			'$.medewerker.id' 
,						medewerker_naam							NVARCHAR(100)			'$.medewerker.naam' 
,                       achternaam								NVARCHAR(100)
,                       actief									NVARCHAR(100)
,                       [action]								NVARCHAR(100)
,                       active_language_id						NVARCHAR(100)			'$.active_language.id' 
,                       active_language_name					NVARCHAR(100)			'$.active_language.name' 
,                       adres									NVARCHAR(100)
,                       afdeling_id								NVARCHAR(100)			'$.afdeling.id' 
,                       afdeling_vertalingen					NVARCHAR(100)			'$.afdeling.vertalingen' 
,                       branche_id								NVARCHAR(100)			'$.branche.id' 
,                       branche_vertalingen						NVARCHAR(100)			'$.branche.vertalingen' 
,                       bron									NVARCHAR(100)
,                       bsn_nummer								NVARCHAR(100)
,                       creator_id								NVARCHAR(100)			'$.creator.id' 
,                       creator_name							NVARCHAR(100)			'$.creator.name' 
,                       date_tot								NVARCHAR(100)
,                       date_van								NVARCHAR(100)
,                       diploma_certificaat						NVARCHAR(100)
,                       email_adres								NVARCHAR(100)
,                       email_bijbehorende_user					NVARCHAR(100)
,                       employed_since							NVARCHAR(100)
,                       ervaring_info							NVARCHAR(100)			'$.ervaring_info.id' 
,                       ervaring_sinds							NVARCHAR(100)
,                       ervaring_sinds_export					NVARCHAR(100)
,                       export									NVARCHAR(100)
,                       frontpage								NVARCHAR(100)
,                       functie_id								NVARCHAR(100)			'$.functie.id' 
,                       functie_vertalingen						NVARCHAR(100)			'$.functie.vertalingen' 
,                       geboortedatum							NVARCHAR(100)
,                       geboortedatum_export					NVARCHAR(100)
,                       geslacht								NVARCHAR(100)
,                       initialen_id							NVARCHAR(100)			'$.initialen.id' 
,                       initialen_vertalingen					NVARCHAR(100)			'$.initialen.vertalingen' 
,                       instituut								NVARCHAR(100)
,                       jaar_tot								NVARCHAR(100)
,                       jaar_van								NVARCHAR(100)
,                       kennis_controle_id						NVARCHAR(100)			'$.kennis_controle.id' 
,                       kennis_controle_vertalingen				NVARCHAR(100)			'$.kennis_controle.vertalingen' 
,                       land									NVARCHAR(100)
,                       land_export								NVARCHAR(100)
,                       linkedin								NVARCHAR(100)
,                       linkedin_export							NVARCHAR(100)
,                       [location]								NVARCHAR(100)
,                       manager_user_id							NVARCHAR(100)			'$.manager_user.id' 
,                       manager_user_name						NVARCHAR(100)			'$.manager_user.name' 
,                       medewerker								NVARCHAR(100)
,                       medewerker_kennis_id					NVARCHAR(100)			'$.medewerker_kennis.id' 
,                       mutations								NVARCHAR(100)
,                       naam									NVARCHAR(100)
,                       [name]									NVARCHAR(100)
,                       opleiding_id							NVARCHAR(100)			'$.opleiding.id'
,                       opleiding_vertalingen					NVARCHAR(100)			'$.opleiding.vertalingen'
,                       opleiding_soort_id						NVARCHAR(100)			'$.opleiding_soort.id'
,                       organisatie_id							NVARCHAR(100)			'$.organisatie.id' 
,                       organisatie_vertalingen					NVARCHAR(100)			'$.organisatie.vertalingen' 
,                       parent_version_id						NVARCHAR(100)			'$.parent_version.id' 
,                       postcode								NVARCHAR(100)
,                       profiel_foto_file						NVARCHAR(100)			'$.profiel_foto.filename' 
,                       profiel_foto_url						NVARCHAR(100)			'$.profiel_foto.url' 
,                       profiel_foto_versions					NVARCHAR(100)			'$.profiel_foto.versions' 
,                       profiel_foto_base64						BINARY	
,                       record									NVARCHAR(100)			'$.record.id' 
,                       schrijfvaardigheid						NVARCHAR(100)
,                       score_kennis							NVARCHAR(100)
,                       spreekvaardigheid						NVARCHAR(100)
,                       taal_id									NVARCHAR(100)			'$.taal.id'
,                       taal_name								NVARCHAR(100)			'$.taal.name'
,                       telefoon								NVARCHAR(100)
,                       titel									NVARCHAR(100)
,                       titel_achter							NVARCHAR(100)
,                       titel_achter_export						NVARCHAR(100)
,                       titel_export							NVARCHAR(100)
,                       token									NVARCHAR(100)
,                       updated_at								NVARCHAR(100)
,                       [url]									NVARCHAR(100)
,                       users_id								NVARCHAR(100)			'$.user.id' 
,                       users_name								NVARCHAR(100)			'$.user.name' 
,                       versions								NVARCHAR(100)
,                       vertalingen								NVARCHAR(100)
,                       voornaam								NVARCHAR(100)
,                       woonplaats								NVARCHAR(100)
,                       woonplaats_export						NVARCHAR(100)
,                       created_at								NVARCHAR(100)







)


END