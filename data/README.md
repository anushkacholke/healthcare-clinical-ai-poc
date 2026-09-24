# Dataset

This directory contains the sample input data used for the
Healthcare Clinical AI POC.

## Dataset Description

The POC uses a synthetic patient clinical-notes dataset
containing patient records in JSON format.

Each patient record contains the following main fields:

- `id` - Unique patient/record identifier
- `version` - Dataset/note version
- `specialty` - Medical specialty
- `length` - Clinical note length category
- `note` - Clinical/discharge note containing patient information

The `note` field contains clinical sections such as:

- Patient Name
- Age/Sex
- UHID
- Admission No
- Address
- Admission Date
- Discharge Date
- Treating Consultant
- Chief Complaints
- History of Present Illness
- Past History
- Physical Examination
- Investigations
- Diagnosis
- Course in Hospital
- Socio-Economic Status
- Traditional Medicine History
- Condition at Discharge
- Advice on Discharge

## Data Usage in the POC

The dataset is processed through the following pipeline:

Raw JSON
   ↓
Data Profiling
   ↓
Bronze Delta Table
   ↓
Clinical Transcript Generation
   ↓
Silver Delta Table
   ↓
LLM Summarization
   ↓
Gold Delta Table

## Dataset Location

The full dataset is uploaded to a Databricks Unity Catalog
Volume and is used as the input source for the Databricks
pipeline.
