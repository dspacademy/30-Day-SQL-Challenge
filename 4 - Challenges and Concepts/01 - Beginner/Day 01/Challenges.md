# DAY ONE CHALLENGES

## OBJECTIVE
### Demonstrate the ability to write accurate SQL queries using SELECT, FROM, and WHERE clauses to retrieve targeted business data from relational tables. The goal is to solve real-world scenarios such as identifying design capacity within HR, tracking new hires, and analyzing product attributes in the supply chain.

### Question 1 

**Use Case:** DIWBikes is launching a new high-performance bicycle line. The Engineering Stakeholder needs to assemble a specialized design team for the project. To do this, they require a list of all employees currently holding the title ‘Design Engineer,’ including their hire dates and login IDs, to verify experience and system access before assigning them to the innovation team.

**Business Impact:** Ensures the right talent and adequate tenure/experience are aligned to a strategic product initiative, accelerating time-to-market.

**Action:** Prepare a stakeholder-ready roster and summary notes.

**Sample of Expected Output**

| employee_id | national_id_number | login_id              | job_title        | hire_date   |
|-------------|--------------------|-----------------------|------------------|-------------|
| 5           | 695256908          | dsp-workshop\gail0    | Design Engineer  | 2008-01-06  |
| 6           | 998320692          | dsp-workshop\jossef0  | Design Engineer  | 2008-01-24  |
| 15          | 56920285           | dsp-workshop\sharon0  | Design Engineer  | 2011-01-18  |

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform](https://www.youtube.com/@DataSolutionPlatform)

### Question 2

**Use Case:** Following several campus recruitment drives, HR wants to identify employees who joined after December 1, 2009, to track onboarding throughput, confirm contract statuses, and plan probation review cycles.

**Business Impact:** Improves early-stage talent management, reduces compliance risks, and optimizes onboarding capacity.

**Action:** Compile a clean, auditable list of recent hires with key identifiers.

**Sample of Expected Output**

| employee_id | national_id_number | login_id               | job_title               | hire_date   |
|-------------|---------------------|-------------------------|--------------------------|-------------|
| 11          | 974026903          | dsp-workshop\ovidiu0   | Senior Tool Designer    | 2010-12-05  |
| 13          | 486228782          | dsp-workshop\janice0   | Tool Designer           | 2010-12-23  |
| 14          | 42487730           | dsp-workshop\michael8  | Senior Design Engineer  | 2010-12-30  |
| 15          | 56920285           | dsp-workshop\sharon0   | Design Engineer         | 2011-01-18  |
| 18          | 222969461          | dsp-workshop\john5     | Marketing Specialist    | 2011-02-07  |
``

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform](https://www.youtube.com/@DataSolutionPlatform)

### Question 3

**Use Case:** The Supply Chain team plans production runs for spring catalogs. They need to locate in-house manufactured items that are categorized and marked as finished goods but still lack color attributes—these fields drive bill of materials (BOM) accuracy and catalog presentation.

**Business Impact:** Reduces data errors in BOMs and avoids catalog inconsistencies, decreasing rework and customer confusion.

**Action:** Deliver a prioritized data-cleanup inventory with impacted SKUs.

**Sample of Expected Output**

| product_id | name         | product_number | make_flag | finished_goods_flag | color | safety_stock_level | reorder_point | standard_cost | list_price |
|------------|-------------|----------------|-----------|----------------------|-------|---------------------|---------------|---------------|-----------|
| 802        | LL Fork     | FK-1639        | true      | true                 |       | 500                 | 375           | 65.8097       | 148.2200  |
| 803        | ML Fork     | FK-5136        | true      | true                 |       | 500                 | 375           | 77.9176       | 175.4900  |
| 804        | HL Fork     | FK-9939        | true      | true                 |       | 500                 | 375           | 101.8936      | 229.4900  |
| 805        | LL Headset  | HS-0296        | true      | true                 |       | 500                 | 375           | 15.1848       | 34.2000   |
| 806        | ML Headset  | HS-2451        | true      | true                 |       | 500                 | 375           | 45.4168       | 102.2900  |
``

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform](https://www.youtube.com/@DataSolutionPlatform)