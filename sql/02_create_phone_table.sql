USE SmartBankDB
go

CREATE TABLE contacts

(
	phone_id INT IDENTITY(1,1) PRIMARY KEY,

	customer_id INT NOT NULL,

	phone_number CHAR(10) NOT NULL,

	phone_formatted AS
		'('+ SUBSTRING(phone_number, 1, 3) + ')' + SUBSTRING(phone_number, 4, 3) + '-' + SUBSTRING(phone_number, 7, 4),

	CONSTRAINT fk_phone_customer
		FOREIGN KEY (customer_id)
		REFERENCES customer(customer_id),

	CONSTRAINT chk_phone_digits
		CHECK (phone_number NOT LIKE '%[^0-9]%'),

	CONSTRAINT uq_customer_phone
		UNIQUE (customer_id, phone_number)

);
GO

SELECT * FROM contacts;
