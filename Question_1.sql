/*
Using the database WideWorldImporters, write a SQL query which reports the consistency between orders and their attached invoices.
The resultset should report for each (CustomerID, CustomerName)
 a. the total number of orders: TotalNBOrders
 b. the number of invoices converted from an order: TotalNBInvoices
 c. the total value of orders: OrdersTotalValue
 d. the total value of invoices: InvoicesTotalValue
 f. the absolute value of the difference between c - d: AbsoluteValueDifference
 
 The resultset must be sorted by highest values of AbsoluteValueDifference, then by smallest to highest values of TotalNBOrders and CustomerName is that order.
 
 Please note that all values in a & b must be identical by definition of the query, as we are observing orders converted into invoices.
We are looking for potential differences between c & d.
BUT, you must find them consistent as the data is clean in WideWorldImporters.
Resultset enclosed in Q1-Resultset_Corrected.csv 
*/
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