# DIWBikes SQL Challenge — Setup Guide

This repository contains the SQL scripts, data files, and PowerShell automation required to set up the **DIWBikes** PostgreSQL database.  
The setup process creates the database schema, applies indexes, and loads all required CSV data.

---

## 📁 Repository File Structure

```
SQL-Challenge/
│
├── DIWBIKES Setup/              # SQL scripts for database initialization
│   ├── diwbikesdbsetup.sql      # Schema and table creation
│   └── diwbikesdbsetupindex.sql # Index creation
│   └── diwbikespowershellsetup.ps1 # PowerShell Setup Script
|   └── README.md               # Project documentation and setup instructions
|
├── DIWBikes Data/               # Primary data files (tab-delimited CSVs)
│   ├── Address.csv
│   ├── AddressType.csv
│   ├── Location.csv
│   ├── Product.csv
│   ├── ProductCategory.csv
│   ├── ProductSubcategory.csv
│   ├── ScrapReason.csv
│   ├── CountryRegionCurrency.csv
│   ├── CreditCard.csv
│   ├── Currency.csv
│   ├── CurrencyRate.csv
│   ├── Customer.csv
│   ├── SalesOrderHeader.csv
│   ├── SalesTaxRate.csv
│   ├── SalesTerritory.csv
│   ├── SalesReason.csv
│   ├── Department.csv
│   ├── Shift.csv
│   ├── EmployeeDepartmentHistory.csv
│   ├── EmployeePayHistory.csv
│   └── ...
│
└── DIWBikes Data/bikes_csv/     # Additional data (comma-delimited CSVs)
    ├── person.csv
    ├── SalesOrderDetail.csv
    └── Employee.csv
```
## PGAdmin Setup (PostgreSQL)

### 1. Download PGAdmin
Download the latest version of PostgreSQL and PGAdmin from the official EnterpriseDB website:  
[PostgreSQL Downloads](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
- Once the download is completed. Install the .exe file
- Follow the installation steps carefully.
- **Important:** Take note of your admin password during setup. You’ll need it to access your database later.

``
### 🗄️ Database Creation

```sql
CREATE DATABASE diwbikes;
```
---

## ⚙️ Environment Setup (PowerShell)

### Launch PowerShell
- Open **PowerShell** in **VS Code**, or  
- Press **Win + R**, type `powershell`, and press **Enter**

### Navigate to the PowerShell Script Directory
**Note** Backslashes can be used in PowerShell for directory navigation commands such as cd or Set-Location.
```powershell
cd "path\to\diwbikespowershellsetup.ps1"
```


### Update the PowerShell Script
Edit `diwbikespowershellsetup.ps1` file and update:
- `basePath` **Note:** Replace backslashes with forward slashes (/) in the file path.
- PostgreSQL (`psql`) password

⚠️ **Do not commit credentials to source control.**

### Ensure PostgreSQL `psql` Is Available
```powershell
$env:Path += ";C:\Program Files\PostgreSQL\18\bin"
psql --version
```

Expected output:
```
psql (PostgreSQL) 18.1
```
---

### Verify Connectivity
```powershell
psql -U postgres -d diwbikes -c "SELECT current_database(), current_user;"
```

Expected output:
```
 current_database | current_user
------------------+--------------
 diwbikes         | postgres
(1 row)
```

## Temporary bypass the PowerShell’s execution policy protection for this process only
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

---

## ▶️ Run the Setup Script
```powershell
.\diwbikespowershellsetup.ps1
```

---

## ✅ Setup Completion

Once completed:
- Schema created
- Indexes applied
- Data loaded

🎉 **DIWBikes database setup is complete.**

📺 **Watch Demo on YouTube:** [https://www.youtube.com/@DataSolutionPlatform/EnvironmentSetup](https://youtu.be/DPzXfRMdunY)
https://youtu.be/DPzXfRMdunY