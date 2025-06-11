CREATE TABLE dbo.Addresses (
    Id INT IDENTITY(1,1) NOT NULL 
        CONSTRAINT PK_Addresses PRIMARY KEY,

    CustomerId INT NOT NULL,

    Street1 NVARCHAR(200) NOT NULL,    

    Street2 NVARCHAR(200) NOT NULL,

    City NVARCHAR(100) NOT NULL,

    StateId INT NOT NULL,

    PostalCode NVARCHAR(20) NULL,

    CreatedAtUTC DATETIME2 NOT NULL 
        CONSTRAINT DF_Addresses_CreatedAtUTC DEFAULT GETUTCDATE(),

    UpdatedAtUTC DATETIME2 NOT NULL 
        CONSTRAINT DF_Addresses_UpdatedAtUTC DEFAULT GETUTCDATE(),

    CONSTRAINT FK_Addresses_CustomerId 
        FOREIGN KEY (CustomerId) 
        REFERENCES dbo.Customers(Id) 
        ON DELETE CASCADE,

    CONSTRAINT FK_Addresses_State 
        FOREIGN KEY (StateId) 
        REFERENCES dbo.States(Id)
);
GO

CREATE INDEX IX_Addresses_CustomerId ON dbo.Addresses (CustomerId);
GO