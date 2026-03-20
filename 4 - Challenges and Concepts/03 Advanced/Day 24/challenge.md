# DAY TWENTY FOUR CHALLENGE

## OBJECTIVE 
#### Produce a reliable, actionable inventory‑to‑sales exception list by detecting products that have never appeared in sales. The solution uses an anti join pattern between production.product and sales.sales_order_detail to surface sellable SKUs with zero demand signals. It standardizes the detection of “no‑sales” products and exposes key product attributes (e.g., name, product_number, color, standard_cost, safety_stock_level, days_to_manufacture) to drive supply, pricing, and merchandising remediation. The output becomes a canonical input for inventory rationalization, assortment governance, and demand activation.

### Question 1

**Use Case:** Merchandising, Supply Chain, and Finance need a single dataset that:

- Lists all products that have not been sold (no matching rows in sales.sales_order_detail).
- Annotates each product with:

    - product_id (as all_products), core descriptors (name, product_number, color),
    - cost and operations signals (standard_cost, safety_stock_level, days_to_manufacture),
    - optional enrichment (e.g., category, lifecycle status, launch date).


- Supports downstream scenarios:

    - Assortment cleanup: identify long‑tail SKUs to retire or bundle.
    - Demand activation: flag no‑sales items for promotions, placement changes, or content fixes.
    - Supply alignment: adjust safety stock and production plans for zero‑demand items.
    - Finance controls: monitor carrying costs and write‑down risk for non‑moving inventory.

**Business Impact:** 
- Revenue Uplift & Margin Protection: Targets unsold items for corrective actions (pricing, promos, cross‑sell), preventing dead inventory and margin erosion.
- Working Capital Efficiency: Reduces excess inventory and carrying costs by aligning supply buffers (safety_stock_level) to true demand.
- Operational Focus: Prioritizes product content fixes (images, descriptions), channel placement, and availability issues that suppress conversion.
- Portfolio Governance: Enforces lifecycle rules (retire or reactivate) and curates a tighter, higher‑velocity catalog.
- Risk & Compliance: Surfaces potential data quality gaps (e.g., products not mapped to a sellable channel) for remediation.

**Action:** Deliver a certified No‑Sales Product dataset based on the anti join with the following components and guarantees:


- Data Contracts / Definitions

    - Universe: All rows from production.product
    - Grain: One row per product_id (deduplicated product dimension).
    - Semantics: “No sales” means no line‑item presence in sales_order_detail within the chosen observation window (default: all history unless a date filter is applied).

- Operationalization

    - Refresh Cadence: Daily (or intra‑day if sales land continuously). Optional incremental logic based on new sales fact partitions.
    - Windowing (Optional but Recommended): Add a parameterized time filter (e.g., last 90/180 days) to define recent no‑sales versus never sold.

- Quality Checks:

    - Join Integrity: Validate that sales_order_detail.product_id is consistently typed and referential to production.product.product_id.
    - SKU Status Filter: Optionally exclude discontinued/retired SKUs from alerts; or classify status buckets (Active, Pre‑launch, Discontinued).


- Enrichments (Recommended):

    - Product category/brand, launch date, lifecycle status, channel availability, MSRP vs current price, inventory on hand, replenishment policy.
    - Derived KPIs: days_since_launch, days_since_last_sale (if historical facts exist), inventory_value (on_hand_qty * standard_cost).


- Delivery:

    - Publish as a certified semantic asset: analytics.no_sales_products for BI (Power BI/Tableau) and downstream automation (Markdown alerts, Ops tickets).
    - Provide a companion dashboard: trend of count of no‑sales SKUs, segmentation by category/brand, and remediation tracking.


- Ownership & SLAs:

    - Domain Owner: Merchandising / Product Management.
    - Data Platform: Data Engineering for pipeline reliability and model hygiene.
    - Finance Partner: Cost validation and inventory accounting impacts.
    - SLA: Daily refresh by 7am local time; data quality alerts on referential breaks.

**Sample of Expected Output**

| all_products | sales_products | sales_product_qty | name                       | product_number | color | safety_stock_level | standard_cost | days_to_manufacture |
|--------------|----------------|--------------------|-----------------------------|----------------|-------|---------------------|----------------|-----------------------|
| 1            |                |                    | Adjustable Race            | AR-5381        |       | 1000                | 0.0000         | 0                     |
| 2            |                |                    | Bearing Ball               | BA-8327        |       | 1000                | 0.0000         | 0                     |
| 3            |                |                    | BB Ball Bearing            | BE-2349        |       | 800                 | 0.0000         | 1                     |
| 4            |                |                    | Headset Ball Bearings      | BE-2908        |       | 800                 | 0.0000         | 0                     |
| 316          |                |                    | Blade                      | BL-2036        |       | 800                 | 0.0000         | 1                     |

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day24](https://youtu.be/dxM2EFuVtcc)