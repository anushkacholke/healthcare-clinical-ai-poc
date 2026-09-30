-- 1. Validate total records in Gold
SELECT COUNT(*) AS total_gold_records
FROM hospital_poc.gold.patient_clinical_summaries;


-- 2. Validate processing status
SELECT
    processing_status,
    COUNT(*) AS record_count
FROM hospital_poc.gold.patient_clinical_summaries
GROUP BY processing_status;


-- 3. Validate records by specialty
SELECT
    specialty,
    COUNT(DISTINCT patient_id) AS patient_count
FROM hospital_poc.gold.patient_clinical_summaries
GROUP BY specialty
ORDER BY patient_count DESC;


-- 4. Validate failed LLM records
SELECT COUNT(*) AS failed_records
FROM hospital_poc.gold.llm_failed_records;


-- 5. Check for duplicate patient IDs in Gold
SELECT
    patient_id,
    COUNT(*) AS record_count
FROM hospital_poc.gold.patient_clinical_summaries
GROUP BY patient_id
HAVING COUNT(*) > 1;