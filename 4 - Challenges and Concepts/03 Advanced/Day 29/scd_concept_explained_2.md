# DAY TWENTY NINE - **Slowly Changing Dimensions (SCD) CONT'D**

## **🔹 SCD Type 3 — Track Limited Previous History (Partial History)**

Adds new columns to store *previous* values.

**Such as:**  
Columns: `current_city`, `previous_city`

**Pros:** Tracks limited history without adding new rows  
**Cons:** Only one historical value can be tracked

### **Example:**

### **Existing Table**
| customer_sk | customer_id_nk | full_name | current_city | previous_city | email         |
|-------------|----------------|-----------|--------------|---------------|---------------|
| 501         | 42             | A. Patel  | Toronto      | (null)        | a@domain.com  |

### **Incoming Change**
| customer_id_nk | full_name | city   | email         |
|----------------|-----------|--------|---------------|
| 42             | A. Patel  | Ottawa | a@domain.com  |

### **Output (After Load) — Value Shift**
| customer_sk | customer_id_nk | full_name | current_city | previous_city | email         |
|-------------|----------------|-----------|--------------|---------------|---------------|
| 501         | 42             | A. Patel  | Ottawa       | Toronto       | a@domain.com  |

---

## **🔹 SCD Type 4 — History Table (Separate Historical Table)**

Current data stays in the dimension table; historical versions are stored in a **separate history table**.

**Pros:** Cleaner and faster main dimension table  
**Cons:** Requires an additional table

### **Example:**

Assume change date = **2025‑02‑14**

### **Existing Tables**

#### dim_customer_current
| customer_sk | customer_id_nk | full_name | city    | email         |
|-------------|----------------|-----------|---------|---------------|
| 701         | 42             | A. Patel  | Toronto | a@domain.com  |

#### dim_customer_history
| history_id | customer_id_nk | full_name | city    | email         | valid_from | valid_to   |
|------------|----------------|-----------|---------|---------------|------------|------------|
| 1          | 42             | A. Patel  | Toronto | a@domain.com  | 2019-01-01 | 9999-12-31 |

### **Incoming Change**
| customer_id_nk | full_name | city   | email         |
|----------------|-----------|--------|---------------|
| 42             | A. Patel  | Ottawa | a@domain.com  |

### **Output (After Load)**

#### dim_customer_current
| customer_sk | customer_id_nk | full_name | city   | email         |
|-------------|----------------|-----------|--------|---------------|
| 701         | 42             | A. Patel  | Ottawa | a@domain.com  |

#### dim_customer_history
| history_id | customer_id_nk | full_name | city    | email         | valid_from | valid_to   |
|------------|----------------|-----------|---------|---------------|------------|------------|
| 1          | 42             | A. Patel  | Toronto | a@domain.com  | 2019-01-01 | 2025-02-14 |
| 2          | 42             | A. Patel  | Ottawa  | a@domain.com  | 2025-02-14 | 9999-12-31 |

---

## **🔹 SCD Type 5 — Mini‑Dimension + Type 1 (Hybrid)**

Also called **Mini‑Dimension + Type 1 Overwrite** hybrid.

Characteristics:

- Fast‑changing attributes are placed in a **mini‑dimension** (Type 4)  
- Main dimension contains a **foreign key** to the mini‑dimension  
- When attributes change, a **new mini‑dimension row** is created  
- The **main dimension** overwrites the FK with the new mini‑dimension surrogate key (Type 1)  
- Fact tables store both the main dimension key and mini‑dimension key, preserving full history

**Pros:** Maintains historical accuracy via fact table while keeping the main dimension small and fast  
**Cons:** Requires more joins and careful ETL orchestration

### **Example:**

Assume change date = **2025‑02‑14**

### **Existing Tables**

#### customer_profile_dim (mini‑dimension)
| customer_profile_sk | income_band | loyalty_segment |
|---------------------|-------------|-----------------|
| `10`                  | `40–60K`      | `Silver`          |

#### customer_dim (base dimension with FK to mini‑dim)
| customer_sk | customer_id_nk | full_name | customer_profile_sk |
|-------------|----------------|-----------|---------------------|
| 500         | 42             | A. Patel  | `10`                  |

#### (Optional) sales_fact (to show history)
| sale_id | customer_sk | customer_profile_sk | amount |
|---------|-------------|---------------------|--------|
| 9001    | 500         | `10`                  | 100    |

---

### **Incoming Change**
Customer’s profile changes: **income_band = 60–80K**, **loyalty_segment = Gold** (effective **2025‑02‑14**).

---

### **Output (After Load)**

#### Mini‑Dimension: New Row Inserted
| customer_profile_sk | income_band | loyalty_segment |
|---------------------|-------------|-----------------|
| 10                  | 40–60K      | Silver          |
| `11`                  | `60–80K`      | `Gold`            |

#### Base Dimension: FK Overwritten (Type 1)
| customer_sk | customer_id_nk | full_name | customer_profile_sk |
|-------------|----------------|-----------|---------------------|
| 500         | 42             | A. Patel  | `11`                  |

#### (Optional) Facts Preserve History Naturally
Existing facts keep the **old** profile key; new facts use the **new** key.

| sale_id | customer_sk | customer_profile_sk | amount | note                  |
|---------|-------------|---------------------|--------|-----------------------|
| 9001    | 500         | `10`                  | 100    | (before 2025‑02‑14)   |
| 9002    | 500         | `11`                  | 150    | (on/after 2025‑02‑14) |

---

## **🔹 SCD Type 6 — Hybrid (Combination of Type 1, 2, and 3)**

Also called **SCD Type 1 + Type 2 + Type 3** hybrid.

Characteristics:

- New row created (Type 2)
- Current row updated (Type 1)
- Previous value stored in a separate column (Type 3)

**Pros:** Maximum tracking flexibility  
**Cons:** Most complex to maintain

### **Example:**

Assume change date = **2025‑02‑14**

### **Existing Table**
| customer_sk | customer_id_nk | full_name | current_city | previous_city | email         | start_date | end_date   | is_current | version |
|-------------|----------------|-----------|--------------|---------------|---------------|------------|------------|------------|---------|
| 905         | 42             | A. Patel  | `Toronto`      | `(null)`        | a@domain.com  | `2019-01-01` | `9999-12-31` | Y          | 1       |

### **Incoming Change**
| customer_id_nk | full_name | city   | email         |
|----------------|-----------|--------|---------------|
| 42             | A. Patel  | `Ottawa` | a@domain.com  |

### **Output (After Load)**

#### Old Row (Closed)
| customer_sk | customer_id_nk | full_name | current_city | previous_city | email         | start_date | end_date   | is_current | version |
|-------------|----------------|-----------|--------------|---------------|---------------|------------|------------|------------|---------|
| 905         | 42             | A. Patel  | `Toronto`      | `(null)`        | a@domain.com  | `2019-01-01` | `2025-02-14` | `N`          | `1`       |

#### New Row (Current)
| customer_sk | customer_id_nk | full_name | current_city | previous_city | email         | start_date | end_date   | is_current | version |
|-------------|----------------|-----------|--------------|---------------|---------------|------------|------------|------------|---------|
| 906         | 42             | A. Patel  | `Ottawa`       | `Toronto`       | a@domain.com  | `2025-02-14` | `9999-12-31` | `Y`          | `2`       |
---


# 📝 Summary Table

| SCD Type   | Description                               | History Retained? | Method                                                     |
|------------|-------------------------------------------|-------------------|------------------------------------------------------------|
| **Type 0** | Keep original                             | ❌                 | No change                                                  |
| **Type 1** | Overwrite old value                       | ❌                 | Update in place                                            |
| **Type 2** | Add new record                            | ✅ Full            | Insert new row                                             |
| **Type 3** | Keep limited previous values              | ⚠ Partial         | Add extra columns                                          |
| **Type 4** | History in separate table                 | ✅ Full            | Extra history table                                        |
| **Type 5** | Mini‑dimension + Type 1 FK overwrite      | ✅ Full (via facts)| Mini‑dimension (Type 4) + overwrite FK in base (Type 1)   |
| **Type 6** | Hybrid (1+2+3)                            | ✅ Full            | New row + update + previous value column                   |

---

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day29](https://youtu.be/SbW7GP7s0h8)