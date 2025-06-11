-- This script is to generate the database for EventBankingCo.CustomerService

-- Create the CustomerService database if it doesn't exist
IF NOT EXISTS (
    SELECT name 
    FROM sys.databases 
    WHERE name = N'CustomerService'
)
BEGIN
    CREATE DATABASE CustomerService;
END
GO

-- Switch to the database
USE CustomerService;
GO

-- Create tables if they do not exist (DDL)
:r Scripts/Post-Deployment/RunAll_CreateTables.sql

-- Post-Deployment (DML)
:r Scripts/Post-Deployment/RunAll_PostDeployment.sql
