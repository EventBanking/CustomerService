MERGE dbo.VerificationStatuses AS target
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
        Description = source.Description,
        ModifiedDate = GETUTCDATE()  -- Add if you have audit columns
WHEN NOT MATCHED BY TARGET THEN
    INSERT (Id, Name, Description)
    VALUES (source.Id, source.Name, source.Description)
WHEN NOT MATCHED BY SOURCE THEN
    -- Optional: Handle records that exist in target but not in source
    -- DELETE  -- Uncomment if you want to remove obsolete statuses
    UPDATE SET IsActive = 0;  -- Or mark as inactive if you have this column

-- Disable IDENTITY_INSERT if it was enabled
-- SET IDENTITY_INSERT dbo.VerificationStatuses OFF;

-- Print summary
DECLARE @RowCount INT = @@ROWCOUNT;
PRINT 'VerificationStatuses seeding completed. Rows affected: ' + CAST(@RowCount AS VARCHAR(10));

-- Optional: Verify the data
IF EXISTS (SELECT 1 FROM dbo.VerificationStatuses WHERE Id IN (1,2,3,4))
BEGIN
    PRINT 'Verification: All required VerificationStatuses records are present.';
END
ELSE
BEGIN
    PRINT 'WARNING: Some VerificationStatuses records may be missing!';
END
