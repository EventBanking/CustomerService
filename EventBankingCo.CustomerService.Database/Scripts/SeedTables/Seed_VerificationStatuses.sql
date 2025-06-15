-- Drop the procedure if it already exists
IF OBJECT_ID(N'dbo.Seed_VerificationStatuses', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Seed_VerificationStatuses;
END
GO

-- Create the stored procedure
CREATE PROCEDURE dbo.Seed_VerificationStatuses
AS
BEGIN
    SET NOCOUNT ON;

    PRINT 'Seeding [dbo].[VerificationStatuses] table.';

    MERGE [dbo].[VerificationStatuses] AS target
        USING (
            VALUES 
                (1, 'PendingVerification', 'Customer is awaiting identity or email verification'),
                (2, 'Verified', 'Customer identity has been successfully verified'),
                (3, 'Rejected', 'Customer verification failed or was denied'),
                (4, 'Suspended', 'Customer is temporarily suspended due to review or issues')
        ) AS source (Id, Name, Description)
        ON target.Id = source.Id
        WHEN MATCHED AND (
            target.Name <> source.Name OR 
            target.Description <> source.Description
        ) THEN
            UPDATE SET 
                Name = source.Name, 
                Description = source.Description
        WHEN NOT MATCHED BY TARGET THEN
            INSERT (Id, Name, Description)
            VALUES (source.Id, source.Name, source.Description)
        WHEN NOT MATCHED BY SOURCE THEN
            DELETE;

    DECLARE @RowCount INT = @@ROWCOUNT;
    PRINT  'Completed seeding [dbo].[VerificationStatuses] table. Rows affected: ' + CAST(@RowCount AS VARCHAR(10));
END
GO

-- Execute the procedure
EXEC dbo.Seed_VerificationStatuses;
GO

-- Drop the procedure after execution
DROP PROCEDURE dbo.Seed_VerificationStatuses;
GO
