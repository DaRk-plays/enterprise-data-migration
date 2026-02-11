# Enterprise Data Migration & Validation Pipeline

![Python](https://img.shields.io/badge/Python-3.11+-blue)
![SQL](https://img.shields.io/badge/SQL-SQLite-green)
![Status](https://img.shields.io/badge/Migration-PASS-success)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

## Overview

This project simulates a real-world **enterprise legacy-to-target data migration** workflow with strict data governance enforcement.

It demonstrates:

- Data profiling & transformation  
- Schema-level integrity constraints  
- Cross-field compliance validation  
- Deterministic deduplication  
- Audit traceability via `run_id`  
- Reconciliation verification  

---

##  Business Objective

When enterprises migrate data from legacy systems, they must ensure:

- No silent data loss  
- No duplicate primary keys  
- No compliance violations  
- No financial integrity issues  

This pipeline enforces all of the above.

---

##  Architecture

<p align="center">
  <img src="images/Arch.png" width="700"/>
</p>

<p align="center">
  <i>End-to-end enterprise migration workflow with validation, audit tracking, and reconciliation enforcement</i>
</p>


---

##  Core Concepts Implemented

### Data Profiling
- Null analysis  
- Duplicate detection  
- Format validation  
- Field distribution checks  

### Cross-Field Business Rules
- ACTIVE accounts require VERIFIED KYC  
- Negative balances rejected  
- Unsupported currencies rejected  
- Latest `last_updated` record wins  

### Schema-Level Enforcement (SQLite)

```sql
PRIMARY KEY (run_id, customer_id)
UNIQUE (run_id, email)
CHECK (balance >= 0)
CHECK (currency IN ('USD','INR'))
```

### Reconciliation Guarantee

Total Raw = Total Clean + Total Rejected

| Metric              | Value |
| ------------------- | ----- |
| Total Raw           | 1050  |
| Clean Loaded        | 96    |
| Rejected (Audit)    | 954   |
| Reconciliation      | PASS  |
| Compliance Checks   | PASS  |
| Financial Integrity | PASS  |

## Project Structure 

```
enterprise-data-migration/
│
├── data/
├── notebooks/
├── reports/
├── sql/
├── README.md
└── requirements.txt
```

## Technologies Used

- **Python**
- **Pandas**
- **SQLite**
- **SQL**
- **Jupyter Notebook**

## How To Run

### Generate Legacy Data
notebooks/00_generate_legacy_data.ipynb

### Profile Data
notebooks/01_data_profiling.ipynb

### Clean & Transform
notebooks/02_clean_transform.ipynb

### Load to SQLite (Schema + Constraints)
notebooks/03_load_to_sqlite.ipynb

### Validate & Reconcile
notebooks/04_validation.ipynb

### Generate Critical Data Quality Report
notebooks/05_generate_critical_report.ipynb

### This project reflects real-world migration systems used in:

- ERP transitions  
- Banking & financial systems  
- Legacy database modernization  
- Data governance & compliance environments  

## Author

**Vedhesh A. S.**  
Master’s in Artificial Intelligence  
Data Engineering & Enterprise Systems Focus

