# DAY TWENTY THREE CHALLENGE

## OBJECTIVE 
#### Produce a reliable, hierarchical view of the organization by traversing leader–employee relationships with a Self Join. The solution builds level depth and a readable role path (e.g., VP > Director > Manager > IC), enabling end‑to‑end org visualization, manager subtree analysis, and role‑based rollups. It standardizes hierarchy construction (root detection via leader_id IS NULL) and prevents level gaps by iteratively joining children to parents until exhaustion, yielding an analysis‑ready org structure for HR, Finance, and Operations.

### Question 1

**Use Case:** HR, Finance, and Business Operations need a single hierarchical dataset that:

- Starts from top-level leaders (leader_id IS NULL) and expands down to all employees.
- Annotates each node with:

    - leader_id, leader_title (the node’s immediate leader at the point of expansion),
    - employee_id, job_title,
    - path (ordered breadcrumb of titles from the root to each employee).


- Supports downstream scenarios:

    - Org charts and headcount reporting by level.
    - Span of control (direct vs. total reports) and managerial depth.
    - Subtree queries (all reports under a given leader).
    - Role path analytics (common management chains, depth distributions).

**Business Impact:** 
- Transparency & Governance: Establishes a single source of truth for the chain of command, reducing ambiguity in approvals, routing, and role accountability.
- Managerial Effectiveness: Quantifies span of control and hierarchy depth, informing reorgs, coaching, and leadership load balancing.
- Workforce Planning: Enables departmental and cross-functional rollups by level and leader, improving budgeting (comp, backfills) and capacity planning.
- Operational Efficiency: Improves routing of tickets, onboarding flows, and access control by deriving the correct manager and escalation path programmatically.
- Reporting & Compliance: Supports audits and policy enforcement where manager verification and reporting lines are required.

**Action:** Deliver a certified Org Hierarchy dataset based on the self join with the following components and guarantees:

- Data Contracts / Definitions:

    - Root(s): leader_id IS NULL
    - Path: Deterministic title sequence; use consistent separator (' > ').
    - Hierarchy Integrity: Each row’s leader_id should match some employee_id in the same result set unless it is root.

- Operationalization:

    1. Refresh cadence: Daily full refresh; optionally incremental if hires/manager changes stream in near‑real time.
    2. Quality checks:

        - Cycle defense: Add a safeguard filter (e.g., ID path containment) if source can contain loops.
        - Orphan detection: Surface employees whose leader_id is missing from the set (data hygiene).
        - Tree completeness: Validate that every non‑root has exactly one leader and that all nodes are reachable from a root.

    3. Enrichments (optional but recommended):

        - Attach department, location, FTE status, cost center for richer rollups.
        - Compute direct_reports_count and total_reports_count via secondary aggregations.

    4. Delivery: Publish as a certified semantic layer/table: analytics.hr_org_hierarchy for BI (Power BI/Tableau) and downstream data products (access provisioning, onboarding workflows).

    5. Ownership & SLAs: HR Data as domain owner; Data Engineering for pipeline reliability; Access Management for downstream authorization mappings.

**Sample of Expected Output**

| employee_id | employee_title                     | lead_1_id | lead_1_title                | lead_2_id | lead_2_title                | lead_3_id | lead_3_title                | lead_4_id | lead_4_title | lead_5_id | lead_5_title | org_chart_asc                                                                                                                                      | org_chart_desc                                                                                                                                                                |
|-------------|-------------------------------------|-----------|------------------------------|-----------|------------------------------|-----------|------------------------------|-----------|--------------|-----------|--------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1           | Chief Executive Officer             |           |                              |           |                              |           |                              |           |              |           |              | Chief Executive Officer &gt;  &gt;  &gt;  &gt;  &gt;                                             |  &gt;  &gt;  &gt;  &gt;  &gt; Chief Executive Officer                                                                                                 |
| 2           | Vice President of Engineering       | 1         | Chief Executive Officer       |           |                              |           |                              |           |              |           |              | Vice President of Engineering &gt; Chief Executive Officer &gt;  &gt;  &gt;  &gt;                   |  &gt;  &gt;  &gt;  &gt; Chief Executive Officer &gt; Vice President of Engineering                                                                         |
| 3           | Engineering Manager                 | 2         | Vice President of Engineering | 1         | Chief Executive Officer       |           |                              |           |              |           |              | Engineering Manager &gt; Vice President of Engineering &gt; Chief Executive Officer &gt;  &gt;  &gt; |  &gt;  &gt;  &gt; Chief Executive Officer &gt; Vice President of Engineering &gt; Engineering Manager                                          |
| 4           | Senior Tool Designer                | 3         | Engineering Manager           | 2         | Vice President of Engineering | 1         | Chief Executive Officer       |           |              |           |              | Senior Tool Designer &gt; Engineering Manager &gt; Vice President of Engineering &gt; Chief Executive Officer &gt;  &gt;            |  &gt;  &gt; Chief Executive Officer &gt; Vice President of Engineering &gt; Engineering Manager &gt; Senior Tool Designer                                |
| 5           | Design Engineer                     | 3         | Engineering Manager           | 2         | Vice President of Engineering | 1         | Chief Executive Officer       |           |              |           |              | Design Engineer &gt; Engineering Manager &gt; Vice President of Engineering &gt; Chief Executive Officer &gt;  &gt;               |  &gt;  &gt; Chief Executive Officer &gt; Vice President of Engineering &gt; Engineering Manager &gt; Design Engineer                                   |
| 6           | Design Engineer                     | 3         | Engineering Manager           | 2         | Vice President of Engineering | 1         | Chief Executive Officer       |           |              |           |              | Design Engineer &gt; Engineering Manager &gt; Vice President of Engineering &gt; Chief Executive Officer &gt;  &gt;               |  &gt;  &gt; Chief Executive Officer &gt; Vice President of Engineering &gt; Engineering Manager &gt; Design Engineer                                   |
| 7           | Research and Development Manager    | 3         | Engineering Manager           | 2         | Vice President of Engineering | 1         | Chief Executive Officer       |           |              |           |              | Research and Development Manager &gt; Engineering Manager &gt; Vice President of Engineering &gt; Chief Executive Officer &gt;  &gt; |  &gt;  &gt; Chief Executive Officer &gt; Vice President of Engineering &gt; Engineering Manager &gt; Research and Development Manager                    |
| 8           | Research and Development Engineer   | 4         | Senior Tool Designer          | 3         | Engineering Manager           | 2         | Vice President of Engineering | 1         | Chief Executive Officer |           |              | Research and Development Engineer &gt; Senior Tool Designer &gt; Engineering Manager &gt; Vice President of Engineering &gt; Chief Executive Officer |  &gt; Chief Executive Officer &gt; Vice President of Engineering &gt; Engineering Manager &gt; Senior Tool Designer &gt; Research and Development Engineer |
| 9           | Research and Development Engineer   | 4         | Senior Tool Designer          | 3         | Engineering Manager           | 2         | Vice President of Engineering | 1         | Chief Executive Officer |           |              | Research and Development Engineer &gt; Senior Tool Designer &gt; Engineering Manager &gt; Vice President of Engineering &gt; Chief Executive Officer |  &gt; Chief Executive Officer &gt; Vice President of Engineering &gt; Engineering Manager &gt; Senior Tool Designer &gt; Research and Development Engineer |
| 10          | Research and Development Manager    | 4         | Senior Tool Designer          | 3         | Engineering Manager           | 2         | Vice President of Engineering | 1         | Chief Executive Officer |           |              | Research and Development Manager &gt; Senior Tool Designer &gt; Engineering Manager &gt; Vice President of Engineering &gt; Chief Executive Officer |  &gt; Chief Executive Officer &gt; Vice President of Engineering &gt; Engineering Manager &gt; Senior Tool Designer &gt; Research and Development Manager |

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day23](https://youtu.be/z4E-Cs-z0Tk)