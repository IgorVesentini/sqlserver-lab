# Esercizio 01 - Attivazione statistiche in query

## Obiettivo
Imparare a comprendere le statistiche e identificare i colli di bottiglia di una query.

## Passi
1. Esegui la query lenta senza indici (`SELECT ... FROM Customers JOIN Orders ...`) nel DB di sviluppo.
2. Opzionale: attiva "Includi piano di esecuzione effettivo" (SSMS); questo punto non è affrontato in questa lezione
3. Abilita le statistiche:
   ```sql
   SET STATISTICS IO, TIME ON;

4. Osserva:

- Scan count, logical reads, physical reads e tempi di esecuzione

- Nel piano di esecuzione: operatori principali nel piano: Clustered Scan, NonClustered Scan, Nested Loop, Hash Match, Key Lookup

5. Creazione di un indice mirato, ad esempio:

CREATE NONCLUSTERED INDEX IX_Orders_OrderDate_CustomerID
ON Orders(OrderDate, CustomerID)
INCLUDE (Amount);

6. Riesegui la query ottimizzata e confronta:

- Modifica statistiche con riduzione di I/O e tempo

- Cambiamenti nel piano

