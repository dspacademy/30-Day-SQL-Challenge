
# DAY TWELVE CHALLENGE

## OBJECTIVE 
### Demonstrate mastery in using SQL functions such as NULLIF, COALESCE, and calculated expressions to reliably generate discount metrics, compute net pricing, and standardize missing data fields, ensuring a complete and analysis‑ready sales dataset.

### Question 1

**Use Case:** Sales analytics needs a reliable way to compute effective line‑item discount rates while preventing divide‑by‑zero errors, and they want to ensure customer records always contain an email by providing a fallback value. They also require a standardized placeholder when order comments are missing so downstream reporting remains consistent.

**Business Impact:** Improve accuracy in discount analysis and ensures complete contact data for communications. Improves the accuracy and safety of discount‑related metrics by preventing null or zero‑value errors and ensures complete customer and order‑level data. Standardized email and comment fields eliminate reporting gaps and support cleaner dashboards, communication workflows, and data exports.

**Action:** Deliver an enriched transactional dataset with safe discount metrics.

**Sample of Expected Output**

| sales_order_id | order_date             | customer_id | email_address                         | product_id | unit_price | unit_price_discount | net_unit_price | discount_rate | comment_updated |
|----------------|------------------------|-------------|----------------------------------------|------------|------------|----------------------|----------------|---------------|-----------------|
| 75123          | 2025-06-29 00:00:00    | 18759       | devin38@datasolutionsplatform.com      | 878        | 21.9800    | 0.0000               | 21.98000000    |               | no_comment      |
| 75123          | 2025-06-29 00:00:00    | 18759       | devin38@datasolutionsplatform.com      | 879        | 159.0000   | 0.0000               | 159.00000000   |               | no_comment      |
| 75123          | 2025-06-29 00:00:00    | 18759       | devin38@datasolutionsplatform.com      | 712        | 8.9900     | 0.0000               | 8.99000000     |               | no_comment      |
| 75122          | 2025-06-29 00:00:00    | 15868       | caleb25@datasolutionsplatform.com      | 878        | 21.9800    | 0.0000               | 21.98000000    |               | no_comment      |
| 75122          | 2025-06-29 00:00:00    | 15868       | caleb25@datasolutionsplatform.com      | 712        | 8.9900     | 0.0000               | 8.99000000     |               | no_comment      |
``


📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day12](https://youtu.be/I_1AC3-9R88)