# DAY TWENTY FIVE - WINDOW FUNCTIONS

## 1) What is a window function?

A **window function** performs a calculation across a set of rows that are **related to the current row**, called the **window**.  
Unlike `GROUP BY` aggregates, window functions **do not collapse rows**—they return one result **per input row**.

**Common use cases:** running totals, moving averages, rank ordering, and previous/next row comparisons.

---

## 2) Canonical ANSI-SQL Syntax

```sql
<window_function> OVER (
  [ {PARTITION | PARTITION BY} partition_expression [, ...] ]
  [ ORDER BY sort_expression [ASC|DESC] [NULLS FIRST|LAST] [, ...] ]
  [ { RANGE | ROWS | GROUPS } frame_start_or_between ]
  [ EXCLUDE { CURRENT ROW | GROUP | TIES | NO OTHERS } ]
);
```
### Window function syntax in details
```sql
function_name ([expression [, expression ... ]]) [ FILTER ( WHERE filter_clause ) ] OVER window_name
function_name ([expression [, expression ... ]]) [ FILTER ( WHERE filter_clause ) ] OVER ( window_definition )
function_name ( * ) [ FILTER ( WHERE filter_clause ) ] OVER window_name
function_name ( * ) [ FILTER ( WHERE filter_clause ) ] OVER ( window_definition )
```
#### window_definition syntax
```sql
[ existing_window_name ]
[ PARTITION BY expression [, ...] ]
[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
[ frame_clause ]
```

#### frame_clause
```sql
{ RANGE | ROWS | GROUPS } frame_start [ frame_exclusion ]
{ RANGE | ROWS | GROUPS } BETWEEN frame_start AND frame_end [ frame_exclusion ]
```

#### frame_start and frame_end syntax
```sql
UNBOUNDED PRECEDING
offset PRECEDING
CURRENT ROW
offset FOLLOWING
UNBOUNDED FOLLOWING
```
#### frame_exclusion
```sql
EXCLUDE CURRENT ROW
EXCLUDE GROUP
EXCLUDE TIES
EXCLUDE NO OTHERS
```

### Explanation of clauses

- **`OVER`** — declares a window.
- **`PARTITION BY`** — resets the window for each group.
- **`ORDER BY`** — defines the logical row order for calculations.
- **Frame clause (`ROWS`, `RANGE`, `GROUPS`)** — defines the subset of rows relative to the current row.
- **`EXCLUDE`** — exclude specific rows within a frame (advanced).

### Named windows

```sql
SELECT
  order_id,
  SUM(amount) OVER w AS run_total,
  AVG(amount) OVER w AS run_avg
FROM t
WINDOW w AS (
  PARTITION BY customer_id
  ORDER BY order_date
  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
);
```

---

## 3) Window Frames Explained

### Frame types
- **ROWS** — based on physical row counts.
- **RANGE** — based on value range of the ORDER BY column(s).
- **GROUPS** — based on peer groups (rows tied on ORDER BY).

### Default frame rules (varies by database)
- Aggregate window functions often default to  
  `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`.
  
- Ranking/offset functions ignore frame clauses but require valid ordering.

### Recommendation  
Use **ROWS** for deterministic running totals.

---

## 4) Categories of Window Functions

### A) Ranking & Row Numbering

Functions:
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `PERCENT_RANK()`
- `CUME_DIST()`

---

### B) Offset (Previous/Next) — Navigation Functions

Functions:
- `LAG(expr, offset, default)`
- `LEAD(expr, offset, default)`
- `NTH_VALUE(expr, n)`

---

### C) Positional Functions (First/Last Value)

Functions:
- `FIRST_VALUE(expr)`
- `LAST_VALUE(expr)`

**Note:** Without explicit frame, `LAST_VALUE` often returns just the current row.

---

### D) Aggregation (Windowed Aggregates)

Functions:
- `SUM`
- `AVG`
- `MIN`
- `MAX`
- `COUNT`

### E) Percentiles & Quantiles

Functions:
- `NTILE(n)`
- `PERCENTILE_CONT`
- `PERCENTILE_DISC`
- Approximate percentile functions (engine-dependent)

---

### F) Statistical Window Functions

Functions (engine-dependent):
- `STDDEV_SAMP`, `STDDEV_POP`
- `VAR_SAMP`, `VAR_POP`
- `CORR`, `COVAR_SAMP`

---

## 5) Dialect Differences Summary

- **PostgreSQL**: Most complete; supports `FILTER`, `EXCLUDE`, `GROUPS`, `PERCENTILE_CONT`.
- **SQL Server**: No FILTER; no EXCLUDE; strong ranking support.
- **Snowflake**: Has QUALIFY; strong analytic support.
- **BigQuery**: Also supports QUALIFY; percentile functions differ in syntax.
- **Oracle**: Very advanced; supports all percentile functions.
- **SQLite**: Basic window functions since 3.25; limited advanced features.

---

## 6) Common Pitfalls & Best Practices

1. Always specify `ORDER BY` for meaningful ranking/offset logic.  
2. Explicitly define frame for `LAST_VALUE`.  
3. Prefer `ROWS` over `RANGE` for deterministic running totals.  
4. Add tie-breakers to ORDER BY for stable ranking.  
5. Be careful with NTILE bucket sizes.  
6. Avoid `DISTINCT` inside window aggregate when unsupported.

---

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day25/Part1](https://youtu.be/JiPMHO5xjPY)