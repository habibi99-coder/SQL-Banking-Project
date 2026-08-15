## Testing Note

--The `00_reset_test_data.sql` script is intended for development and testing only. In a real banking system, transaction records should not be deleted casually. Corrections should normally be handled through reversal transactions or controlled audit processes.

USE SmartBankDB;
GO
-- If trg_PreventTransactionChanges exists, disable it before running this reset script.
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
