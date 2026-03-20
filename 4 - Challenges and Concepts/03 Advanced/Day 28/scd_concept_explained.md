# DAY TWENTY EIGHT - **Slowly Changing Dimensions (SCD)**

---
# 📘 What is a Slowly Changing Dimension?

A **Slowly Changing Dimension (SCD)** is a dimension where attribute values change **infrequently** over time.  
Examples include: customer profile, employee details, product attributes, etc.

Typical question SCD solves:  
👉 *When a dimension value changes (e.g., a customer moves to a new city), should we overwrite the old value or keep history?* 

---

# 📘 Types of SCD

Below are the most commonly used SCD types with simple explanations and examples.

---

## **🔹 SCD Type 0 — Retain Original (Fixed Dimension)**

No changes are allowed. Original data is preserved permanently.

**Use case:** Historical facts must always tie to original dimension values.

### **Example:**
### **Existing Table**
| customer_sk | customer_id_nk | full_name | city    | email         |
|-------------|----------------|-----------|---------|---------------|
| 101         | 42             | A. Patel  | `Toronto` | a@domain.com  |

### **Incoming Change**
| customer_id_nk | full_name | city   | email         |
|----------------|-----------|--------|---------------|
| 42             | A. Patel  | `Ottawa` | a@domain.com  |

### **Output (After Load) — No Change**
| customer_sk | customer_id_nk | full_name | city    | email         |
|-------------|----------------|-----------|---------|---------------|
| 101         | 42             | A. Patel  | `Toronto` | a@domain.com  |

---

## **🔹 SCD Type 1 — Overwrite (No History)**

The old value is simply overwritten by the new value.

**Pros:** Simple, minimal storage  
**Cons:** No history maintained

### **Example:** 

### **Existing Table**
| customer_sk | customer_id_nk | full_name | city    | email         |
|-------------|----------------|-----------|---------|---------------|
| 101         | 42             | A. Patel  | `Toronto` | a@domain.com  |

### **Incoming Change**
| customer_id_nk | full_name | city   | email         |
|----------------|-----------|--------|---------------|
| 42             | A. Patel  | `Ottawa` | a@domain.com  |

### **Output (After Load) — Overwrites Old Value**
| customer_sk | customer_id_nk | full_name | city   | email         |
|-------------|----------------|-----------|--------|---------------|
| 101         | 42             | A. Patel  | `Ottawa` | a@domain.com  |

---

## **🔹 SCD Type 2 — Create a New Record (Full History)**

A new row is inserted for every change, maintaining complete historical versions.

Common fields:

- Start Date
- End Date
- Current Flag (Y/N)
- Version Number

**Pros:** Full change history  
**Cons:** Increases table size

**Example:**  
If a customer moves to a new city, the old record is closed (`end_date` set), and a new record is created.

Assume change date = **2025‑02‑14**

### **Existing Table**
| customer_sk | customer_id_nk | full_name | city    | email         | start_date | end_date   | is_current | version |
|-------------|----------------|-----------|---------|---------------|------------|------------|------------|---------|
| 201         | 42             | A. Patel  | `Toronto` | a@domain.com  | `2019-01-01` | `9999-12-31` | `Y`          | `1`       |

### **Incoming Change**
| customer_id_nk | full_name | city   | email         |
|----------------|-----------|--------|---------------|
| 42             | A. Patel  | `Ottawa` | a@domain.com  |

### **Output (After Load) — Old Row Closed, New Row Added**
| customer_sk | customer_id_nk | full_name | city   | email         | start_date | end_date   | is_current | version |
|-------------|----------------|-----------|--------|---------------|------------|------------|------------|---------|
| 201         | 42             | A. Patel  | `Toronto`| a@domain.com  | `2019-01-01` | `2025-02-14` | `N`          | `1`       |
| 345         | 42             | A. Patel  | `Ottawa` | a@domain.com  | `2025-02-14` | `9999-12-31` | `Y`         | `2`       |
---

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day28](https://youtu.be/E5KGunxKNr8)