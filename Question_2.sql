/*
In the database SQLPlayground, write a SQL query selecting all the customers'
data who have purchased all the products AND have bought more than 50 products in total (sum of all purchases).
Resultset enclosed in Q5-Resultset.csv
*/
UPDATE Sales.InvoiceLines
SET Sales.InvoiceLines.UnitPrice = Sales.InvoiceLines.UnitPrice + 20
WHERE Sales.InvoiceLines.InvoiceLineID = 
	(SELECT TOP(1) il.InvoiceLineID
	FROM Sales.InvoiceLines AS il
	JOIN Sales.Invoices AS i ON il.InvoiceID = i.InvoiceID
	JOIN Sales.Orders AS o ON i.OrderID = o.OrderID
	WHERE o.CustomerID = 1060
	ORDER BY il.InvoiceLineID ASC)