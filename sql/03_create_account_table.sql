USE SmartBankDB;
GO

CREATE TABLE account
(	
	account_number INT PRIMARY KEY,
	type_of_account VARCHAR(20) NOT NULL,
	balance DECIMAL (12,2) NOT NULL
		CONSTRAINT df_account_balance DEFAULT 0.00,
	date_opened DATE NOT NULL,
	customer_id INT NOT NULL,

	CONSTRAINT fk_account_customer 
		FOREIGN KEY (customer_id)
		REFERENCES customer(customer_id),

	CONSTRAINT chk_type_of_account
		CHECK (type_of_account IN ('CHECKING','SAVINGS','BOND')),

	CONSTRAINT chk_account_balance
		CHECK(balance >= 0)


);
GO


