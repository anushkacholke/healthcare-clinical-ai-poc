````markdown
# Genie Agent

## Overview

The Genie Agent enables natural-language querying of structured clinical data stored in the Gold Delta table.

## Data Source

```text
hospital_poc.gold.patient_clinical_summaries
````

The table contains successfully processed clinical summaries with patient diagnoses, medications, investigations, vitals/examination, hospital course, discharge condition, next steps, and clinical summary.

## Configuration

The Genie Agent was configured with:

* Table and column descriptions
* Column synonyms
* Query instructions
* Example SQL queries
* Common questions

## Example Questions

* How many unique patients are in the dataset?
* How many patients are there in each specialty?
* Which patients have hypertension documented?
* Which patients have ischemic stroke documented?
* Show the diagnoses and medications for patient 1.

## Example SQL

```sql
SELECT
    specialty,
    COUNT(DISTINCT patient_id) AS patient_count
FROM hospital_poc.gold.patient_clinical_summaries
GROUP BY specialty
ORDER BY patient_count DESC;
```

## Result

Users can ask questions in natural language, and the Genie Agent generates SQL queries against the Gold table and returns the corresponding results.
