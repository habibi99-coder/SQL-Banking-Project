USE SmartBankDB;
GO

DISABLE TRIGGER trg_PreventTransactionChanges ON account_transaction;
GO

DELETE FROM account_transaction;
GO

DBCC CHECKIDENT ('account_transaction', RESEED, 0);
GO

UPDATE account
SET balance = 0.00;
GO

ENABLE TRIGGER trg_PreventTransactionChanges ON account_transaction;
GO

SELECT *
FROM account_transaction;
GO

SELECT *
FROM account;
GO
