﻿CREATE TABLE dbo.States (
    Id INT NOT NULL CONSTRAINT PK_States PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL CONSTRAINT UQ_States_Name UNIQUE,
    Abbreviation CHAR(2) NOT NULL CONSTRAINT UQ_States_Abbreviation UNIQUE
)
GO