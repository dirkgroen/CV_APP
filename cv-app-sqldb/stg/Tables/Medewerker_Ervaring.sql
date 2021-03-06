﻿CREATE TABLE [stg].[Medewerker_Ervaring] (
    [id]                      INT            NULL,
    [medewerker_id]           NVARCHAR (100) NULL,
    [medewerker_naam]         NVARCHAR (100) NULL,
    [functie_id]              NVARCHAR (100) NULL,
    [functie_vertalingen]     NVARCHAR (100) NULL,
    [branche_id]              NVARCHAR (100) NULL,
    [branche_vertalingen]     NVARCHAR (100) NULL,
    [organisatie_id]          NVARCHAR (100) NULL,
    [organisatie_vertalingen] NVARCHAR (100) NULL,
    [creator_id]              NVARCHAR (100) NULL,
    [creator_name]            NVARCHAR (100) NULL,
    [record]                  NVARCHAR (100) NULL,
    [users_id]                NVARCHAR (100) NULL,
    [users_name]              NVARCHAR (100) NULL,
    [action]                  NVARCHAR (100) NULL,
    [created_at]              NVARCHAR (100) NULL,
    [date_tot]                NVARCHAR (100) NULL,
    [date_van]                NVARCHAR (100) NULL,
    [export]                  NVARCHAR (100) NULL,
    [frontpage]               NVARCHAR (100) NULL,
    [location]                NVARCHAR (100) NULL,
    [mutations]               NVARCHAR (100) NULL,
    [updated_at]              NVARCHAR (100) NULL
);

