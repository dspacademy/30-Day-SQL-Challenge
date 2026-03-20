# DAY THIRTY CHALLENGE

# OBJECTIVE
Produce a unified, accurate, and analytically consistent representation of employee tenure by department and across all departments. The solution calculates both **department‑level tenure** and **total organizational tenure** using date‑based deltas anchored on Gregorian‑accurate year length (365.2425). It standardizes how HR, Workforce Planning, and People Analytics quantify time-in-role and overall service, eliminating inconsistent calculations across systems. The dataset becomes a foundational input for workforce lifecycle reporting, organizational design analysis, promotion readiness assessments, and compliance‑oriented tenure metrics.

---

# Question 1

## Use Case
HR, Workforce Analytics, and Business Teams need a single dataset that:

- Reports **employee departmental tenure** for each assignment (start_date → end_date or current_date).
- Provides **total tenure across all departments**, even when employees move between teams or have multiple assignment histories.
- Presents contextual metadata:
  - `employee_id`, `department_id`
  - department `name`, `group_name`
  - `start_date`, `end_date`
  - `years_diff_per_department` (individual stint duration)
  - `total_years_diff_all_department` (full organizational span)

- Supports downstream scenarios:
  - **Organizational Design / Mobility:** Track departmental movement patterns, internal mobility velocity, and tenure distribution across business units.
  - **Talent Management:** Identify employees approaching promotion readiness, service awards, or leadership pipelines based on cumulative organizational tenure.
  - **Workforce Planning:** Analyze turnover risk, backfill forecasts, and departmental stability through tenure patterns.
  - **Compliance & HR Policy:** Standardize calculations for union rules, benefits eligibility, seniority accrual, and statutory reporting.
  - **Employee Lifecycle Insights:** Compare departmental stint lengths to identify teams with high churn or high retention.

---

## Business Impact
- **Workforce Stability Insights:** Gives leadership visibility into tenure patterns, highlighting departments with high churn or strong retention—driving targeted interventions.
- **Improved Talent Decisions:** Provides reliable tenure calculations for identifying promotion candidates, long-tenured high performers, or employees in accelerated mobility patterns.
- **Data Standardization & Auditability:** Eliminates inconsistent tenure logic across HR systems, enabling unified reporting for compensation cycles, PTO accrual rules, and compliance audits.
- **Operational Efficiency:** Reduces manual reconciliation of tenure across multiple assignment records, accelerating analytics and reducing errors.
- **Risk Reduction:** Ensures correct seniority/benefit eligibility calculations, minimizing payroll disputes, compliance exposure, and grievances.
- **Strategic Workforce Planning:** Enables scenario planning for retirements, backfill timing, and mobility‑driven org structure improvements.

---

## Action
Deliver a certified **Employee Department Tenure** dataset using the following components and guarantees:

### Data Contracts / Definitions
- **Universe:** All records from `humanresources.employee_department_history`
- **Grain:** One row per employee per departmental assignment.
- **Semantics:**
  - `years_diff_per_department` = precise departmental tenure for each stint.
  - `total_years_diff_all_department` = earliest start to latest end across all departments for the employee (continuous organizational span).
  - `end_date` NULLs interpreted as current employment (`COALESCE(end_date, CURRENT_DATE)`).
  - Year denominator = **365.2425 days**, aligned to Gregorian calendar for accurate seniority calculations.

### Operationalization
- **Refresh cadence:** Daily to reflect new assignment changes, transfers, or end dates.
- **Optional parameterization:**
  - Filters for active employees
  - Departmental cohorts
  - Effective-dated history slices (e.g., last 12 months)

### Quality Checks
- Validate assignment continuity for employees with multiple stints.
- Ensure referential integrity between department_history and department dimension.
- Detect anomalous records (e.g., `end_date < start_date`, overlapping stints).
- Standardize date types and handle NULL end_dates consistently.

### Enrichments (Recommended)
- Employee attributes: `job_title`, `manager`, `hire_date`, `FTE` status
- Derivatives:
  - `days_in_role`
  - `average_tenure_per_department`
  - `number_of_departments_moved`
  - `mobility_type` classification (vertical, lateral, cross‑functional)

### Delivery
- Publish as a certified semantic asset:  
  `analytics.employee_department_tenure`
- Provide a companion dashboard:
  - Tenure distributions
  - Cross‑department mobility flows
  - Retention hotspots
  - Role/department tenure benchmarking charts

### Ownership & SLAs
- **Domain Owner:** HR / People Analytics
- **Data Platform:** Data Engineering
- **People Operations:** Validation for seniority and policy alignment
- **SLA:** Daily refresh by 7am; automated data-quality alerting on date anomalies or history breaks

**Sample of Expected Output**

| employee_id | department_id | name                     | group_name                                 | start_date | end_date | years_diff_per_department | total_years_diff_all_department |
|-------------|----------------|--------------------------|---------------------------------------------|------------|----------|----------------------------|----------------------------------|
| 1           | 16             | Executive                | Executive General and Administration        | 2009-01-14 |          | 17.0845                    | 17.0845                          |
| 2           | 1              | Engineering              | Research and Development                    | 2008-01-31 |          | 18.0401                    | 18.0401                          |
| 3           | 1              | Engineering              | Research and Development                    | 2007-11-11 |          | 18.2618                    | 18.2618                          |
| 4           | 1              | Engineering              | Research and Development                    | 2007-12-05 | 2010-05-30 | 2.4833                   | 18.1961                          |
| 4           | 2              | Tool Design              | Research and Development                    | 2010-05-31 |          | 15.7101                    | 18.1961                          |
| 5           | 1              | Engineering              | Research and Development                    | 2008-01-06 |          | 18.1085                    | 18.1085                          |
| 6           | 1              | Engineering              | Research and Development                    | 2008-01-24 |          | 18.0592                    | 18.0592                          |
| 7           | 6              | Research and Development | Research and Development                    | 2009-02-08 |          | 17.0161                    | 17.0161                          |
| 8           | 6              | Research and Development | Research and Development                    | 2008-12-29 |          | 17.1283                    | 17.1283                          |
| 9           | 6              | Research and Development | Research and Development                    | 2009-01-16 |          | 17.0791                    | 17.0791                          |

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/FinalDayChallenge](https://youtu.be/iMU42qfH8T4)