-- 1. non_usa_customers.sql

SELECT c.FirstName
	,c.LastName
	,c.CustomerId
	,c.Country
FROM Customer c
WHERE Country != 'USA'