# 01_Statistics_Query

## 🔹 Obiettivo della lezione
Imparare a comprendere le statistiche di esecuzione di SQL Server (`SET STATISTICS IO, TIME`) e come ottimizzare query tramite indici mirati.

Questa lezione è “minimale”: parte da una tabella `Orders` e prosegue con un join su `Customers`, mostrando come cambiano **Scan count**, **Logical reads**, **Physical reads** e tempi di esecuzione pre e post indice.

---

## 🔹 Contenuti della lezione
| File | Descrizione |
|------|------------|
| `script_01_minimale.sql` | Creazione tabella Orders, popolamento, query lenta e ottimizzata con indice, statistiche pre/post |
| `script_02_con_Join.sql` | Introduzione della tabella Customers, query JOIN e indice su Orders per ridurre lettura e costi |
| `esercizio.md` | Istruzioni passo passo per eseguire le query, attivare le statistiche e confrontare i risultati |
| `note.md` | Concetti chiave: Scan count, Logical/Physical reads, Clustered/Nonclustered index, Index Seek/Scan, INCLUDE, impatto sugli aggiornamenti, join e differenze su Customers |

---

## 🔹 Passaggi principali
1. Eseguire le query senza indice e osservare statistiche e tempi.
2. Creare indici mirati su `Orders`:
   - Prima solo tabella singola (`script_01_minimale.sql`)
   - Poi join con `Customers` (`script_02_con_Join.sql`)
3. Rieseguire le query e confrontare statistiche:
   - Riduzione Scan count e Logical reads
   - Index Seek vs Index Scan
   - Tempi CPU e totale più bassi
4. Analizzare l’impatto dell’indice INCLUDE su colonne lette (SUM, JOIN) senza tornare alla tabella originale.

---

## 🔹 Concetti chiave da ricordare
- **SET STATISTICS IO, TIME** → monitoraggio pagine lette e tempi CPU/elapsed  
- **Scan count** → numero di accessi logici all’oggetto; non significa lettura completa della tabella  
- **Logical reads / Physical reads** → pagine in memoria vs da disco  
- **Clustered vs Nonclustered Index** → ordinamento fisico e tabella ridotta ordinata per chiavi  
- **INCLUDE** → colonne aggiunte nell’indice per evitare Key Lookup  
- **Index Seek / Scan / Table Scan** → accesso mirato vs lettura completa  
- **Aggiornamenti indice** → INSERT/UPDATE/DELETE aggiornano anche l’indice; possibile frammentazione  

- **Join Orders + Customers** → indice su Orders sufficiente, Customers con PK già ottimizzata, no indice extra necessario  

---

## 🔹 Riferimenti ufficiali Microsoft Learn
- [SET STATISTICS IO](https://learn.microsoft.com/en-us/sql/t-sql/statements/set-statistics-io-transact-sql)  
- [SET STATISTICS TIME](https://learn.microsoft.com/en-us/sql/t-sql/statements/set-statistics-time-transact-sql)  

---

## 🔹 Prossimo passo consigliato
Dopo aver completato questa lezione, il prossimo modulo può essere **02_Execution_Plan_operatori_base**, per approfondire:
- Index Seek / Scan / Table Scan
- Clustered / Nonclustered Index
- Key Lookup
- Lettura di righe reali vs stimate
- Impatto sugli operatori di base nel piano di esecuzione