# Note 02_Execution_Plan_fondamenti

## Concetti chiave

- **Query Optimizer**  
  Motore di SQL Server che decide la strategia più efficiente per eseguire una query.  
  Considera più piani possibili e sceglie quello con **costo stimato più basso**.

- **Execution Plan**  
  Rappresentazione visiva della strategia di esecuzione scelta dal motore.  
  Mostra operatori e flusso dei dati. Serve a capire **come SQL Server legge i dati**.

- **Estimated Execution Plan**  
  Piano stimato senza eseguire la query.  
  Mostra righe e costi stimati, ma **non i tempi reali**.

- **Actual Execution Plan**  
  Piano reale dopo l’esecuzione della query.  
  Mostra righe effettive, tempi reali e costi reali per ciascun operatore.

- **Flusso dei dati**  
  Nei piani grafici SSMS i dati scorrono di solito **da destra verso sinistra** e **dal basso verso l’alto** per aggregazioni.  
  Serve come guida visiva, anche senza conoscere ancora i dettagli degli operatori.

- **Costo stimato (%)**  
  Percentuale indicativa dell’operatore rispetto al costo totale del piano.  
  Non è un tempo reale, ma aiuta a capire quali operazioni sono più “pesanti”.

- **Scopo dell’Execution Plan**  
  - Comprendere come SQL Server esegue la query  
  - Identificare colli di bottiglia  
  - Valutare se servono indici, statistiche aggiornate o riscritture di query

---

## Consigli pratici

- In SSMS, attivare sempre almeno l’**Actual Plan** per vedere metriche reali.  
- Con tabelle grandi (milioni di righe), osserva prima **flusso e costi stimati**.  
- Non preoccuparti se il piano sembra complesso: per questa lezione interessa **solo la struttura generale**.  
- Piccolo trucco: puoi **zoomare** sul piano SSMS o usare il pannello “Properties” per vedere valori dettagliati senza confusione.

---

## Riferimenti Microsoft Learn

- Estimated Execution Plan:  
  https://learn.microsoft.com/en-us/sql/relational-databases/performance/display-the-estimated-execution-plan?view=sql-server-ver17

- Actual Execution Plan:  
  https://learn.microsoft.com/en-us/sql/relational-databases/performance/display-an-actual-execution-plan?view=sql-server-ver17