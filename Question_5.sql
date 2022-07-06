/*
In the database SQLPlayground, write a SQL query selecting all the customers'
data who have purchased all the products AND have bought more than 50 products in total (sum of all purchases).
Resultset enclosed in Q5-Resultset.csv
*/
SELECT Purchase.CustomerId, CustomerName
FROM Purchase
JOIN Customer ON Purchase.CustomerId = Customer.CustomerId
GROUP BY Purchase.CustomerId, CustomerName
HAVING COUNT(DISTINCT ProductId) = (SELECT COUNT(*) FROM Product) AND SUM(Qty) >= 50