CREATE TABLE [stg].[Branche] (
    [id]                INT            NULL,
    [sbi_code]          NVARCHAR (150) NULL,
    [omschrijving]      NVARCHAR (150) NULL,
    [unapproved]        NVARCHAR (50)  NULL,
    [vertalingen]       NVARCHAR (150) NULL,
    [branche_id]        NVARCHAR (150) NULL,
    [Branche_name]      NVARCHAR (250) NULL,
    [taal_id]           NVARCHAR (50)  NULL,
    [taal_naam]         NVARCHAR (250) NULL,
    [count_medewerkers] NVARCHAR (250) NULL,
    [nederlands]        NVARCHAR (150) NULL,
    [engels]            NVARCHAR (150) NULL,
    [created_at]        DATE           NULL
);

