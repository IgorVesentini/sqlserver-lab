# Note 01 - Statistics IO, TIME ON/OFF - "MINIMALE" (tb unica)

## 1️⃣ SET STATISTICS IO, TIME ON/OFF

- `SET STATISTICS IO ON` → mostra **quanto lavoro in memoria e su disco** ha fatto SQL Server per ciascuna tabella/indice  
- `SET STATISTICS TIME ON` → mostra **tempo CPU e tempo totale** della query  
- `OFF` → disabilita le statistiche dopo l’analisi  

---

## 2️⃣ Scan count

- Indica **quante scansioni logiche dell’oggetto** SQL Server ha fatto per soddisfare la query  
- ⚠️ Non significa “scansionare tutta la tabella” letteralmente  
- Serve a capire quante volte il motore ha letto l’indice o la tabella  
- Nel nostro esempio senza indice → Scan count >1 perché SQL Server divide il lavoro in **batch paralleli** per leggere tutte le righe  

---

## 3️⃣ Logical reads vs Physical reads

- **Logical reads** = numero di pagine da 8 KB lette **in memoria (buffer pool)**  
- **Physical reads** = pagine lette da disco → succede la prima volta se la cache è vuota  
- Le query ottimizzate leggono **meno logical reads** → più veloce  

---

## 4️⃣ Clustered index vs Nonclustered index

- **Clustered index** = ordina fisicamente le righe della tabella secondo la chiave (qui `OrderID`)  
- La tabella ha sempre un solo clustered index (di default creato dalla PK)  
- **Nonclustered index** = tabella ridotta ordinata per le colonne chiave dell’indice  

---

## 5️⃣ Index Key vs INCLUDE

- **Colonne ON (chiave)** → ordinate nell’indice, usate per **filtro, join, ordinamento**  
  - Default ordinamento = ASC  
- **Colonne INCLUDE** → solo dati coperti nell’indice, **evitano Key Lookup** sulla tabella originale  
- Nel nostro esempio:  
  ```sql
  CREATE NONCLUSTERED INDEX IX_Orders_OrderDate
  ON Orders(OrderDate)
  INCLUDE (Amount);

- OrderDate = chiave → filtro mirato (WHERE)

- Amount = include → SUM calcolata senza tornare alla tabella

## 6️⃣ Index Seek vs Index Scan / Table Scan

| Tipo | Cosa fa | Quando succede |
|------|---------|----------------|
| **Index Seek** | Accesso mirato, legge solo le righe necessarie | Filtro su colonna chiave dell’indice |
| **Index Scan** | Legge tutte le pagine dell’indice | Filtro su colonna non chiave o range molto grande |
| **Table Scan** | Legge tutta la tabella | Nessun indice utile presente |

- **Index Seek** = ottimale → logical reads basse, query veloce  
- **Index Scan / Table Scan** → più lento, legge più pagine  

---

## 7️⃣ Aggiornamenti e manutenzione indice

- INSERT/UPDATE/DELETE → aggiornano anche l’indice  
- Gli indici possono diventare **fragmented** → REORGANIZE / REBUILD per compattare  
- INCLUDE non influisce sull’ordinamento, ma viene aggiornato insieme alle chiavi quando necessario  

---

## 8️⃣ Piano di esecuzione - note di base

- Per ora è sufficiente notare come SQL Server cambi il piano
  - La prima estrazione utilizza Index Scan e suggerisce appunto la creazione dell'indice ON/INCLUDE
  - La seconda estrazione utilizza Index Seek

---

💡 **Sintesi concettuale**:

> Creando un indice mirato sulle colonne usate nei filtri e includendo le colonne lette nell’indice, SQL Server può usare **Index Seek**, leggere **solo le pagine necessarie**, ridurre **logical reads**, evitare Key Lookup e calcolare velocemente aggregazioni come SUM.

# Note 02 - Statistics IO, TIME ON/OFF - "JOIN" (due tabelle)

## Join Orders + Customers - Differenze STATISTICS

### Effetto dell'indice su Orders
- Anche in questo caso, l'indice `IX_Orders_OrderDate_CustomerID INCLUDE (Amount)` ha questi effetti:
  - permette **Index Seek su Orders** → lettura mirata delle righe richieste
  - riduce **Scan count e logical reads**
  - evita Key Lookup su Amount grazie a INCLUDE

### Necessità indice su Customers
- Customers ha già **Primary Key su CustomerID** → SQL Server può fare **Index Seek** per la join senza altri indici
- Logical reads su Customers sono già basse
- ✅ Conclusione: **non serve creare ulteriori indici su Customers** per questa query

💡 Sintesi: aggiungendo un indice mirato sulle colonne filtrate e di join su Orders, SQL Server riduce drasticamente lettura di pagine e tempi di esecuzione, mentre la tabella Customers può rimanere così com’è.