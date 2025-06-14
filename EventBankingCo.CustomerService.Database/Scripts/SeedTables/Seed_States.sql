﻿-- Drop the procedure if it already exists
IF OBJECT_ID(N'dbo.Seed_States', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Seed_States;
END
GO

-- Create the stored procedure
CREATE PROCEDURE dbo.Seed_States
AS
BEGIN
    SET NOCOUNT ON;

    PRINT 'Seeding [dbo].[States] table.';

    MERGE [dbo].[States] AS target
        USING (
            VALUES
                (1, 'Alabama', 'AL'), 
                (2, 'Alaska', 'AK'), 
                (3, 'Arizona', 'AZ'), 
                (4, 'Arkansas', 'AR'),
                (5, 'California', 'CA'),
                (6, 'Colorado', 'CO'), 
                (7, 'Connecticut', 'CT'), 
                (8, 'Delaware', 'DE'),
                (9, 'Florida', 'FL'), 
                (10, 'Georgia', 'GA'), 
                (11, 'Hawaii', 'HI'), 
                (12, 'Idaho', 'ID'),
                (13, 'Illinois', 'IL'), 
                (14, 'Indiana', 'IN'), 
                (15, 'Iowa', 'IA'), 
                (16, 'Kansas', 'KS'),
                (17, 'Kentucky', 'KY'), 
                (18, 'Louisiana', 'LA'), 
                (19, 'Maine', 'ME'), 
                (20, 'Maryland', 'MD'),
                (21, 'Massachusetts', 'MA'), 
                (22, 'Michigan', 'MI'), 
                (23, 'Minnesota', 'MN'), 
                (24, 'Mississippi', 'MS'),
                (25, 'Missouri', 'MO'), 
                (26, 'Montana', 'MT'), 
                (27, 'Nebraska', 'NE'), 
                (28, 'Nevada', 'NV'),
                (29, 'New Hampshire', 'NH'), 
                (30, 'New Jersey', 'NJ'), 
                (31, 'New Mexico', 'NM'), 
                (32, 'New York', 'NY'),
                (33, 'North Carolina', 'NC'), 
                (34, 'North Dakota', 'ND'), 
                (35, 'Ohio', 'OH'), 
                (36, 'Oklahoma', 'OK'),
                (37, 'Oregon', 'OR'), 
                (38, 'Pennsylvania', 'PA'), 
                (39, 'Rhode Island', 'RI'), 
                (40, 'South Carolina', 'SC'),
                (41, 'South Dakota', 'SD'), 
                (42, 'Tennessee', 'TN'), 
                (43, 'Texas', 'TX'), 
                (44, 'Utah', 'UT'),
                (45, 'Vermont', 'VT'), 
                (46, 'Virginia', 'VA'), 
                (47, 'Washington', 'WA'), 
                (48, 'West Virginia', 'WV'),
                (49, 'Wisconsin', 'WI'), 
                (50, 'Wyoming', 'WY')
        ) AS source (Id, Name, Abbreviation)
        ON target.Id = source.Id
        WHEN MATCHED AND (
            target.Name <> source.Name OR 
            target.Abbreviation <> source.Abbreviation
        ) THEN
            UPDATE SET 
                Name = source.Name, 
                Abbreviation = source.Abbreviation
        WHEN NOT MATCHED THEN
            INSERT (Id, Name, Abbreviation) 
            VALUES (source.Id, source.Name, source.Abbreviation)
        WHEN NOT MATCHED BY SOURCE THEN
            DELETE;

    DECLARE @RowCount INT = @@ROWCOUNT;
    PRINT 'Completed seeding [dbo].[States] table. Rows affected: ' + CAST(@RowCount AS VARCHAR(10));
END
GO

-- Execute the procedure
EXEC dbo.Seed_States;
GO

-- Drop the procedure after execution
DROP PROCEDURE dbo.Seed_States;
GO
