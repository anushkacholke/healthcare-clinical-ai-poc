-- ============================================================
-- Hospital Clinical Summarization POC
-- Unity Catalog Setup
-- ============================================================

-- Create catalog
CREATE CATALOG IF NOT EXISTS hospital_poc;

-- Create schemas
CREATE SCHEMA IF NOT EXISTS hospital_poc.bronze;

CREATE SCHEMA IF NOT EXISTS hospital_poc.silver;

CREATE SCHEMA IF NOT EXISTS hospital_poc.gold;

CREATE SCHEMA IF NOT EXISTS hospital_poc.ai;

-- Bronze table
-- Created by notebook: 02_bronze_ingestion

-- Silver tables
-- Created by notebooks:
-- 03_transcript_generation
-- 04_llm_summarization

-- Gold tables
-- Created by notebook:
-- 05_gold_processing

-- AI / Model Service objects
-- Configured through the Databricks UI / Unity Gateway