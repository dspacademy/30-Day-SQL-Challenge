# DAY TWENTY TWO CHALLENGE

## OBJECTIVE 
#### Produce a reliable, hierarchical view of the organization by traversing leader–employee relationships with a recursive CTE. The solution builds level depth and a readable role path (e.g., VP > Director > Manager > IC), enabling end‑to‑end org visualization, manager subtree analysis, and role‑based rollups. It standardizes hierarchy construction (root detection via leader_id IS NULL) and prevents level gaps by iteratively joining children to parents until exhaustion, yielding an analysis‑ready org structure for HR, Finance, and Operations.

### Question 1

**Use Case:** HR, Finance, and Business Operations need a single hierarchical dataset that:

- Starts from top-level leaders (leader_id IS NULL) and recursively expands down to all employees.
- Annotates each node with:

    - leader_id, leader_title (the node’s immediate leader at the point of expansion),
    - employee_id, job_title,
    - level (0 = top/exec; increases by layer),
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

**Action:** Deliver a certified Org Hierarchy dataset based on the recursive CTE with the following components and guarantees:

- Fields (per row):

    - leader_id (immediate parent of the current node in that step)
    - leader_title
    - employee_id
    - job_title
    - level (depth from the root leader)
    - path (title breadcrumb from root to node; e.g., Chief Executive Officer > VP Engineering > Director, Platform)

- Data Contracts / Definitions:

    - Root(s): leader_id IS NULL
    - Level: Root = 0; each recursive join increments by 1.
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


| leader_id | leader_title                  | employee_id | job_title                     | level | path                                                                                           |
|-----------|-------------------------------|-------------|--------------------------------|-------|------------------------------------------------------------------------------------------------|
|           | Chief Executive Officer       | 1           | Chief Executive Officer        | 0     | Chief Executive Officer                                                                         |
| 1         | Chief Executive Officer       | 2           | Vice President of Engineering  | 1     | Chief Executive Officer &gt; Vice President of Engineering                                      |
| 1         | Chief Executive Officer       | 16          | Marketing Manager              | 1     | Chief Executive Officer &gt; Marketing Manager                                                  |
| 1         | Chief Executive Officer       | 25          | Vice President of Production   | 1     | Chief Executive Officer &gt; Vice President of Production                                       |
| 1         | Chief Executive Officer       | 234         | Chief Financial Officer        | 1     | Chief Executive Officer &gt; Chief Financial Officer                                           |
| 1         | Chief Executive Officer       | 263         | Information Services Manager   | 1     | Chief Executive Officer &gt; Information Services Manager                                       |
| 1         | Chief Executive Officer       | 273         | Vice President of Sales        | 1     | Chief Executive Officer &gt; Vice President of Sales                                            |
| 2         | Vice President of Engineering | 3           | Engineering Manager            | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Engineering Manager              |
| 2         | Vice President of Engineering | 17          | Marketing Assistant            | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Marketing Assistant              |
| 2         | Vice President of Engineering | 18          | Marketing Specialist           | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Marketing Specialist             |
| 2         | Vice President of Engineering | 19          | Marketing Assistant            | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Marketing Assistant              |
| 2         | Vice President of Engineering | 20          | Marketing Assistant            | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Marketing Assistant              |
| 2         | Vice President of Engineering | 21          | Marketing Specialist           | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Marketing Specialist             |
| 2         | Vice President of Engineering | 22          | Marketing Specialist           | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Marketing Specialist             |
| 2         | Vice President of Engineering | 23          | Marketing Specialist           | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Marketing Specialist             |
| 2         | Vice President of Engineering | 24          | Marketing Specialist           | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Marketing Specialist             |
| 2         | Vice President of Engineering | 26          | Production Control Manager     | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Production Control Manager        |
| 2         | Vice President of Engineering | 211         | Quality Assurance Manager      | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Quality Assurance Manager         |
| 2         | Vice President of Engineering | 222         | Master Scheduler               | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Master Scheduler                 |
| 2         | Vice President of Engineering | 227         | Facilities Manager             | 2     | Chief Executive Officer &gt; Vice President of Engineering &gt; Facilities Manager               |


📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/Day22/Part2](https://youtu.be/hmsNrWjoyWo)