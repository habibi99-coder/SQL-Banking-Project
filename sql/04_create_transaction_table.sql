USE SmartBankDB
GO

CREATE TABLE account_transaction
(
	transaction_id INT IDENTITY(1,1) PRIMARY KEY,
	type_of_transaction VARCHAR(20) NOT NULL,
	transaction_amount DECIMAL(12,2) NOT NULL,
	transaction_date DATETIME NOT NULL
		CONSTRAINT df_transaction_date DEFAULT GETDATE(),
	transaction_location VARCHAR(20) NULL,
	source_account_number INT NOT NULL,
	destination_account_number INT NULL,

	CONSTRAINT fk_transaction_source_account
		FOREIGN KEY (source_account_number)
		REFERENCES account(account_number),

	CONSTRAINT fk_transaction_destination_account
		FOREIGN KEY (destination_account_number)
		REFERENCES account(account_number),

	CONSTRAINT chk_type_of_transaction
		CHECK (type_of_transaction IN ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER')),

	CONSTRAINT chk_transaction_amount
		CHECK (transaction_amount > 0),

	CONSTRAINT chk_transaction_location
		CHECK (
			transaction_location IN ('ATM', 'APP', 'TELLER')
			OR transaction_location IS NULL
	),

	CONSTRAINT chk_transfer_destination_required
		CHECK (
		(type_of_transaction = 'TRANSFER' AND destination_account_number IS NOT NULL)
		OR
		(type_of_transaction IN ('DEPOSIT', 'WITHDRAWAL') AND destination_account_number IS NULL)
		),
	CONSTRAINT chk_transfer_different_accounts
		CHECK (
		destination_account_number IS NULL
		OR source_account_number <> destination_account_number
		)

);
GO

