CREATE TABLE [stg].[Taal] (
    [id]                      INT            NULL,
    [label]                   NVARCHAR (100) NULL,
    [acronym]                 NVARCHAR (100) NULL,
    [taal_van_vertaling_id]   NVARCHAR (100) NULL,
    [taal_van_vertaling_name] NVARCHAR (100) NULL,
    [logo_inactive_file]      NVARCHAR (100) NULL,
    [logo_inactive_url]       NVARCHAR (100) NULL,
    [logo_file]               NVARCHAR (100) NULL,
    [logo_url]                NVARCHAR (100) NULL,
    [vertaalde_taal_id]       NVARCHAR (100) NULL,
    [vertaalde_taal_name]     NVARCHAR (100) NULL,
    [updated_at]              NVARCHAR (100) NULL,
    [created_at]              NVARCHAR (100) NULL
);

