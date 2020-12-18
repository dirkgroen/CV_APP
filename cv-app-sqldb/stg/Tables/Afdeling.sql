CREATE TABLE [stg].[Afdeling] (
    [id]                INT            NULL,
    [nederlands]        NVARCHAR (150) NULL,
    [engels]            NVARCHAR (150) NULL,
    [count_medewerkers] INT            NULL,
    [taal_id]           NVARCHAR (50)  NULL,
    [taal_naam]         NVARCHAR (250) NULL,
    [unapproved]        NVARCHAR (50)  NULL,
    [status]            NVARCHAR (50)  NULL,
    [naam]              NVARCHAR (250) NULL,
    [afdeling_id]       NVARCHAR (50)  NULL,
    [afdeling_name]     NVARCHAR (250) NULL,
    [hoofditem]         NVARCHAR (50)  NULL,
    [vertalingen]       NVARCHAR (150) NULL,
    [created_at]        DATE           NULL,
    [updated_at]        DATE           NULL
);

