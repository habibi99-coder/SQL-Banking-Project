# SmartBank Business Rules

This document describes the main business rules enforced in the SmartBank SQL Server Database System.

## Customer Rules

1. Each customer must have a unique customer ID.
2. Each customer must have a unique SSN.
3. Customer type must be one of the following:
   - `PERSONAL`
   - `JOINT`
   - `BUSINESS`
4. Duplicate customers are not allowed.
5. A duplicate customer is defined as the same first name, last name, and date of birth.
6. Customer state must be a valid U.S. state abbreviation.
7. SSN values must contain only numeric digits.

## Contact Rules

1. Each phone number must belong to a valid customer.
2. A customer can have multiple phone numbers.
3. Phone numbers must contain only numeric digits.
4. The same phone number cannot be duplicated for the same customer.
5. Phone numbers are stored as raw digits and displayed using a formatted computed column.

## Account Rules

1. Each account must belong to one valid customer.
2. A customer may have multiple accounts.
3. Valid account types are:
   - `CHECKING`
   - `SAVINGS`
   - `BOND`
4. New accounts begin with a default balance of `0.00`.
5. Account balances cannot become negative.
6. Account numbers are manually assigned.

## Transaction Rules

1. Valid transaction types are:
   - `DEPOSIT`
   - `WITHDRAWAL`
   - `TRANSFER`
2. Valid transaction locations are:
   - `ATM`
   - `APP`
   - `TELLER`
3. Transaction amounts must be greater than zero.
4. Deposits increase the source account balance.
5. Withdrawals decrease the source account balance.
6. Transfers decrease the source account balance and increase the destination account balance.
7. Transfers must include a valid destination account.
8. Deposits and withdrawals should not include a destination account.
9. Transfers cannot use the same account as both source and destination.
10. Withdrawals and transfers cannot create a negative balance.

## Stored Procedure Rules

The system uses stored procedures to control important database operations.

### `AddCustomer`

This procedure validates customer information before inserting a new customer.

It checks:

- Customer type
- SSN format
- Duplicate SSN
- Duplicate customer rule

### `AddAccount`

This procedure validates account information before creating a new account.

It checks:

- Whether the account number already exists
- Whether the customer exists
- Whether the account type is valid

### `ProcessTransaction`

This procedure validates transaction information before recording a transaction.

It checks:

- Transaction type
- Transaction amount
- Transaction location
- Source account existence
- Destination account requirement for transfers
- Sufficient funds for withdrawals and transfers

## Trigger Rules

### `trg_UpdateAccountBalance`

This trigger automatically updates account balances after new transaction records are inserted.

It handles:

- Deposit balance increases
- Withdrawal balance decreases
- Transfer source account decreases
- Transfer destination account increases
- Negative balance prevention

### `trg_PreventTransactionChanges`

This trigger prevents existing transaction records from being updated or deleted.

This protects transaction history and supports audit integrity. In real banking systems, transaction records should not be casually edited or deleted. Corrections should be handled through reversal or correction transactions instead.

## Testing Rules

The project includes final test cases for both successful and failed operations.

Tested scenarios include:

- Successful customer creation
- Failed duplicate customer creation
- Successful account creation
- Failed account creation for invalid customer
- Successful deposit
- Successful withdrawal
- Successful transfer
- Failed withdrawal due to insufficient funds
- Failed attempt to update transaction history
