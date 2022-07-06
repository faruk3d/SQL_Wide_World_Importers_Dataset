SELECT Purchase.CustomerId, CustomerName
FROM Purchase
JOIN Customer ON Purchase.CustomerId = Customer.CustomerId
GROUP BY Purchase.CustomerId, CustomerName
HAVING COUNT(DISTINCT ProductId) = (SELECT COUNT(*) FROM Product) AND SUM(Qty) >= 50


