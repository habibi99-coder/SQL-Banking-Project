USE SmartBankDB
GO

DROP TRIGGER IF EXISTS trg_UpdateAccountBalance;
GO

-- Create a trigger named trg_UpdateAccountBalance.
-- This trigger runs automatically after a new row is inserted into account_transaction.
CREATE TRIGGER	trg_UpdateAccountBalance
ON Account_transaction
AFTER INSERT
AS 
BEGIN
    -- Deposit logic:
    -- If the inserted transaction is a DEPOSIT,
    -- add the transaction amount to the source account balance.
	UPDATE a
	SET a.balance = a.balance + i.transaction_amount
	FROM account a
	JOIN inserted i
		ON a.account_number = i.source_account_number
	WHERE i.type_of_transaction = 'DEPOSIT';

    -- Withdrawal logic:
    -- If the inserted transaction is a WITHDRAWAL,
    -- subtract the transaction amount from the source account balance.
	UPDATE a
	SET a.balance = a.balance - i.transaction_amount 
	FROM account a
	JOIN inserted i
		ON a.account_number = i.source_account_number
	WHERE i.type_of_transaction = 'WITHDRAWAL';
	-- Transfer source account logic:
    -- If the inserted transaction is a TRANSFER,
    -- subtract the transaction amount from the source account.
	UPDATE a
	SET a.balance = a.balance - i.transaction_amount
	FROM account a
	JOIN inserted i
		ON a.account_number = i.source_account_number
	WHERE i.type_of_transaction = 'TRANSFER';

	-- Transfer destination account logic:
    -- If the inserted transaction is a TRANSFER,
    -- add the transaction amount to the destination account.
	UPDATE a
    SET a.balance = a.balance + i.transaction_amount
    FROM account a
    JOIN inserted i
        ON a.account_number = i.destination_account_number
    WHERE i.type_of_transaction = 'TRANSFER';


	-- Negative balance protection:
    -- If any account balance becomes negative after the update,
    -- cancel the whole transaction and undo the balance change.
    IF EXISTS
    (
        SELECT 1
        FROM account
        WHERE balance < 0
    )
    BEGIN
        PRINT 'Transaction failed: account balance cannot be negative.';
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

