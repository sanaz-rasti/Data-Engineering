
-- --------------- OHDSI (https://www.ohdsi.org/) OMOP Database Schemas ---------------
-- The database (OMOP.db) is created in existing MS Azure SQL Server. 
-- More information can be found in readme file (sql_server.md)


-- --------------- Create OMOP Schemas ---------------
-- Syntax : DROP SCHEMA  [ IF EXISTS ] schema_name; GO;   CREATE SCHEMA [YrSchemaName]; Go; 
CREATE SCHEMA standardized_clinical_data;
GO

CREATE SCHEMA standardized_health_system;
GO

CREATE SCHEMA standardized_vocabularies;
GO

CREATE SCHEMA standardized_health_economies;
GO

CREATE SCHEMA standardized_derived_elements;
GO

CREATE SCHEMA results_schema;
GO 

CREATE SCHEMA standardized_metadata;
GO
