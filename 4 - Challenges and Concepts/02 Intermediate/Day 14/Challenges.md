# DAY FOURTEEN CHALLENGE

## OBJECTIVE 
#### Demonstrate expertise in leveraging SQL date functions and advanced grouping techniques to generate multi‑level revenue insights—including weekday sales patterns and year/quarter/month rollups—to support accurate forecasting and seasonality evaluation.

### Question 1

**Use Case:** Finance and Analytics teams need a unified view of revenue across yearly, quarterly, and monthly levels to identify macro‑level trends, seasonal patterns, and turning points in performance over the past 24 months. The goal is to simplify multi‑granularity analysis without running separate queries.

**Business Impact:** Providing consolidated rollups improves forecasting accuracy, strengthens strategic planning, and supports budget alignment by revealing how revenue shifts across different time horizons. This empowers leadership to spot long‑term patterns, evaluate quarterly momentum, and validate whether month‑over‑month growth aligns with annual objectives.

**Action:** Generate a single, multi‑level revenue summary using SQL GROUPING SETS to efficiently calculate yearly, quarterly, and monthly totals. Share the resulting hierarchical trend view with Finance, highlighting key variances, seasonal inflection points, and areas requiring deeper investigation.

**Sample of Expected Output**

| year_start   | quarter_start | month_start | sales          |
|--------------|---------------|-------------|----------------|
| 2024-01-01   |               |             | 48,654,855.4608 |
| 2025-01-01   |               |             | 22,364,899.7669 |
|              | 2024-01-01    |             | 8,429,799.0179  |
|              | 2024-04-01    |             | 12,220,904.5110 |
|              | 2024-07-01    |             | 14,361,948.2261 |
|              | 2024-10-01    |             | 13,642,203.7058 |
|              | 2025-01-01    |             | 14,356,851.0990 |
|              | 2025-04-01    |             | 8,008,048.6679  |
|              |               | 2024-01-01  | 1,974,430.5009  |
|              |               | 2024-02-01  | 2,629,322.4479  |
``

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day14](https://youtu.be/FUB_NL1eJtU)