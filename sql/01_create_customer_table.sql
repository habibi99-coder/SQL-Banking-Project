USE SmartBankDB;
Go

CREATE TABLE customer
(
	customer_id INT IDENTITY(1,1) PRIMARY KEY,
	customer_code AS RIGHT('0000' + CAST(customer_id AS VARCHAR(10)),4),

	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	date_of_birth DATE NOT NULL,
	ssn CHAR(9) NOT NULL,

	street_address VARCHAR(100) NOT NULL,
	city VARCHAR(50) NOT NULL,
	state_resident CHAR(2) NOT NULL,
	zip_code VARCHAR(10) NOT NULL,

	customer_type VARCHAR(20) NOT NULL,

	CONSTRAINT chk_customer_type
		CHECK (customer_type IN ('PERSONAL', 'JOINT', 'BUSINESS')),

	CONSTRAINT uq_customer_duplicate
		UNIQUE (first_name, last_name, date_of_birth),

	CONSTRAINT state_chk
		CHECK (state_resident IN ('AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 
'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 
'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 
'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 
'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY')),

	CONSTRAINT chk_ssn_length
		CHECK (ssn NOT LIKE '%[^0-9]%'),
	
	CONSTRAINT uq_customer_ssn
		UNIQUE (ssn),

);
GO

