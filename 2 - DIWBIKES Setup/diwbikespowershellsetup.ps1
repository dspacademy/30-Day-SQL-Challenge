
# ------------------------------
# PSQL Setup for DIW Bikes Database
# ------------------------------

# Add PostgreSQL's bin directory to PATH for the current PowerShell session
# (Adjust version/path if your installation differs)
$env:Path += ";C:\Program Files\PostgreSQL\18\bin"

# Verify that psql is accessible and show the client version
psql --version


# ------------------------------
# Configuration: Parameters for your database and files
# ------------------------------

# Base directory where your SQL and CSV assets live
# Note: PowerShell accepts forward slashes; Replace backslashes with forward slashes
$basePath = "<addpath>/SQL Challenge"

# PostgreSQL role (user) and target database
$dbUser = "postgres"
$dbName = "diwbikes"

# Database password for the role specified in $dbUser
# IMPORTANT: Set this before any psql commands that require authentication
$env:PGPASSWORD = "<add your password>"


# ------------------------------
# Database setup: Run schema and index scripts
# ------------------------------

# Run the schema/setup SQL to create objects for DIW Bikes
psql -U $dbUser -d $dbName -f ($basePath + "/DIWBIKES Setup/diwbikesdbsetup.sql")

# Run the index script to create/optimize indexes
# NOTE: Ensure the folder name matches exactly (case/space sensitive on some systems)
# If your directory is "DIWBIKES Setup" (capital S), fix the path accordingly.
psql -U $dbUser -d $dbName -f ($basePath + "/DIWBIKES Setup/diwbikesdbsetupindex.sql")  # review path/case


# ------------------------------
# Bulk imports: Define CSV sources and target tables
# ------------------------------

# Each item describes:
#   - Table: fully qualified target table (schema.table)
#   - File: filename in the data folder
#   - Delim: delimiter literal for COPY
#   - Sub: subfolder under basePath
# For tabs, use E'\t'. For commas, use E','.
$imports = @(
    @{ Table='person.address';                        File='Address.csv';             Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='person.address_type';                   File='AddressType.csv';         Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='production.location';                   File='Location.csv';            Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='production.product';                    File='Product.csv';             Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='production.product_category';           File='ProductCategory.csv';     Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='production.product_subcategory';        File='ProductSubcategory.csv';  Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='production.scrap_reason';               File='ScrapReason.csv';         Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='sales.country_region_currency';         File='CountryRegionCurrency.csv'; Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='sales.credit_card';                     File='CreditCard.csv';          Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='sales.currency';                        File='Currency.csv';            Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='sales.currency_rate';                   File='CurrencyRate.csv';        Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='sales.customer';                        File='Customer.csv';            Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='sales.sales_order_header';              File='SalesOrderHeader.csv';    Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='sales.sales_tax_rate';                  File='SalesTaxRate.csv';        Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='sales.sales_territory';                 File='SalesTerritory.csv';      Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='sales.sales_reason';                    File='SalesReason.csv';         Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='humanresources.department';             File='Department.csv';          Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='humanresources.shift';                  File='Shift.csv';               Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='humanresources.employee_department_history'; File='EmployeeDepartmentHistory.csv'; Delim="E'\t'"; Sub='DIWBikes Data' }
    @{ Table='humanresources.employee_pay_history';   File='EmployeePayHistory.csv';  Delim="E'\t'"; Sub='DIWBikes Data' }

    # Note: These three use comma‑delimited CSVs located in a different subfolder
    @{ Table='person.person';                         File='person.csv';              Delim="E','";  Sub='DIWBikes Data/bikes_csv' }
    @{ Table='sales.sales_order_detail';              File='SalesOrderDetail.csv';    Delim="E','";  Sub='DIWBikes Data/bikes_csv' }
    @{ Table='humanresources.employee';               File='Employee.csv';            Delim="E','";  Sub='DIWBikes Data/bikes_csv' }
)

# ------------------------------
# Execution: Import all CSVs via \COPY
# ------------------------------

foreach ($m in $imports) {
    # Build the full path to the CSV file
    $csv = "$basePath/$($m.Sub)/$($m.File)"

    # Log progress to the console
    Write-Host "Importing $($m.File) into $($m.Table)..."

    # Use \COPY to stream data from client to server (works with local files via psql)
    # FORMAT csv: parse as CSV
    psql -U $dbUser -d $dbName -c "\COPY $($m.Table) FROM '$csv' WITH (FORMAT csv, DELIMITER $($m.Delim), HEADER false);"
}