------------------------------------------------------------------------
-- Schema - Lookup Tables
------------------------------------------------------------------------
--
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'States')
BEGIN
	:r dbo/Tables/States.sql

	PRINT('States table created.');
END
--
------------------------------------------------------------------------
--
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'VerificationStatuses')
BEGIN
	:r dbo/Tables/VerificationStatuses.sql

	PRINT('VerificationStatuses table created.');
END
--
------------------------------------------------------------------------
-- End of Schema - Lookup Tables
------------------------------------------------------------------------

PRINT('Lookup tables created or already exist. Proceeding to transactional data tables...');

------------------------------------------------------------------------
-- Schema - Transactional Data
------------------------------------------------------------------------
--
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Customers')
BEGIN
	:r dbo/Tables/Customers.sql
	-- Depends On:
		-- :r dbo/Tables/VerificationStatuses.sql

	PRINT('Customers table created.');
END
--
------------------------------------------------------------------------
--
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Addresses')
BEGIN
	:r dbo/Tables/Addresses.sql
	-- Depends On:
		-- dbo/Tables/States.sql
		-- dbo/Tables/Customers.sql

	PRINT('Addresses table created.');
END
------------------------------------------------------------------------
-- End of Schema - Transactional Data
------------------------------------------------------------------------

Print('Transactional data tables created or already exist. Table Creation Completed.');