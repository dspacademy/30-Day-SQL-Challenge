# DAY SEVEN CHALLENGES

## OBJECTIVE

### Demonstrate the practical difference between INNER JOIN and LEFT JOIN using a real marketing scenario for contacts named “Kim.”
- INNER JOIN: Returns only “Kim” contacts with complete address details, ensuring accurate postal campaigns and reducing waste. This supports precise mailing
- LEFT JOIN: Returns all “Kim” contacts, including those missing address details, and flags incomplete records for enrichment. Expands reach and enables email-only or data-completion workflows.

### Question 1

**Use Case:** Marketing Team is preparing a personalized campaign for contacts named ‘Kim.’ They require complete address details to ensure postal mail accuracy and compliance.

**Business Impact:** Increases campaign deliverability and lowers mailing waste.

**Action:** Assemble a contact file with full address fields for the Kim segment.

**Sample of Expected Output**


| person_id | title | first_name | middle_name | last_name    | email_address                          | address_id | address_type_id | address_line1            | address_line2 | city        | state_province_id | postal_code |
|-----------|-------|------------|-------------|--------------|----------------------------------------|------------|-----------------|---------------------------|---------------|-------------|--------------------|-------------|
| 38        |       | Kim        | B           | Abercrombie  | kim1@datasolutionsplatform.com        | 90         | 2               | 9752 Jeanne Circle        |               | Carnation   | 79                 | 98014       |
| 91        |       | Kimberly   | B           | Zimmerman    | kimberly0@datasolutionsplatform.com   | 128        | 2               | 8656 Lakespring Place     |               | Seattle     | 79                 | 98104       |
| 124       |       | Kim        | T           | Ralls        | kim0@datasolutionsplatform.com        | 5          | 2               | 1226 Shoe St.             |               | Bothell     | 79                 | 98011       |
| 7872      |       | Kimberly   | A           | Watson       | kimberly3@datasolutionsplatform.com   | 16917      | 2               | 1359 Montgomery Avenue    |               | Langford    | 7                  | V9          |
| 7929      |       | Kimberly   | L           | Brooks       | kimberly4@datasolutionsplatform.com   | 16975      | 2               | 1526 Green Road           |               | West Covina | 9                  | 91791       |

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform](https://www.youtube.com/@DataSolutionPlatform)


### Question 2

**Use Case:** To avoid missing potential responders, Marketing team wants the Kim cohort even when address details are incomplete, so they can trigger email-only or data-enrichment workflows.

**Business Impact:** Expands reach and informs data-completion strategies for priority segments.

**Action:** Provide an inclusive contact list and flag missing-address records for enrichment.

**Sample of Expected Output**

| person_id | title | first_name | middle_name | last_name    | email_address                          | address_id | address_type_id | address_line1            | address_line2 | city        | state_province_id | postal_code |
|-----------|-------|------------|-------------|--------------|----------------------------------------|------------|-----------------|---------------------------|---------------|-------------|--------------------|-------------|
| 38        |       | Kim        | B           | Abercrombie  | kim1@datasolutionsplatform.com        | 90         | 2               | 9752 Jeanne Circle        |               | Carnation   | 79                 | 98014       |
| 91        |       | Kimberly   | B           | Zimmerman    | kimberly0@datasolutionsplatform.com   | 128        | 2               | 8656 Lakespring Place     |               | Seattle     | 79                 | 98104       |
| 124       |       | Kim        | T           | Ralls        | kim0@datasolutionsplatform.com        | 5          | 2               | 1226 Shoe St.             |               | Bothell     | 79                 | 98011       |
| 295       | Ms.   | Kim        |             | Abercrombie  | kim2@datasolutionsplatform.com        |            |                 |                           |               |             |                    |             |
| 319       | Ms.   | Kim        |             | Akers        | kim3@datasolutionsplatform.com        |            |                 |                           |               |             |                    |             |
``

📺 **Watch solution on YouTube:** [https://www.youtube.com/@DataSolutionPlatform](https://www.youtube.com/@DataSolutionPlatform)
