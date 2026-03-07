# DAY ELEVEN CHALLENGE

## OBJECTIVE 
### Show proficiency in applying SQL CASE logic to categorize shipments as On Time, Late, or Not Shipped for SLA analysis

### Question 1

**Use Case:** Logistics needs to classify orders as On Time, Late, or Not Shipped to monitor SLA adherence and drive operational improvements.

**Business Impact:** Reduces late shipments and strengthens customer satisfaction.

**Action:** Produce a compliance dashboard with shipment status breakdown.

**Sample of Expected Output**

| sales_order_id | order_date             | due_date               | ship_date              | days_diff | ship_status | ship_status_2 |
|----------------|-------------------------|-------------------------|-------------------------|-----------|-------------|---------------|
| 63365          | 2024-12-31 00:00:00     | 2025-01-12 00:00:00     | 2025-01-07 00:00:00     | -5 days   | On Time     | On Time       |
| 63366          | 2024-12-31 00:00:00     | 2025-01-12 00:00:00     | 2025-01-07 00:00:00     | -5 days   | On Time     | On Time       |
| 63363          | 2024-12-31 00:00:00     | 2025-01-12 00:00:00     | 2025-01-07 00:00:00     | -5 days   | On Time     | On Time       |
| 63364          | 2024-12-31 00:00:00     | 2025-01-12 00:00:00     | 2025-01-07 00:00:00     | -5 days   | On Time     | On Time       |
| 63367          | 2024-12-31 00:00:00     | 2025-01-12 00:00:00     | 2025-01-07 00:00:00     | -5 days   | On Time     | On Time       |

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day11](https://youtu.be/aLk8d2QFKQ4)