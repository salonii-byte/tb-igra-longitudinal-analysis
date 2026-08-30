# 📋 Findings Summary — TB Longitudinal IGRA Cohort Study

**Study Duration:** 24 months  
**Cohort Size:** 149 subjects  
**IGRA Timepoints:** Baseline, Month 6, Month 12, Month 18, Month 24  

---

## A. Outcome Trajectory Categorization

| Outcome Group | N | % | Description |
|---------------|---|---|-------------|
| NON-CONVERTER | 67 | 45.0% | Consistently IGRA-negative across all 5 timepoints |
| NON-PROGRESSOR | 41 | 27.5% | Persistently IGRA-positive — no active disease developed |
| PROGRESSOR | 15 | 10.1% | IGRA-positive → converted to Active TB |
| REVERTER | 15 | 10.1% | IGRA-positive at baseline → reverted to negative by Month 6 |
| CONVERTER | 11 | 7.4% | IGRA-negative → converted to positive during follow-up |

---

## B. High-Risk Multiplier Identification

- **100% Co-occurrence in Progressors:** Every single patient (15/15) who progressed to the PROGRESSOR state was both a smoker and diabetic.
- 14 out of 15 PROGRESSOR patients developed Active TB — representing **93.3% of all Active TB cases** in the cohort.
- Patients with dual comorbidities (Diabetes + Smoking) have the highest vulnerability to transitioning from Latent IGRA positivity to Active TB.

---

## C. Immunological Biomarker Patterns (IFN-GAMMA-C+E)

| Outcome Group | Mean IFN-GAMMA-C+E (pg/mL) |
|---------------|---------------------------|
| NON-PROGRESSOR | 650.23 |
| REVERTER | 619.45 |
| PROGRESSOR | 610.78 |
| NON-CONVERTER | 538.10 |
| CONVERTER | 424.94 |

**Key Insight:** Persistently infected and progressing individuals exhibit significantly elevated stimulated Interferon-Gamma release compared to recent converters, reflecting sustained T-cell antigen stimulation. The clinical risk threshold is IFN-GAMMA-C+E > 600 pg/mL.

---

## D. Geographic Distribution

- Urban: N = 77 (51.7%)
- Rural: N = 72 (48.3%)
- Cases are near-evenly distributed across Urban and Rural regions.

---

## E. Public Health Recommendations

### 1. Targeted Screening for High-Risk Comorbidities
Establish mandatory latent TB screening for all diabetic patients and active smokers, given the 100% progression rate observed in this dual-comorbidity subgroup.

### 2. Early TB Preventive Treatment (TPT) Rollout
Scale short-course TPT regimens — specifically **3HP (weekly isoniazid + rifapentine for 3 months)** — for individuals identified as IGRA-positive or Converters before active symptoms develop.

### 3. Biomarker-Guided Monitoring
Use elevated stimulated IFN-GAMMA-C+E levels (> 600 pg/mL) alongside IGRA positivity as a risk threshold for prioritizing patients for close clinical follow-up.

### 4. Community & Lifestyle Support Programs
Integrate **smoking cessation** and **glycemic control** initiatives into primary healthcare services to address the key underlying drivers of TB progression.

---

## F. Interview Talking Points

### Executive Pitch
*"I conducted a 24-month longitudinal cohort study on 149 subjects tracking IGRA diagnostic dynamics across 5 blood collection visits. By cleaning and processing the dataset using Python and SQL, and visualizing the trajectories in Tableau, I identified key clinical markers that predict progression from Latent to Active Tuberculosis."*

### On Data Processing
- Pivoted multi-timepoint blood collection data across Months 0–24 to construct a dynamic trajectory matrix.
- Engineered composite comorbidity features combining Diabetes status, Smoking history, and BMI to segment patient risk profiles.

### On Analytical Findings
- Found that Diabetes and Smoking act as synergistic risk drivers — 100% of progressors in the cohort suffered from both comorbidities.
- Observed that while NON-PROGRESSORS and PROGRESSORS both maintain high stimulated IFN-GAMMA levels (> 600 pg/mL), the presence of metabolic and respiratory comorbidities is the decisive factor driving actual progression to Active TB.

### On Recommendations
- **Targeted Screening:** Mandatory Latent TB screening for diabetic smokers in high-burden regions.
- **Early TPT Deployment:** Initiate short-course 3HP treatment immediately upon IGRA conversion.
- **Biomarker-Guided Triage:** Use IFN-GAMMA-C+E > 600 pg/mL as a secondary filter to prioritize high-risk patients.
