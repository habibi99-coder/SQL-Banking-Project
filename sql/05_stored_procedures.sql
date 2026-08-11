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


