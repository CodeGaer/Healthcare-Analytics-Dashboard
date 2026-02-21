/* =========================================================
   Healthcare Analytics Database Setup
   Author: Shubham Pathak
   Description: Schema creation and feature engineering for
   healthcare analytics dashboard (Power BI)
   ========================================================= */

-- ===============================
-- 1. Create Database
-- ===============================
CREATE DATABASE hospital_analytics;
USE hospital_analytics;

-- ===============================
-- 2. Create Raw Patient Table
-- ===============================
CREATE TABLE hospital_raw (
    patient_id INT PRIMARY KEY,
    patient_age INT,
    patient_city VARCHAR(100),
    diseases VARCHAR(100),
    appointment_date DATE,
    assigned_doctor VARCHAR(100),
    gender VARCHAR(20),
    bmi FLOAT,
    blood_pressure INT,
    cholesterol_level INT,
    blood_sugar_level INT,
    bmi_category VARCHAR(30),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(150),
    phone_number BIGINT,
    blood_group VARCHAR(10),
    height INT,
    payment_status VARCHAR(30)
);

-- ===============================
-- 3. Basic Aggregations
-- ===============================

-- Gender distribution
SELECT gender, COUNT(*) AS total_patients
FROM hospital_raw
GROUP BY gender
ORDER BY total_patients DESC;

-- BMI category distribution
SELECT bmi_category, COUNT(*) AS total_patients
FROM hospital_raw
GROUP BY bmi_category
ORDER BY total_patients DESC;

-- ===============================
-- 4. Age Group Feature
-- ===============================
ALTER TABLE hospital_raw
ADD COLUMN age_group VARCHAR(20);

UPDATE hospital_raw
SET age_group = CASE
    WHEN patient_age < 18 THEN 'Child'
    WHEN patient_age BETWEEN 18 AND 55 THEN 'Adult'
    WHEN patient_age BETWEEN 56 AND 80 THEN 'Senior Citizen'
    ELSE 'Senior Citizen'
END;

-- Age group distribution
SELECT age_group, COUNT(*) AS patients
FROM hospital_raw
GROUP BY age_group
ORDER BY patients DESC;

-- ===============================
-- 5. Health Risk Feature
-- ===============================
ALTER TABLE hospital_raw
ADD COLUMN health_risk VARCHAR(20);

UPDATE hospital_raw
SET health_risk = CASE
    WHEN bmi_category = 'Obese' AND blood_pressure > 140 THEN
