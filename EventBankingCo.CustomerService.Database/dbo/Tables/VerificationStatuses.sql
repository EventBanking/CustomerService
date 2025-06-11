CREATE TABLE dbo.VerificationStatuses (
    Id INT NOT NULL CONSTRAINT PK_VerificationStatuses PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL CONSTRAINT UQ_VerificationStatuses_Name UNIQUE,
    Description NVARCHAR(255) NULL
);
GO