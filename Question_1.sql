SELECT
	c.CustomerID,
	c.CustomerName,
	TotalOrder.TotalNBOrders,
	TotalInvoice.TotalNBInvoices,
	TotalOrder.OrdersTotalValue,
	TotalInvoice.InvoicesTotalValue,
	abs(TotalOrder.OrdersTotalValue-TotalInvoice.InvoicesTotalValue) AS AbsoluteValueDifference
FROM Sales.Customers AS c
JOIN (SELECT o.CustomerID, COUNT(DISTINCT o.OrderID) AS TotalNBOrders,
		SUM(ol.Quantity * ol.UnitPrice) AS OrdersTotalValue
		FROM Sales.Orders AS o
		JOIN Sales.OrderLines AS ol ON o.OrderID = ol.OrderID
		JOIN Sales.Invoices AS i ON o.OrderID = i.OrderID
		GROUP BY o.CustomerID) TotalOrder
ON TotalOrder.CustomerID = c.CustomerID
JOIN (SELECT i.CustomerID, COUNT(DISTINCT i.InvoiceID) AS TotalNBInvoices,
		SUM(il.Quantity * il.UnitPrice) AS InvoicesTotalValue
		FROM Sales.Invoices AS i
		JOIN Sales.InvoiceLines AS il ON i.InvoiceID = il.InvoiceID
		GROUP BY i.CustomerID) TotalInvoice
ON TotalInvoice.CustomerID = c.CustomerID
ORDER BY AbsoluteValueDifference DESC, TotalNBOrders, c.CustomerName