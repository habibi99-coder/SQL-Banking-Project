# SQL-Banking-Project
A SQL Server banking database project demonstrating relational design, constraints, stored procedures, triggers, and transaction processing.
# SmartBank SQL Server Database System

## Project Overview

SmartBank is a SQL Server database project designed to simulate a regional banking system. The system manages customers, phone numbers, bank accounts, and financial transactions while enforcing important business rules through constraints, stored procedures, triggers, and validation logic.

This project is being developed as a portfolio-ready database system to demonstrate practical SQL Server development skills, relational database design, data integrity enforcement, and transaction processing.

## Project Status

**Status:** In Progress

Current progress:

* Installed SQL Server Developer Edition
* Installed SQL Server Management Studio
* Created the `SmartBankDB` database
* Created and tested the `customer` table
* Added customer-level constraints for data integrity
* Began organizing SQL scripts and documentation for GitHub

## Project Goals

The main goal of this project is to design and implement a relational database system that can:

* Store customer information
* Store customer phone numbers
* Manage bank accounts
* Process deposits, withdrawals, and transfers
* Prevent invalid or duplicate data
* Automatically maintain account balances
* Demonstrate stored procedures, triggers, constraints, and testing scripts

## Tools and Technologies

* Microsoft SQL Server Developer Edition
* SQL Server Management Studio
* T-SQL
* GitHub
* GitHub Desktop

## Planned Database Tables

The project will include the following main tables:

| Table Name            | Purpose                                                   |
| --------------------- | --------------------------------------------------------- |
| `customer`            | Stores customer identity, address, SSN, and customer type |
| `phone`               | Stores one or more phone numbers for each customer        |
| `account`             | Stores bank account information and balances              |
| `account_transaction` | Stores deposit, withdrawal, and transfer activity         |

## Current Table: `customer`

The `customer` table stores customer information and includes several data integrity rules.

### Key Features

* Auto-generated customer ID
* Formatted customer code such as `0001`, `0002`, `0003`
* Required first name and last name
* Required date of birth
* Required SSN
* Required address information
* Customer type validation
* U.S. state abbreviation validation
* Duplicate customer prevention
* Unique SSN enforcement

### Customer Table Constraints

| Constraint              | Purpose                                                                             |
| ----------------------- | ----------------------------------------------------------------------------------- |
| Primary Key             | Ensures each customer has a unique `customer_id`                                    |
| `chk_customer_type`     | Allows only `PERSONAL`, `JOINT`, or `BUSINESS`                                      |
| `state_chk`             | Allows only valid U.S. state abbreviations                                          |
| `uq_customer_duplicate` | Prevents duplicate customers with the same first name, last name, and date of birth |
| `uq_customer_ssn`       | Prevents duplicate SSNs                                                             |
| `chk_ssn_digits`        | Ensures SSN contains only numeric digits                                            |

## Business Rules

### Customer Rules

* Each customer must have a unique customer ID.
* Each customer must have a unique SSN.
* Customer type must be one of the following:

  * `PERSONAL`
  * `JOINT`
  * `BUSINESS`
* Duplicate customers are not allowed.
* A duplicate customer is defined as the same first name, last name, and date of birth.
* Customer state must be a valid U.S. state abbreviation.

### Account Rules

* Each account must belong to one customer.
* A customer may have multiple accounts.
* Valid account types are:

  * `CHECKING`
  * `SAVINGS`
  * `BOND`
* New accounts must begin with a balance of `0.00`.
* Account balances cannot become negative.

### Transaction Rules

* Valid transaction types are:

  * `DEPOSIT`
  * `WITHDRAWAL`
  * `TRANSFER`
* Transaction amount must be greater than zero.
* Deposits increase account balance.
* Withdrawals decrease account balance.
* Transfers move money from one account to another.
* Withdrawals and transfers cannot result in a negative balance.

## Repository Structure

```text
SmartBank-SQL-Server-Database/
│
├── README.md
│
├── sql/
│   ├── 01_create_customer_table.sql
│   ├── 02_create_phone_table.sql
│   ├── 03_create_account_table.sql
│   ├── 04_create_transaction_table.sql
│   ├── 05_stored_procedures.sql
│   ├── 06_triggers.sql
│   └── 07_test_cases.sql
│
├── docs/
│   └── business_rules.md
│
└── screenshots/
    └── customer_table_test.png
```

## Skills Demonstrated

This project demonstrates hands-on experience with:

* Relational database design
* SQL Server database creation
* T-SQL table creation
* Primary keys and foreign keys
* Check constraints
* Unique constraints
* Data validation
* Stored procedures
* Triggers
* Transaction processing
* Testing successful and failed database operations
* GitHub project documentation

## Next Steps

Planned next steps:

1. Create the `phone` table
2. Create the `account` table
3. Create the `account_transaction` table
4. Build stored procedures for customer creation, account creation, and transaction processing
5. Build triggers for account balance updates and transaction validation
6. Add test cases for successful and failed operations
7. Add screenshots and ERD documentation
8. Prepare the project for LinkedIn, Handshake, and resume use

## Portfolio Purpose

This project is intended to demonstrate practical SQL Server skills for entry-level database, data analyst, and technical support roles. It shows the ability to design a structured relational database, enforce business rules, validate data, and document a technical project clearly.
