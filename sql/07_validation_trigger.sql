USE SmartBankDB;
GO

DROP TRIGGER IF EXISTS trg_PreventTransactionChanges;
GO

CREATE TRIGGER trg_PreventTransactionChanges
ON account_transaction
AFTER UPDATE, DELETE
AS
BEGIN
    PRINT 'Transaction records cannot be updated or deleted. Create a correction transaction instead.';
    ROLLBACK TRANSACTION;
END;
GO
