UPDATE Sales.InvoiceLines
SET Sales.InvoiceLines.UnitPrice = Sales.InvoiceLines.UnitPrice + 20
WHERE Sales.InvoiceLines.InvoiceLineID = 
	(SELECT TOP(1) il.InvoiceLineID
	FROM Sales.InvoiceLines AS il
	JOIN Sales.Invoices AS i ON il.InvoiceID = i.InvoiceID
	JOIN Sales.Orders AS o ON i.OrderID = o.OrderID
	WHERE o.CustomerID = 1060
	ORDER BY il.InvoiceLineID ASC)