## Database Domains

The database is organized into four primary domains:

### 1. Production
Manages product design, manufacturing, and inventory-related structures.

### 2. Sales
Handles customer transactions, orders, currencies, and payment methods.

### 3. Human Resources
Tracks employees, departments, work shifts, and compensation history.

### 4. Person
Stores individuals and their associated addresses.

---

## Summary of Tables by Domain

### Person Domain

| Table Name       | Description |
|-----------------|-------------|
| Person          | One record per individual (customer, employee, vendor). |
| Address         | One record per physical address. |
| Address Type    | Defines address categories (e.g., billing, shipping). |

---

### Production Domain

| Table Name            | Description |
|----------------------|-------------|
| Product Category     | High-level product grouping. |
| Product Subcategory  | Segmentation under each category. |
| Product              | Detailed SKU-level information. |
| Location             | Manufacturing or storage sites. |
| Scrap Reason         | Reasons for product disposal. |

---

### Sales Domain

| Table Name             | Description |
|-----------------------|-------------|
| Customer              | One record per customer account. |
| Sales Order Header    | Order-level details (dates, totals, shipping). |
| Sales Order Detail    | Line-item specifics (product, quantity, pricing). |
| Currency              | Supported currencies. |
| Currency Rate         | Exchange rates by date. |
| Credit Card           | Payment method details. |

---

### Human Resources Domain

| Table Name                     | Description |
|-------------------------------|-------------|
| Employee                      | One record per employee. |
| Department                    | Organizational units. |
| Shift                         | Work shifts. |
| Employee Department History   | Department assignments over time. |
| Employee Pay History          | Compensation changes over time. |
