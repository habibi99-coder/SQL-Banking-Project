# SmartBank SQL Server Database System - Project Summary

## Project Description

SmartBank is a SQL Server database project that simulates a regional banking system. The project manages customer information, customer contact numbers, bank accounts, and financial transactions. It uses relational database design, constraints, stored procedures, triggers, and testing scripts to enforce business rules and maintain data integrity.

The system supports customer creation, account creation, deposits, withdrawals, and transfers. It also includes automated balance updates and validation logic to prevent invalid transactions and protect transaction history.

## Problem Solved

Banks need structured systems to manage customers, accounts, and financial transactions accurately. This project demonstrates how a relational database can enforce rules such as preventing duplicate customers, validating account types, preventing negative balances, and protecting transaction history from unauthorized updates or deletions.

## Key Features

- Designed a relational database using SQL Server
- Created normalized tables for customers, contacts, accounts, and transactions
- Applied primary keys, foreign keys, check constraints, unique constraints, default constraints, and computed columns
- Built stored procedures for controlled customer, account, and transaction processing
- Created a trigger to automatically update account balances after deposits, withdrawals, and transfers
- Created a validation trigger to prevent transaction records from being updated or deleted
- Tested successful and failed database operations
- Documented project scripts, business rules, screenshots, and final test cases

## SQL Server Skills Demonstrated

- Database creation
- Table design
- Primary key and foreign key relationships
- Data validation using constraints
- Stored procedure development
- Trigger development
- Transaction processing logic
- Balance automation
- Error prevention
- Testing and documentation
- GitHub project organization

## Business Rules Implemented

- Customers must have unique SSNs.
- Duplicate customers are prevented using first name, last name, and date of birth.
- Customers may have multiple phone numbers.
- Accounts must belong to valid customers.
- Valid account types are CHECKING, SAVINGS, and BOND.
- New accounts begin with a balance of 0.00.
- Valid transaction types are DEPOSIT, WITHDRAWAL, and TRANSFER.
- Valid transaction locations are ATM, APP, and TELLER.
- Withdrawals and transfers cannot create a negative balance.
- Transfers require a valid destination account.
- Transaction records cannot be updated or deleted after creation.

## Testing Completed

The project includes final test cases for:

- Successful customer creation
- Failed duplicate customer creation
- Successful account creation
- Failed account creation for invalid customer
- Successful deposit
- Successful withdrawal
- Successful transfer
- Failed withdrawal due to insufficient funds
- Failed transaction update due to validation trigger
- Final account and transaction summary

## Portfolio Value

This project demonstrates practical SQL Server development skills for entry-level database, data analyst, technical support, IT support, and business systems roles. It shows the ability to design a database, enforce business rules, automate data changes, test expected results, and document a technical project clearly.

## Resume Version

Built a SQL Server banking database system with normalized tables, constraints, stored procedures, triggers, and test cases to manage customers, accounts, and financial transactions. Implemented automated balance updates, duplicate customer prevention, transaction validation, and audit protection logic. Documented the project with GitHub scripts, screenshots, business rules, and final test results.

## LinkedIn / Handshake Version

Completed a SQL Server database project simulating a regional banking system. The project includes customer management, account creation, transaction processing, stored procedures, triggers, constraints, automated balance updates, validation logic, and final test documentation. This project strengthened my hands-on skills in relational database design, T-SQL, data integrity, transaction processing, and technical documentation.

## Interview Talking Points

If asked about this project, I can explain:

- How I designed the main tables and relationships
- Why I used constraints to enforce business rules
- How stored procedures control customer, account, and transaction entry
- How the balance trigger updates account balances automatically
- How the validation trigger protects transaction history
- How I tested both successful and failed operations
- What I would improve in a production-level banking system
