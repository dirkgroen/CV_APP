CREATE EXTERNAL DATA SOURCE [EXTDS_CV_Blob_ID]
    WITH (
    TYPE = 'BLOB_STORAGE',
    LOCATION = N'https://cvappstorage.blob.core.windows.net/api-json-id',
    CREDENTIAL = [SC_SAS_CV_APP]
    );

