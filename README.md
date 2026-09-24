# Healthcare Clinical AI POC

A Databricks-based healthcare data engineering and GenAI Proof of Concept (POC) for processing synthetic patient clinical notes, generating structured clinical transcripts, producing AI-powered clinical summaries, and enabling natural-language access through Knowledge Assistant and Genie Agent.

---

## Overview

This POC demonstrates an end-to-end healthcare data pipeline using Databricks.

The pipeline takes synthetic patient clinical notes in JSON format and processes them through a Medallion Architecture:

```text
Raw Patient JSON
       │
       ▼
┌─────────────────────┐
│      BRONZE         │
│  Data Ingestion     │
│  & Preparation      │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│      SILVER         │
│ Transcript           │
│ Generation           │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│    AI GATEWAY       │
│       + LLM         │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│       GOLD          │
│ Clinical Summaries  │
└──────────┬──────────┘
           │
       ┌───┴────┐
       ▼        ▼
 Knowledge     Genie
 Assistant     Agent
````

---

## POC Objectives

The main objectives of this POC are:

* Ingest synthetic patient JSON data into Databricks.
* Validate and prepare patient records.
* Store source data as Delta tables in Unity Catalog.
* Generate narrative clinical transcripts.
* Store transcripts in the Silver layer.
* Connect an LLM through Databricks AI Gateway.
* Generate concise clinical summaries using `ai_query()`.
* Store generated summaries in the Gold layer.
* Enable document-grounded Q&A using Knowledge Assistant.
* Enable natural-language SQL analysis using Genie Agent.

---

## Architecture

The POC follows a Medallion-style architecture.

### 1. Bronze Layer

The Bronze layer contains the ingested patient data with minimal transformation.

```text
Patient JSON
     │
     ▼
Databricks
     │
     ▼
Unity Catalog Volume
     │
     ▼
Bronze Delta Table
```

Bronze table:

```text
hospital_poc.bronze.patient_notes
```

Example columns:

```text
id
version
specialty
length
note
ingested_at
source_file
```

The original clinical note is retained for traceability.

---

### 2. Silver Layer

The Silver layer extracts relevant information from the clinical notes and creates a narrative clinical transcript.

```text
Bronze Patient Note
        │
        ▼
Section Extraction
        │
        ├── Patient Information
        ├── Chief Complaints
        ├── HPI
        ├── Past History
        ├── Physical Examination
        ├── Investigations
        ├── Diagnosis
        ├── Course in Hospital
        ├── Condition at Discharge
        └── Advice on Discharge
        │
        ▼
Narrative Transcript
        │
        ▼
Silver Delta Table
```

Silver table:

```text
hospital_poc.silver.patient_transcripts
```

Example columns:

```text
patient_id
specialty
patient_name
age_sex
uhid
admission_no
admission_date
discharge_date
treating_consultant
chief_complaints
hpi
past_history
physical_examination
investigations
diagnosis
course_in_hospital
condition_at_discharge
advice_on_discharge
transcript
created_at
```

---

### 3. AI Gateway and LLM

The Silver transcript will be passed to an LLM through Databricks AI Gateway.

```text
Silver Transcript
       │
       ▼
   AI Gateway
       │
       ▼
      LLM
       │
       ▼
Clinical Summary
```
---

### 4. Gold Layer

The Gold layer stores the final AI-generated clinical summary together with the original transcript for traceability.

```text
Silver Transcript
       │
       ▼
      LLM
       │
       ▼
Generated Summary
       │
       ▼
Gold Delta Table
```

The Gold layer will contain information such as:

```text
patient_id
original_transcript
generated_summary
generated_at
```

---

### 5. Knowledge Assistant

Generated clinical summaries will be exported as documents such as:

```text
.md
.txt
```

These documents can be stored in a Unity Catalog Volume and used by Knowledge Assistant for document-grounded questions.

---

### 6. Genie Agent

Genie Agent will be used to interact with structured Delta tables using natural language.

Example questions:

```text
How many patients are in the oncology specialty?

How many patients have a particular diagnosis?

Show the number of patients by specialty.
```

Genie can translate natural-language questions into SQL queries against the available tables.

---

# Pipeline Flow

The complete pipeline is:

```text
Synthetic Patient JSON
          │
          ▼
    Data Profiling
          │
          ▼
   Data Ingestion
          │
          ▼
        BRONZE
          │
          │ Extract clinical sections
          ▼
       Transcript
          │
          ▼
        SILVER
          │
          │ Clinical transcript
          ▼
     AI Gateway
          │
          ▼
         LLM
          │
          │ ai_query()
          ▼
   Clinical Summary
          │
          ▼
        GOLD
          │
      ┌───┴────┐
      ▼        ▼
 Knowledge    Genie
 Assistant    Agent
```

---

# Technologies

The POC uses the following technologies:

* **Databricks**
* **Unity Catalog**
* **Delta Lake**
* **PySpark**
* **Python**
* **SQL**
* **Databricks AI Gateway**
* **LLM**
* **`ai_query()`**
* **Knowledge Assistant**
* **Genie Agent**

---

# Dataset

The POC uses a synthetic healthcare patient dataset.

The working dataset currently contains:

```text
1,000 patient records
```

The dataset contains multiple medical specialties, including:

```text
Oncology
General Medicine
Neurology
Cardiology
Pediatrics
```

The clinical note contains information such as:

```text
Patient Information
Admission Information
Chief Complaints
History of Present Illness
Past History
Physical Examination
Investigations
Diagnosis
Course in Hospital
Discharge Condition
Discharge Advice
```

> The complete dataset is not stored in this GitHub repository.
> The data is uploaded to a Databricks Unity Catalog Volume for processing.
---

# Author

**Anushka Cholke**

---