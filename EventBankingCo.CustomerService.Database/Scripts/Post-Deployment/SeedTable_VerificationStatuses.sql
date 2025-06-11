MERGE dbo.VerificationStatuses AS target
USING (
    VALUES 
        (1, 'PendingVerification', 'Customer is awaiting identity or email verification'),
        (2, 'Verified', 'Customer identity has been successfully verified'),
        (3, 'Rejected', 'Customer verification failed or was denied'),
        (4, 'Suspended', 'Customer is temporarily suspended due to review or issues')
) AS source (Id, Name, Description)
ON target.Id = source.Id
WHEN MATCHED AND (target.Name <> source.Name OR target.Description <> source.Description) THEN
    UPDATE SET Name = source.Name, Description = source.Description
WHEN NOT MATCHED THEN
    INSERT (Id, Name, Description) VALUES (source.Id, source.Name, source.Description)
;