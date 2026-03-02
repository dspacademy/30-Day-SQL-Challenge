# DAY TWO CHALLENGES

## OBJECTIVE
### Learn how to apply essential SQL techniques—such as logical operators (AND vs OR), advanced use of LIKE within WHERE clauses, string functions, and ordering results—to extract meaningful data from multiple tables. This exercise focuses on retrieving employee details based on hire dates, analyzing recent sales orders, and identifying products by keyword search, all while preparing clean, stakeholder-ready outputs.

### Question 1

**Use Case:** Ahead of a security audit, HR and IT require a standardized employee login list for all hires after December 1, 2009. The list should remove legacy domain prefixes to simplify credential verification and be sorted by national ID for consistency and accuracy.

**Business Impact:** Supports access compliance and lowers audit remediation workload.

**Action:** Produce a compliance-ready credential report with standardized login fields.

**Sample of Expected Output**

| employee_id | national_id_number | login_id                | login_id_only | job_title                          | hire_date   |
|-------------|---------------------|-------------------------|---------------|-----------------------------------|------------|
| 54          | 109272464          | dsp-workshop\bonnie0   | bonnie0       | Production Technician - WC10     | 2010-01-01 |
| 273         | 112432117          | dsp-workshop\brian3    | brian3        | Vice President of Sales          | 2011-02-15 |
| 139         | 113393530          | dsp-workshop\hung-fu0  | hung-fu0      | Production Technician - WC20     | 2010-01-06 |
| 290         | 134219713          | dsp-workshop\ranjit0   | ranjit0       | Sales Representative             | 2012-05-30 |
| 281         | 139397894          | dsp-workshop\shu0      | shu0          | Sales Representative             | 2011-05-31 |
``

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform](https://www.youtube.com/@DataSolutionPlatform)


### Question 2

**Use Case:** Sales Operations is validating processing exceptions for specific orders (IDs 45979–45983) and shipments made between April 1–3, 2023 to ensure SLA adherence and correct shipping documentation.

**Business Impact:** Identifies bottlenecks in order fulfillment and improves SLA performance.

**Action:** Prepare a reconciliation extract highlighting order and ship-date filters.

**Sample of Expected Output**

| sales_order_id | revision_number | order_date           | due_date             | ship_date            | status | online_order_flag | purchase_order_number | account_number      | carrier_tracking_number | customer_id | salesperson_id | territory_id | bill_to_address_id | ship_to_address_id | ship_method_id | credit_card_id | credit_card_approval_code | currency_rate_id | subtotal | tax_amt    | freight   | total_due  | comment | rowguid                                 | modified_date        |
|----------------|-----------------|----------------------|----------------------|----------------------|--------|--------------------|------------------------|----------------------|---------------------------|-------------|----------------|--------------|---------------------|---------------------|----------------|----------------|--------------------------------|------------------|---------|-----------|-----------|-----------|---------|------------------------------------------|----------------------|
| 45979          | 10              | 2023-03-25 00:00:00 | 2023-04-06 00:00:00 | 2023-04-01 00:00:00 | 5      | true               | SO45979               |                      | 10-4030-015630            | 15630       |                | 10           | 25673               | 25673               | 1              | 13632          | 731717Vi70655                      | 3664             | 3578.2700| 286.2616  | 89.4568   | 3953.9884 |         | 0a34c728-e604-4865-944b-82f5908fd64a    | 2023-04-01 00:00:00 |
| 45980          | 10              | 2023-03-25 00:00:00 | 2023-04-06 00:00:00 | 2023-04-01 00:00:00 | 5      | true               | SO45980               |                      | 10-4030-015631            | 15631       |                | 10           | 21721               | 21721               | 1              | 16882          | 1231724Vi87522                      | 3664             | 3578.2700| 286.2616  | 89.4568   | 3953.9884 |         | 028733aa-4881-48a6-9ff1-154cab778322    | 2023-04-01 00:00:00 |
| 45981          | 10              | 2023-03-25 00:00:00 | 2023-04-06 00:00:00 | 2023-04-01 00:00:00 | 5      | true               | SO45981               |                      | 10-4030-012805            | 12805       |                | 7            | 15931               | 15931               | 1              | 2779           | 631725Vi14468                       |                  | 3578.2700| 286.2616  | 89.4568   | 3953.9884 |         | 2c650fa1-18dd-43e0-b75a-bde42b37ffc7    | 2023-04-01 00:00:00 |
| 45982          | 10              | 2023-03-25 00:00:00 | 2023-04-06 00:00:00 | 2023-04-01 00:00:00 | 5      | true               | SO45982               |                      | 10-4030-019977            | 19977       |                | 9            | 15349               | 15349               | 1              | 19089          | 1134252Vi99178                      | 3659             | 3578.2700| 286.2616  | 89.4568   | 3953.9884 |         | 8c0aec85-498d-42ed-ba39-d7a77d2f5100    | 2023-04-01 00:00:00 |
| 45983          | 10              | 2023-03-26 00:00:00 | 2023-04-07 00:00:00 | 2023-04-02 00:00:00 | 5      | true               | SO45983               |                      | 10-4030-014830            | 14830       |                | 8            | 11422               | 11422               | 1              | 17464          | 131723Vi90731                       |                  | 3578.2700| 286.2616  | 89.4568   | 3953.9884 |         | 38aa7a41-c44a-4b1b-8930-6cac808e0176    | 2023-04-02 00:00:00 |
``

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform](https://www.youtube.com/@DataSolutionPlatform)


### Question 3

**Use Case:** The Product Manager is curating marketing assets for chain-related components. They need a readable list combining product name and number to feed content systems and ensure consistent messaging.

**Business Impact:** Enhances content consistency and reduces catalog mistakes across channels.

**Action:** Create a curated SKU list with a combined display field for product name and number.

**Sample of Expected Output**

| product_id | name             | product_number | name_product_no              | make_flag | finished_goods_flag | color   | safety_stock_level | reorder_point | standard_cost | list_price |
|------------|------------------|----------------|--------------------------------|-----------|----------------------|---------|---------------------|---------------|---------------|-----------|
| 320        | Chainring Bolts  | CB-2903        | Chainring Bolts \| CB-2903   | false     | false                | Silver  | 1000                | 750           | 0.0000        | 0.0000    |
| 321        | Chainring Nut    | CN-6137        | Chainring Nut \| CN-6137     | false     | false                | Silver  | 1000                | 750           | 0.0000        | 0.0000    |
| 322        | Chainring        | CR-7833        | Chainring \| CR-7833         | false     | false                | Black   | 1000                | 750           | 0.0000        | 0.0000    |
| 324        | Chain Stays      | CS-2812        | Chain Stays \| CS-2812       | true      | false                |         | 1000                | 750           | 0.0000        | 0.0000    |
| 952        | Chain            | CH-0234        | Chain \| CH-0234             | false     | true                 | Silver  | 500                 | 375           | 8.9866        | 20.2400   |

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform](https://www.youtube.com/@DataSolutionPlatform)