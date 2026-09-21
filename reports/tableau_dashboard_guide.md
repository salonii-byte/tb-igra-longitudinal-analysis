# 📊 Tableau Dashboard Blueprint: TB IGRA Longitudinal Analysis

> 🔗 **Live Dashboard:** [View on Tableau Public](https://public.tableau.com/app/profile/saloni.prasad3289/viz/TB_17851023282600/Dashboard1)

This guide provides step-by-step instructions for building and configuring the clinical dashboard in **Tableau Desktop** or **Tableau Public** using `data/processed/processed_tb_cohort_analysis.csv`.

---

## 1. Data Source Setup

1. Open Tableau and select **Text file** as the connection.
2. Select `processed_tb_cohort_analysis.csv` from your `data/processed/` folder.
3. Verify data types:
   - `Baseline`, `Month-6`, `Month-12`, `Month- 18`, `Month-24`: **String**
   - `Baseline IGRA`, `Month-6 IGRA`, `Month-12 IGRA`, `Month- 18 IGRA`, `Month24 IGRA`: **String**
   - `AGE`, `HT`, `WT`, `BMI`, `IFN-GAMMA-UNS`, `IFN-GAMMA-C+E`, `IFN_GAMMA_DELTA`: **Number (decimal / whole)**
   - `GENDER`, `BCG VACCINATION`, `OUTCOME`, `SMOKING`, `STATUS`, `DIABETES STATUS`, `REGION`, `BMI_CATEGORY`: **String**

---

## 2. Calculated Fields to Create

Create the following calculated fields in Tableau (`Analysis` → `Create Calculated Field`):

### A. Outcome High-Risk Flag
```tableau
IF [OUTCOME] = "PROGRESSOR" THEN "High Risk (Progressor)"
ELSEIF [OUTCOME] = "CONVERTER" THEN "Moderate Risk (Converter)"
ELSE "Stable / Low Risk"
END
```

### B. Comorbidity Cluster
```tableau
IF [SMOKING] = "Yes" AND [DIABETES STATUS] = "Yes" THEN "Smoking + Diabetes"
ELSEIF [SMOKING] = "Yes" AND [DIABETES STATUS] = "No" THEN "Smoking Only"
ELSEIF [SMOKING] = "No" AND [DIABETES STATUS] = "Yes" THEN "Diabetes Only"
ELSE "Neither"
END
```

### C. Active TB Flag
```tableau
IF [STATUS] = "Active" THEN 1 ELSE 0 END
```

---

## 3. Sheet Specifications

### 🔹 Sheet 1: Longitudinal IGRA Trajectory Matrix (Heatmap / Text Table)
- **Purpose:** Visualize IGRA test conversions and reversions over the 24-month study period across outcome cohorts.
- **Rows:** `OUTCOME`, `Baseline` (Subject ID)
- **Columns:** Measure Names or pivoted timepoints (`Baseline IGRA`, `Month-6 IGRA`, `Month-12 IGRA`, `Month- 18 IGRA`, `Month24 IGRA`)
- **Marks Card:** Square / Text
- **Color:** `IGRA Status` (Green = `NEGATIVE`, Red = `POSITIVE`, Gray = `INDETERMINATE`)
- **Tooltip:** Include `Subject ID`, `Outcome`, `TB Status`, `Region`.

---

### 🔹 Sheet 2: Age vs. IFN-Gamma Delta by BMI Category (Scatter Plot)
- **Purpose:** Explore immune response magnitude across demographics and BMI classes.
- **Columns (X-axis):** `AGE` (Dimension, continuous)
- **Rows (Y-axis):** `IFN_GAMMA_DELTA` (continuous)
- **Detail:** `Baseline` (Subject ID)
- **Color:** `BMI_CATEGORY` (4 distinct categorical colors)
- **Shape:** `STATUS` (Circle for `Latent`, Cross/Star for `Active`)
- **Reference Line:** Add a constant reference line at `Y = 0` (dashed line, "Delta Baseline").

---

### 🔹 Sheet 3: Outcome vs. Comorbidity Breakdown (Stacked Bar Chart)
- **Purpose:** Highlight that 100% of progressors have both smoking and diabetes.
- **Rows:** `OUTCOME`
- **Columns:** `CNT(Baseline)` (Count of patients)
- **Color:** `Comorbidity Cluster`
- **Label:** `CNT(Baseline)` with `% of Total along Outcome`
- **Sorting:** Sort `OUTCOME` descending by count.

---

### 🔹 Sheet 4: Biomarker IFN-Gamma (Unstimulated vs Stimulated) by Outcome (Grouped Bar / Boxplot)
- **Purpose:** Compare baseline unstimulated vs. antigen-stimulated interferon gamma levels.
- **Columns:** `OUTCOME`
- **Rows:** Measure Values (`AVG(IFN-GAMMA-UNS)` and `AVG(IFN-GAMMA-C+E)`)
- **Marks:** Bar (Side-by-side)
- **Color:** Measure Names

---

## 4. Dashboard Layout & Interactivity

1. **Canvas Size:** Fixed `1366 × 768` (Standard 16:9 Laptop/Desktop)
2. **Layout Structure:**
   - **Header:** Title *"Longitudinal TB IGRA Immune Profiling & Risk Stratification"* with KPI banner cards (Total Cohort: 149, Active Cases: 14, Progressors: 15, % Diabetes in Progressors: 100%).
   - **Top Left:** Sheet 1 (Trajectory Matrix)
   - **Top Right:** Sheet 3 (Comorbidity Breakdown)
   - **Bottom Left:** Sheet 2 (Age vs. IFN-Gamma Delta)
   - **Bottom Right:** Sheet 4 (Biomarker Comparison)
3. **Interactive Filters (Right Sidebar or Top Bar):**
   - `REGION` (Urban / Rural dropdown)
   - `STATUS` (Active / Latent)
   - `BMI_CATEGORY` (Multiple select)
   - `SMOKING` & `DIABETES STATUS` (Yes / No)
4. **Dashboard Actions:**
   - Add **Filter Action**: Clicking an Outcome in Sheet 3 filters all other 3 sheets.
