-- ============================================================
-- Project  : Longitudinal IGRA Dynamics & TB Risk Stratification
-- Tool     : Google BigQuery
-- Dataset  : tb_case.case_study
-- Author   : Saloni Prasad
-- Purpose  : Data cleaning, BMI categorization, and
--            risk factor cross-tabulation by outcome group
-- ============================================================


-- ============================================================
-- STEP 1: Clean column headers, standardise gender casing,
--         and compute BMI categories
-- ============================================================

WITH Cleaned_Cohort AS (
  SELECT
    Baseline                        AS baseline_id,
    AGE,
    UPPER(GENDER)                   AS gender,
    HT                              AS height_cm,
    WT                              AS weight_kg,
    ROUND(BMI, 2)                   AS bmi,

    -- BMI Category Classification (WHO Standard)
    CASE
      WHEN BMI < 18.5               THEN 'Underweight'
      WHEN BMI BETWEEN 18.5 AND 24.9 THEN 'Normal'
      WHEN BMI BETWEEN 25.0 AND 29.9 THEN 'Overweight'
      ELSE                               'Obese'
    END                             AS bmi_category,

    `Baseline IGRA `                AS Baseline_IGRA,
    `Month24 IGRA`                  AS Month24_IGRA,
    `BCG VACCINATION`               AS BCG_VACCINATION,
    SMOKING,
    `DIABETES STATUS`               AS DIABETES_STATUS,
    `TB STATUS`                     AS TB_STATUS,
    OUTCOME,
    `IFN-GAMMA-UNS`                 AS IFN_GAMMA_UNS,
    `IFN-GAMMA-C+E`                 AS IFN_GAMMA_C_E,
    REGION

  FROM `lively-wonder-492613-e6.tb_case.case_study`
),


-- ============================================================
-- STEP 2: Risk Factor Cross-Tabulation for Outcome Stratification
--         Aggregates key clinical and lifestyle metrics per
--         outcome group to identify high-risk cohort patterns
-- ============================================================

Risk_Stratification AS (
  SELECT
    OUTCOME,
    COUNT(baseline_id)                                          AS total_subjects,
    ROUND(AVG(AGE), 1)                                          AS avg_age,
    ROUND(AVG(bmi), 2)                                          AS avg_bmi,
    SUM(CASE WHEN DIABETES_STATUS = TRUE THEN 1 ELSE 0 END)     AS diabetic_count,
    SUM(CASE WHEN SMOKING        = TRUE THEN 1 ELSE 0 END)      AS smoker_count,
    SUM(CASE WHEN TB_STATUS      = 'Active' THEN 1 ELSE 0 END)  AS active_tb_cases,
    ROUND(AVG(IFN_GAMMA_C_E), 2)                                AS avg_ifn_gamma_ce
  FROM Cleaned_Cohort
  GROUP BY OUTCOME
)

-- ============================================================
-- FINAL OUTPUT: Ordered by disease severity (Active TB cases desc)
-- ============================================================

SELECT *
FROM Risk_Stratification
ORDER BY
  active_tb_cases DESC,
  total_subjects  DESC;


-- ============================================================
-- EXPECTED RESULTS:
-- Row | OUTCOME         | total | avg_age | avg_bmi | diabetic | smokers | active_tb | avg_ifn_ce
--  1  | PROGRESSOR      |   15  |  31.0   |  21.55  |    15    |    15   |    14     |  610.78
--  2  | NON-CONVERTER   |   67  |  28.8   |  21.84  |    47    |    33   |     0     |  538.10
--  3  | NON-PROGRESSOR  |   41  |  36.9   |  23.55  |    31    |    41   |     0     |  650.23
--  4  | REVERTER        |   15  |  28.5   |  21.94  |    12    |     0   |     0     |  619.45
--  5  | CONVERTER       |   11  |  29.7   |  22.95  |     8    |    11   |     0     |  424.94
-- ============================================================
