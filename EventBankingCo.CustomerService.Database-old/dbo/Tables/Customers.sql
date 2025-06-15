CREATE TABLE dbo.Customers (
    Id INT IDENTITY(1,1) NOT NULL 
        CONSTRAINT PK_Customers PRIMARY KEY,
        
    MemberId NVARCHAR(10) NOT NULL 
        CONSTRAINT UQ_Customers_MemberId UNIQUE,
        
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,

    Email NVARCHAR(255) NOT NULL 
        CONSTRAINT UQ_Customers_Email UNIQUE,
        
    PhoneNumber NVARCHAR(20) NULL 
        CONSTRAINT UQ_Customers_PhoneNumber UNIQUE,
        
    VerificationStatusId INT NOT NULL 
        CONSTRAINT DF_Customers_VerificationStatusId DEFAULT 1,
        
    CreatedAtUTC DATETIME2 NOT NULL 
        CONSTRAINT DF_Customers_CreatedAtUTC DEFAULT GETUTCDATE(),

    UpdatedAtUTC DATETIME2 NOT NULL 
        CONSTRAINT DF_Customers_UpdatedAtUTC DEFAULT GETUTCDATE(),

    CONSTRAINT FK_Customers_VerificationStatusId 
        FOREIGN KEY (VerificationStatusId) 
        REFERENCES dbo.VerificationStatuses(Id)
)
GO

CREATE INDEX IX_Customers_Email ON dbo.Customers (Email);
GO

CREATE INDEX IX_Customers_PhoneNumber ON dbo.Customers (PhoneNumber);
GO