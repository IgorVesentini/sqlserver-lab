# Esercizio 02_Execution_Plan_introduzione

## Obiettivo
Osservare Estimated e Actual Execution Plan in SSMS e confrontare:

- Costi stimati
- Righe stimate vs righe effettive
- Flusso dei dati

---

## Passaggi

1. Apri SSMS e seleziona il database `tempdb` (o un altro a piacere).

2. Esegui lo script `script_01_execution_plan.sql` riga per riga o in blocco.  
   Nota: la tabella `Orders` sarà popolata con 5.000.000 di righe casuali.

3. Attiva il **Estimated Execution Plan** (Ctrl + L) prima di eseguire la query.

   Esegui la query seguente:  
```
       SELECT *
       FROM Orders
       WHERE CustomerID = 42;
```
4. Osserva nel piano stimato:

   - Struttura generale del piano
   - Costi stimati percentuali di ciascun operatore
   - Flusso dei dati (destra -> sinistra)

5. Attiva il **Actual Execution Plan** (Ctrl + M) ed esegui di nuovo la query:

   - Confronta righe stimate vs righe effettive
   - Confronta costi stimati vs dati reali
   - Osserva come il flusso rimane simile, ma ora vedi anche le metriche reali

6. Facoltativo: modifica la query o il filtro, riesegui e osserva come cambia il piano.

7. Pulizia facoltativa dell’ambiente:

       -- DROP TABLE Orders;