-- =========================
-- 1️⃣ Pulizia
-- =========================
IF OBJECT_ID('Orders', 'U') IS NOT NULL
    DROP TABLE Orders;

-- =========================
-- 2️⃣ Creazione tabelle
-- =========================
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);


-- =========================
-- 3️⃣ Popolamento
-- =========================
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
-- 4️⃣ Query LENTA (molto selettiva)
-- =========================
SET STATISTICS IO, TIME ON;

SELECT SUM(o.Amount)
FROM Orders o
WHERE o.OrderDate = CAST(GETDATE() AS DATE);

SET STATISTICS IO, TIME OFF;

-- =========================
-- 4️⃣ Query ottimizzata con indice suggerito
-- =========================
CREATE NONCLUSTERED INDEX IX_Orders_OrderDate
ON Orders(OrderDate)
INCLUDE (Amount);

SET STATISTICS IO, TIME ON;

SELECT SUM(o.Amount)
FROM Orders o
WHERE o.OrderDate = CAST(GETDATE() AS DATE);

SET STATISTICS IO, TIME OFF;

-- =========================
-- 5️⃣ Pulizia facoltativa
-- Commenta se vuoi conservare le tabelle per esercizi successivi
-- DROP TABLE Orders;
