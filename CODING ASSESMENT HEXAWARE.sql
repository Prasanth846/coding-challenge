create database carrental;
use  carrental;


TASK 1[Update the daily rate for a Mercedes car to 68]

UPDATE Vehicle 
SET dailyRate = 68.00 
WHERE make = 'Mercedes';

SET SQL_SAFE_UPDATES = 0;

TASK 2[Delete a specific customer and all associated leases and payments (customerID 3)]


DELETE FROM Payment WHERE leaseID IN (SELECT leaseID FROM Lease WHERE customerID = 3);
DELETE FROM Lease WHERE customerID = 3;
DELETE FROM Customer WHERE customerID = 3;
SELECT * FROM Customer WHERE customerID = 3;


TASK 3[Rename the "paymentDate" column in the Payment table to "transactionDate"]


ALTER TABLE Payment CHANGE paymentDate transactionDate DATE;

TASK4[Find a specific customer by email]

SELECT * FROM Customer WHERE email = 'johndoe@example.com';

TASK 5[Get active leases for a specific customer (customerID 5 on 2023-05-08)]

SELECT * FROM Lease 
WHERE customerID = 5 
AND '2023-05-08' BETWEEN startDate AND endDate;

TASK 6[Find all payments made by a customer with phone '555-123-4567']

SELECT p.* FROM Payment p, Lease l, Customer c
WHERE p.leaseID = l.leaseID 
AND l.customerID = c.customerID
AND c.phoneNumber = '555-123-4567';

TASK 7 [Calculate average daily rate of available cars]

SELECT AVG(dailyRate) FROM Vehicle WHERE available = 1;


TASK 8[Find car with highest daily rate]

SELECT * FROM Vehicle 
ORDER BY dailyRate DESC 
LIMIT 1;

TASK 9[Retrieve all cars leased by customerID 3 (before deletion0]

SELECT v.* FROM Vehicle v, Lease l
WHERE v.carID = l.carID
AND l.customerID = 3;

TASK 10[ Find details of most recent lease (by start date)]

SELECT * FROM Lease 
ORDER BY startDate DESC 
LIMIT 1;


TASK 11 [ List all payments made in 2023 (assuming all payments are in 2023)]

SELECT * FROM Payment;

TASK 12 [Customers who havent made payments]

SELECT c.* FROM Customer c
WHERE c.customerID NOT IN (
    SELECT DISTINCT l.customerID 
    FROM Lease l, Payment p
    WHERE l.leaseID = p.leaseID
);

TASK 13 [Car details with total payments]

SELECT v.*, SUM(p.amount) as totalPayments
FROM Vehicle v, Lease l, Payment p
WHERE v.carID = l.carID AND l.leaseID = p.leaseID
GROUP BY v.carID;

TASK 14[Total payments for each customer]

SELECT c.*, SUM(p.amount) as totalPayments
FROM Customer c, Lease l, Payment p
WHERE c.customerID = l.customerID AND l.leaseID = p.leaseID
GROUP BY c.customerID;

TASK 15[ Car details for each lease]

SELECT l.*, v.make, v.model 
FROM Lease l, Vehicle v
WHERE l.carID = v.carID;

TASK 16[Active leases on 2023-07-05 with customer and car info]

SELECT l.*, c.firstName, c.lastName, v.make, v.model
FROM Lease l, Customer c, Vehicle v
WHERE l.customerID = c.customerID
AND l.carID = v.carID
AND '2023-07-05' BETWEEN l.startDate AND l.endDate;

TASK 17 [Customer who spent the most]

SELECT c.*, SUM(p.amount) as totalSpent
FROM Customer c, Lease l, Payment p
WHERE c.customerID = l.customerID AND l.leaseID = p.leaseID
GROUP BY c.customerID
ORDER BY totalSpent DESC
LIMIT 1;

TASK 18[All cars with current lease info (on 2023-10-20)]

SELECT v.*, l.leaseID, l.customerID, l.startDate, l.endDate
FROM Vehicle v LEFT JOIN Lease l
ON v.carID = l.carID
AND '2023-10-20' BETWEEN l.startDate AND l.endDate;

