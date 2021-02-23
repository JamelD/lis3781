# LIS 3781 - Advanced Database Management

## Jamel Douglas

### Assignment 3 Requirements:

*Two Parts:*

1. RemoteLabs Oracle Server
    - Create and populate tables using sql
    - SQL Solutions (Reports)
        + Display Oracle version(one method).
        + Display Oracle version(another method).
        + Display current user.
        + Display current day/time (formatted, and displaying AM/PM).
        + Display your privileges.6.Display all user tables.
        + Display structure for each table.
        + List the customer number, last name, first name, and e-mail of every customer.
        + Same query as above, include street, city, state, and sort by state in descending order, and last name in ascending order.
        + What is the full name of customer number 3? Display last name first.
        + Find the customer number, last name, first name, and current balance for every customer whose balance exceeds $1,000, sorted by largest to smallest balances.
        + List the name of every commodity, and its price (formatted to two decimal places, displaying $ sign), sorted by smallest to largest price.
        + Display all customers’ first and last names, streets, cities, states, and zip codes as follows (ordered by zip code descending).
        + List all orders not including cereal--use subquery to find commodity id for cereal.
        + List the customer number, last name, first name, and balance for every customer whose balance is between $500 and $1,000, (format currency to two decimal places, displaying $ sign).
        + List the customer number, last name, first name, and balance for every customer whose balance is greater than the average balance, (format currency to two decimal places, displaying $ sign).
        + List the customer number, name, and *total* order amount for each customer sorted in descending *total* order amount, (format currency to two decimal places, displaying $ sign), and include an alias “total orders” for the derived attribute.
        + List the customer number, last name, first name, and complete address of every customer who lives on a street with "Peach" anywherein the street name.
        + List the customer number, name, and *total* order amount for each customer whose *total* order amount is greater than $1500, for each customer sorted in descending *total* order amount, (format currency to two decimal places, displaying $ sign), and include an alias “total orders” for the derived attribute.
        + List the customer number, name, and number of units ordered for orders with 30, 40, or 50 units ordered.
        + Using EXISTS operator: List customer number, name, number of orders, minimum, maximum, and sum of their order total cost, only if there are 5 or more customers in the customer table, (format currency to two decimal places, displaying $ sign).
        + Find aggregate values for customers:(Note, difference between count(*) and count(cus_balance), one customer does not have a balance.)
        + Find the number of unique customers who have orders.
        + List the customer number, name, commodity name, order number, and order amount for each customer order, sorted in descending order amount, (format currency to two decimal places, displaying $ sign), and include an alias “order amount” for the derived attribute.
        + Modify prices for DVD players to $99.Note:First, *be sure* toSET DEFINE OFF(don't use a semi-colon on the end).
2. Bitbucket Repository 

#### README.md file should include the following items:

* Screenshot of sql code
* Screenshot of populated tables
* Optional : SQL code for required reports

#### Assignment Screenshots:

*Screenshot of SQL Code*:

![SQL Code Screenshot](img/sqlcode.png)

*Screenshot of populated tables*:

![Company Populated Table Screenshot](img/tables.png)
