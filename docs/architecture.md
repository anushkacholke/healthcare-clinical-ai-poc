# Healthcare Clinical AI POC - Architecture

## Overview

This POC implements an end-to-end clinical data processing and
LLM summarization pipeline using Databricks.

The pipeline follows a Medallion Architecture with Bronze, Silver,
and Gold layers. An LLM summarization layer is added between Silver
and Gold.

The final Gold data is used for structured analytics through a
Genie Agent, while the Gold summaries are also exported as Markdown
documents to a Unity Catalog Volume for the Knowledge Assistant use case.

---

## Architecture Flow

```text
                    Synthetic Patient JSON
                             |
                             v
                  +-----------------------+
                  |    Data Profiling     |
                  |  Validation & Checks  |
                  +-----------+-----------+
                              |
                              v
                  +-----------------------+
                  |        BRONZE         |
                  |                       |
                  | patient_notes         |
                  | Raw Patient Data      |
                  +-----------+-----------+
                              |
                              v
                  +-----------------------+
                  |        SILVER         |
                  |                       |
                  | patient_transcripts   |
                  | Standardized Clinical |
                  | Transcripts           |
                  +-----------+-----------+
                              |
                              v
                  +-----------------------+
                  |    LLM SUMMARIZATION  |
                  |                       |
                  | ai_query()            |
                  | GPT OSS 20B           |
                  | Structured JSON       |
                  +-----------+-----------+
                              |
                              v
                  +-----------------------+
                  | Validation & Retry    |
                  |                       |
                  | Empty Response        |
                  | Malformed Response    |
                  | Retry Processing      |
                  +-----------+-----------+
                              |
                              v
                  +-----------------------+
                  |         GOLD          |
                  |                       |
                  | patient_clinical_     |
                  | summaries             |
                  +-----------+-----------+
                              |
                     +--------+--------+
                     |                 |
                     v                 v
             Markdown Documents    Delta Table
                     |                 |
                     v                 v
              Unity Catalog       Genie Agent
                  Volume          Natural Language
                     |                  SQL
                     v                 
           Knowledge Assistant         
          Document-grounded Q&A       