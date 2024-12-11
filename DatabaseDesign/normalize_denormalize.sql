-----------------------------------------------------------------------------------
-- Normalization: Defining tables and organizing data flow to minimize redundancy. 
-- Example: 
USE master;
GO

IF NOT EXISTS (
        SELECT name
        FROM sys.databases
        WHERE name = N'patient_data'
    )
    CREATE DATABASE [patient_data];
GO

-- Patient
IF OBJECT_ID('[PATIENT]','U') IS NOT NULL
DROP TABLE [PATIENT];
GO 

CREATE TABLE [PATIENT](
    patient_id    int PRIMARY KEY NOT NULL, 
    first_name    varchar(50) UNIQUE,
    surname       varchar(50) UNIQUE,
    date_of_birth DATE NOT NULL UNIQUE,
    address_1     varchar(50) UNIQUE,
    address_2     varchar(50) UNIQUE,
    city          varchar(50) UNIQUE,
    county        varchar(20) UNIQUE,
    clinic_name   varchar(50) UNIQUE);
GO


-- Drugs 
IF OBJECT_ID('[DRUG]','U') IS NOT NULL
DROP TABLE [DRUG];
GO 

CREATE TABLE [DRUG](
    drug_id         int PRIMARY KEY NOT NULL, 
    drug_name       varchar(50) UNIQUE,
    generic_name    varchar(50) UNIQUE,
    ingredient_1    varchar(50) UNIQUE,
    ingredient_2    varchar(50) UNIQUE,
    NDC_code        varchar(50) UNIQUE);
GO


-- Consultation
IF OBJECT_ID('[CONSULTATION]','U') IS NOT NULL
DROP TABLE [CONSULTATION];
GO 

CREATE TABLE [CONSULTATION](
    consultation_id     int PRIMARY KEY NOT NULL,
    consultation_date   DATE NOT NULL UNIQUE,
    patient_id          int, 
    consultation_note   varchar(150) UNIQUE,
    drug_id             int,
    FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
    FOREIGN KEY (drug_id) REFERENCES DRUG(drug_id)
    );
GO


-----------------------------------------------------------------------------------
-- Denormalization: Combining tables to improve read performance 
-- Example: using CTE to create a view denormalization

USE patient_data;
GO

WITH joined_tables AS (
	
    SELECT *
	
    FROM [CONSULTATION]
	
    JOIN [PATIENT]
	ON [CONSULTATION].[patient_id] = [PATIENT].[patient_id] 
	
    JOIN [DRUG]
	ON [CONSULTATION].[drug_id] = [DRUG].[drug_id] 

), first_criteria AS (
	SELECT *
	FROM joined_tables
	WHERE COUNT([consultation_date]) > 1
), second_criteria AS (
	SELECT *
	FROM joined_tables
	WHERE drug_id IS NOT NULL
)
SELECT *
FROM first_criteria
UNION ALL 
SELECT *
FROM second_criteria;
