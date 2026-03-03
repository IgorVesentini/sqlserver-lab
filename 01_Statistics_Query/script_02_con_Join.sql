-- =========================
-- 1️⃣ Pulizia
-- =========================
IF OBJECT_ID('Orders', 'U') IS NOT NULL
    DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL
    DROP TABLE Customers;

-- =========================
-- 2️⃣ Creazione tabelle
-- =========================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

-- =========================
-- 3️⃣ Popolamento
-- =========================
-- 50.000 clienti
INSERT INTO Customers (CustomerID, Name)
SELECT TOP (50000)
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Customer ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10))
FROM sys.objects a
CROSS JOIN sys.objects b;

-- 5.000.000 ordini
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount)
SELECT TOP (5000000)
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    ABS(CHECKSUM(NEWID()) % 50000) + 1,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 2000), GETDATE()),
    CAST(RAND(CHECKSUM(NEWID()))*1000 AS DECIMAL(10,2))
FROM sys.objects a
CROSS JOIN sys.objects b
CROSS JOIN sys.objects c;

-- =========================
-- 4️⃣ Query LENTA senza indice
-- =========================
SET STATISTICS IO, TIME ON;

SELECT c.Name, SUM(o.Amount) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate = CAST(GETDATE() AS DATE)
GROUP BY c.Name;

SET STATISTICS IO, TIME OFF;

-- =========================
-- 5️⃣ Creazione indice ottimizzato
-- =========================
CREATE NONCLUSTERED INDEX IX_Orders_OrderDate_CustomerID
ON Orders(OrderDate, CustomerID)
INCLUDE (Amount);

-- =========================
-- 6️⃣ Query ottimizzata con indice
-- =========================
SET STATISTICS IO, TIME ON;

SELECT c.Name, SUM(o.Amount) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate = CAST(GETDATE() AS DATE)
GROUP BY c.Name;

SET STATISTICS IO, TIME OFF;

-- =========================
-- 7️⃣ Pulizia facoltativa
-- Commenta se vuoi conservare le tabelle per esercizi successivi
-- DROP TABLE Orders;
-- DROP TABLE Customers;