USE SmartBankDB;
GO

SELECT *
FROM account;
GO

USE SmartBankDB;
GO

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'DEPOSIT',
    500.00,
    'TELLER',
    1001,
    NULL
);
GO

--^Successful Transaction DEPOSIT--

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'WITHDRAWAL',
    100.00,
    'ATM',
    1001,
    NULL
);
GO

--^Successful Transaction Withdrawal--

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'TRANSFER',
    75.00,
    'APP',
    1001,
    1002
);
GO
--^ Successful Transfer --

/*USE SmartBankDB;
GO

DELETE FROM account_transaction;
GO

Select * from account_transaction
Go

-- Delete all transactions --

*/

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'DEPOSIT',
    250.00,
    'APP',
    1003,
    NULL
);
GO

Select * from account_transaction
Go

-- ^ Successful Deposit --
USE SmartBankDB;
GO

SELECT
    t.transaction_id,
    t.type_of_transaction,
    t.transaction_amount,
    t.transaction_date,
    t.transaction_location,
    t.source_account_number,
    t.destination_account_number,
    c.customer_code,
    c.first_name,
    c.last_name
FROM account_transaction t
JOIN account a
    ON t.source_account_number = a.account_number
JOIN customer c
    ON a.customer_id = c.customer_id;
GO


-- ^jOIN TABLE --


/* Fail Cases
INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'PAYMENT',
    50.00,
    'APP',
    1001,
    NULL
);
GO

USE SmartBankDB
GO

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'DEPOSIT',
    -25.00,
    'TELLER',
    1001,
    NULL
);
GO

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'DEPOSIT',
    100.00,
    'BRANCH',
    1001,
    NULL
);
GO

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'TRANSFER',
    50.00,
    NULL,
    1001,
    NULL
);
GO

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'DEPOSIT',
    100.00,
    'ATM',
    1001,
    1002
);
GO

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'TRANSFER',
    25.00,
    NULL,
    1001,
    1001
);
GO

INSERT INTO account_transaction
(
    type_of_transaction,
    transaction_amount,
    transaction_location,
    source_account_number,
    destination_account_number
)
VALUES
(
    'WITHDRAWAL',
    20.00,
    'ATM',
    9999,
    NULL
);
GO
*/ --Fail Cases--


SELECT * FROM account_transaction
GO

