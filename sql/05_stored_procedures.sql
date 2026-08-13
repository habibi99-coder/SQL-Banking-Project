	--PROCEDURE 1: ADDCUSTOMER
Use SmartBankDB
GO

CREATE PROCEDURE AddCustomer
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@DateOfBirth DATE,
@SSN CHAR(9),
@StreetAddress VARCHAR(100),
@City VARCHAR(50),
@StateResident CHAR(2),
@ZipCode VARCHAR(10),
@CustomerType VARCHAR(20)

AS 
BEGIN

SET @FirstName = UPPER(LEFT(@FirstName, 1)) + LOWER(Substring(@FirstName, 2, LEN(@FirstName)));
SET @LastName = UPPER(LEFT(@LastName, 1)) + LOWER(Substring(@LastName, 2, LEN(@LastName)));
SET @City = UPPER(LEFT(@City, 1)) + LOWER(Substring(@City, 2, Len(@City)));
SET @StateResident = UPPER(@StateResident);
SET @CustomerType = UPPER(@CustomerType);
-- Validate customer type
	IF @CustomerType NOT IN ('PERSONAL', 'JOINT', 'BUSINESS')
		BEGIN 
			PRINT 'Customer creation failed: invalid customer type.';
			RETURN;
	END;

-- Validate SSN contains only digits
	IF @SSN LIKE '%[^0-9]%'
		BEGIN
			PRINT 'Customer creation failed: SSN must contain exactly 9 digits.';
			RETURN;
		END;
 -- Validate duplicate SSN
	IF EXISTS
	(
		SELECT 1
		FROM customer
		WHERE ssn = @SSN
	)
	BEGIN
		PRINT 'Customer creation failed: SSN already exists.'
		RETURN;
	END;
-- Validate duplicate customer
	IF EXISTS
	(
		SELECT 1
		FROM customer
		WHERE first_name = @FirstName
		AND last_name = @LastName
		AND date_of_birth = @DateOfBirth
	)
	BEGIN
		PRINT 'Customer creation failed: duplicate customer already exists.'
		RETURN
	END;

	INSERT INTO customer
	(
		first_name,
		last_name,
		date_of_birth,
		ssn,
		street_address,
		city,
		state_resident,
		zip_code,
		customer_type
	)

	VALUES
	(
		@FirstName,
		@LastName,
		@DateOfBirth,
		@SSN,
		@StreetAddress,
		@City,
		@StateResident,
		@ZipCode,
		@CustomerType
	);

END;
GO

	-- PROCEDURE 2: ADDACCOUNT
USE SmartBankDB;
GO

DROP PROCEDURE IF EXISTS AddAccount;
GO

CREATE PROCEDURE AddAccount
    @AccountNumber INT,
    @CustomerID INT,
    @TypeOfAccount VARCHAR(20),
    @DateOpened DATE
AS
BEGIN
    -- Standardize account type
    SET @TypeOfAccount = UPPER(@TypeOfAccount);

    -- Check if account number already exists
    IF EXISTS
    (
        SELECT 1
        FROM account
        WHERE account_number = @AccountNumber
    )
    BEGIN
        PRINT 'Account creation failed: account number already exists.';
        RETURN;
    END;

    -- Check if customer exists
    IF NOT EXISTS
    (
        SELECT 1
        FROM customer
        WHERE customer_id = @CustomerID
    )
    BEGIN
        PRINT 'Account creation failed: customer does not exist.';
        RETURN;
    END;

    -- Check account type
    IF @TypeOfAccount NOT IN ('CHECKING', 'SAVINGS', 'BOND')
    BEGIN
        PRINT 'Account creation failed: invalid account type.';
        RETURN;
    END;

    -- Insert account with default balance of 0.00
    INSERT INTO account
    (
        account_number,
        type_of_account,
        date_opened,
        customer_id
    )
    VALUES
    (
        @AccountNumber,
        @TypeOfAccount,
        @DateOpened,
        @CustomerID
    );

    PRINT 'Account created successfully.';
END;
GO

--PROCEDURE 3: ProcessTransaction

USE SmartBankDB;
GO

-- Remove the existing ProcessTransaction procedure if it already exists.
-- This allows us to recreate the procedure without getting an error.
DROP PROCEDURE IF EXISTS ProcessTransaction;
GO

-- Create a stored procedure named ProcessTransaction.
-- This procedure will handle deposits, withdrawals, and transfers.
CREATE PROCEDURE ProcessTransaction
    @TransactionType VARCHAR(20),
    @TransactionAmount DECIMAL(12,2),
    @TransactionLocation VARCHAR(20),
    @SourceAccountNumber INT,
    @DestinationAccountNumber INT = NULL
AS
BEGIN
    -- Standardize transaction type and location.
    -- This allows users to enter values like 'deposit' or 'teller',
    -- and the procedure will convert them to 'DEPOSIT' and 'TELLER'.
    SET @TransactionType = UPPER(@TransactionType);
    SET @TransactionLocation = UPPER(@TransactionLocation);

    -- Validate transaction type.
    -- Only DEPOSIT, WITHDRAWAL, and TRANSFER are allowed.
    IF @TransactionType NOT IN ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER')
    BEGIN
        PRINT 'Transaction failed: invalid transaction type.';
        RETURN;
    END;

    -- Validate transaction amount.
    -- The amount must be greater than zero.
    IF @TransactionAmount <= 0
    BEGIN
        PRINT 'Transaction failed: amount must be greater than $0.';
        RETURN;
    END;

    -- Validate transaction location.
    -- Only ATM, APP, and TELLER are allowed.
    IF @TransactionLocation NOT IN ('ATM', 'APP', 'TELLER')
    BEGIN
        PRINT 'Transaction failed: invalid transaction location.';
        RETURN;
    END;

    -- Validate source account.
    -- The source account must exist before any transaction can be processed.
    IF NOT EXISTS
    (
        SELECT 1
        FROM account
        WHERE account_number = @SourceAccountNumber
    )
    BEGIN
        PRINT 'Transaction failed: source account does not exist.';
        RETURN;
    END;

    -- Validate transfer destination requirement.
    -- A transfer must have a destination account.
    IF @TransactionType = 'TRANSFER'
       AND @DestinationAccountNumber IS NULL
    BEGIN
        PRINT 'Transaction failed: transfer requires a destination account.';
        RETURN;
    END;

    -- Validate deposit and withdrawal destination rule.
    -- Deposits and withdrawals should not have a destination account.
    IF @TransactionType IN ('DEPOSIT', 'WITHDRAWAL')
       AND @DestinationAccountNumber IS NOT NULL
    BEGIN
        PRINT 'Transaction failed: deposit or withdrawal should not have a destination account.';
        RETURN;
    END;

    -- Validate destination account for transfers.
    -- If the transaction is a transfer, the destination account must exist.
    IF @TransactionType = 'TRANSFER'
       AND NOT EXISTS
       (
            SELECT 1
            FROM account
            WHERE account_number = @DestinationAccountNumber
       )
    BEGIN
        PRINT 'Transaction failed: destination account does not exist.';
        RETURN;
    END;

    -- Validate that source and destination accounts are different.
    -- A transfer from an account to the same account should not be allowed.
    IF @TransactionType = 'TRANSFER'
       AND @SourceAccountNumber = @DestinationAccountNumber
    BEGIN
        PRINT 'Transaction failed: source and destination accounts cannot be the same for balance transfer.';
        RETURN;
    END;

    -- Validate sufficient balance for withdrawals.
    -- The withdrawal amount cannot be greater than the current account balance.
    IF @TransactionType = 'WITHDRAWAL'
       AND EXISTS
       (
            SELECT 1
            FROM account
            WHERE account_number = @SourceAccountNumber
              AND balance < @TransactionAmount
       )
    BEGIN
        PRINT 'Transaction failed: insufficient funds.';
        RETURN;
    END;

    -- Validate sufficient balance for transfers.
    -- The source account must have enough balance before money can be transferred.
    IF @TransactionType = 'TRANSFER'
       AND EXISTS
       (
            SELECT 1
            FROM account
            WHERE account_number = @SourceAccountNumber
              AND balance < @TransactionAmount
       )
    BEGIN
        PRINT 'Transaction failed: insufficient funds for transfer.';
        RETURN;
    END;

    -- Insert the transaction record.
    -- If all validation checks passed, the transaction is saved in account_transaction.
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
        @TransactionType,
        @TransactionAmount,
        @TransactionLocation,
        @SourceAccountNumber,
        @DestinationAccountNumber
    );

    -- Print success message.
    PRINT 'Transaction recorded successfully.';
END;
GO

