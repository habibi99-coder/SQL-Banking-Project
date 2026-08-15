USE SmartBankDB;
GO

-- Disable validation trigger so test data can be reset.
DISABLE TRIGGER trg_PreventTransactionChanges ON account_transaction;
GO

-- Clear transaction records.
DELETE FROM account_transaction;
GO

-- Reset transaction identity.
DBCC CHECKIDENT ('account_transaction', RESEED, 0);
GO

-- Reset account balances.
UPDATE account
SET balance = 0.00;
GO

-- Re-enable validation trigger.
ENABLE TRIGGER trg_PreventTransactionChanges ON account_transaction;
GO

-- Confirm reset.
SELECT *
FROM account_transaction;
GO

SELECT *
FROM account;
GO
