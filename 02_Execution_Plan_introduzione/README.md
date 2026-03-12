# 02_Execution_Plan_fondamenti

## 🔹 Obiettivo della lezione
Fornire una panoramica generale dell'**Execution Plan** in SQL Server Management Studio (SSMS), comprendendo:

- Cos'è il Query Optimizer
- Cos'è un Execution Plan e il suo scopo
- Differenza tra Estimated e Actual Execution Plan
- Come attivare i piani in SSMS
- Concetti di flusso dei dati e costi stimati
- Piccolo assaggio di lettura del piano (senza entrare negli operatori dettagliati)

---

## 🔹 Contenuti della lezione
| File | Descrizione |
|------|------------|
| `script_01_execution_plan.sql` | Creazione tabella Orders con popolamento dati, query di esempio, drop finale. Utile per osservare Estimated e Actual Plan |
| `esercizio.md` | Istruzioni passo passo per attivare il piano stimato e quello reale, confrontare costi e flusso dei dati |
| `note.md` | Glossario dei concetti chiave: Query Optimizer, Execution Plan, Estimated vs Actual Plan, flusso dei dati, scopo del piano, costi stimati |

---

## 🔹 Passaggi principali
1. Eseguire lo **script di esempio** `script_01_execution_plan.sql` in SSMS.
2. Attivare il **Estimated Execution Plan** (`Ctrl + L`) e osservare:
   - Struttura generale
   - Costi stimati
   - Flusso dei dati
3. Attivare il **Actual Execution Plan** (`Ctrl + M`) ed eseguire la query:
   - Confrontare righe stimate vs righe reali
   - Confrontare costi stimati vs dati effettivi
4. Osservare che:
   - Il piano mostra la strategia scelta dal Query Optimizer
   - Flusso dei dati: destra → sinistra e basso → alto per aggregazioni
5. Terminare lo script con la **drop table** per pulizia dell’ambiente.

---

## 🔹 Concetti chiave da ricordare
- **Query Optimizer** → sceglie la strategia migliore per eseguire una query
- **Execution Plan** → rappresentazione visiva della strategia del motore
- **Estimated vs Actual Plan** → stimato senza esecuzione vs reale con esecuzione
- **Flusso dei dati** → destra → sinistra, basso → alto (per aggregazioni)
- **Costo stimato** → percentuale indicativa dell’operatore rispetto al piano totale
- **Scopo dell’Execution Plan** → capire come SQL Server esegue la query, identificare colli di bottiglia, valutare se indici/statistiche/riscrittura query possono aiutare

---

## 🔹 Script di esempio consigliato
Lo script `script_01_execution_plan.sql` dovrebbe creare una tabella simile a `Orders`, popolarla con dati casuali e permettere di eseguire una query semplice per vedere i piani stimato e reale. Alla fine il drop table per pulizia dell’ambiente.

---

## 🔹 Riferimenti ufficiali (Microsoft Learn)
- [Estimated Execution Plan](https://learn.microsoft.com/en-us/sql/relational-databases/performance/display-the-estimated-execution-plan?view=sql-server-ver17)
- [Actual Execution Plan](https://learn.microsoft.com/en-us/sql/relational-databases/performance/display-an-actual-execution-plan?view=sql-server-ver17)