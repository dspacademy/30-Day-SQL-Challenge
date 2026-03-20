# ⭐ Recursive SQL Query

A **recursive query** is a SQL query that **references itself** in order to handle hierarchical or tree‑structured data.

It allows SQL to walk through parent‑child relationships (such as org charts, folder trees, or category structures) until no more levels exist.

Recursive queries are written using a **Recursive CTE (Common Table Expression)**.

---

# Recursive Queries Use cases

Use recursive queries when your data has **multiple unknown levels**, such as:

- Organizational charts  
- Category → Subcategory → Sub‑Subcategory  
- Folder structures  
- Department hierarchies  
- Bill of materials (BOM)

They work where normal self‑joins fail because a self‑join requires you to know the number of levels in advance.

---

# Syntax of a Recursive CTE (ANSI SQL)

```sql
WITH RECURSIVE cte_name AS (
    -- 1. Anchor member (starting point)
    SELECT ...
    FROM ...
    WHERE ...   -- usually the root node

    UNION ALL

    -- 2. Recursive member (references the CTE itself)
    SELECT ...
    FROM ...
    JOIN cte_name ON ...   -- links each level to the next
)
SELECT *
FROM cte_name;

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day22/Part1](https://youtu.be/1d4BzkwEDsI)