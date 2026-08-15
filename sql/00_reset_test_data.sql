USE SmartBankDB;
GO

-- Clear transaction test records.
DELETE FROM account_transaction;
GO

-- Reset transaction identity back to 1.
DBCC CHECKIDENT ('account_transaction', RESEED, 0);
GO

-- Reset account balances for clean testing.
UPDATE account
SET balance = 0.00;
GO

-- Confirm reset results.
SELECT *
FROM account_transaction;
GO

SELECT *
FROM account;
GO
