-- Person Domain
CREATE UNIQUE INDEX AK_Address_rowguid ON person.Address(rowguid);
CREATE UNIQUE INDEX IX_Address_AddresLine1_AddressLine2_City_StateProvinceID_PostCd ON person.Address (Address_Line1, Address_Line2, City, State_Province_ID, Postal_Code);
CREATE INDEX IX_Address_StateProvinceID ON person.Address(State_Province_ID);
CREATE UNIQUE INDEX AK_AddressType_rowguid ON person.Address_Type(rowguid);
CREATE UNIQUE INDEX AK_AddressType_Name ON person.Address_Type(Name);
CREATE INDEX IX_Person_LastName_FirstName_MiddleName ON person.Person (Last_Name, First_Name, Middle_Name);

-- Production Domain
CREATE UNIQUE INDEX AK_Location_Name ON production.location(name);
CREATE UNIQUE INDEX AK_Product_ProductNumber ON production.product(product_number);
CREATE UNIQUE INDEX AK_Product_Name ON production.product(name);
CREATE UNIQUE INDEX AK_Product_rowguid ON production.product(rowguid);
CREATE UNIQUE INDEX AK_ProductCategory_Name ON production.product_category(name);
CREATE UNIQUE INDEX AK_ProductCategory_rowguid ON production.product_category(rowguid);
CREATE UNIQUE INDEX AK_ProductSubcategory_Name ON production.product_subcategory(name);
CREATE UNIQUE INDEX AK_ProductSubcategory_rowguid ON production.product_subcategory(rowguid);
CREATE UNIQUE INDEX AK_ScrapReason_Name ON production.scrap_reason(name);

-- Sales Domain
CREATE INDEX IX_CountryRegionCurrency_CurrencyCode ON sales.country_region_currency(currency_code);
CREATE UNIQUE INDEX AK_CreditCard_CardNumber ON sales.credit_card(card_number);
CREATE UNIQUE INDEX AK_Currency_Name ON sales.currency(name);
CREATE UNIQUE INDEX AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCd ON sales.currency_rate(currency_rate_date, from_currency_code, to_currency_code);
CREATE UNIQUE INDEX AK_Customer_rowguid ON sales.customer(rowguid);
CREATE UNIQUE INDEX AK_Customer_AccountNumber ON sales.customer(account_number);
CREATE INDEX IX_Customer_TerritoryID ON sales.customer(territory_id);
CREATE UNIQUE INDEX AK_SalesOrderDetail_rowguid ON sales.sales_order_detail(rowguid);
CREATE INDEX IX_SalesOrderDetail_ProductID ON sales.sales_order_detail(product_id);
CREATE UNIQUE INDEX AK_SalesOrderHeader_rowguid ON sales.sales_order_header(rowguid);
CREATE INDEX IX_SalesOrderHeader_CustomerID ON sales.sales_order_header(customer_id);
CREATE INDEX IX_SalesOrderHeader_SalesPersonID ON sales.sales_order_header(salesperson_id);
CREATE UNIQUE INDEX AK_SalesTaxRate_StateProvinceID_TaxType ON sales.sales_tax_rate(state_province_id, tax_type);
CREATE UNIQUE INDEX AK_SalesTaxRate_rowguid ON sales.sales_tax_rate(rowguid);
CREATE UNIQUE INDEX AK_SalesTerritory_Name ON sales.sales_territory(name);
CREATE UNIQUE INDEX AK_SalesTerritory_rowguid ON sales.sales_territory(rowguid);

-- HumanResources Domain
CREATE UNIQUE INDEX AK_Department_Name ON humanresources.department(name);
CREATE UNIQUE INDEX AK_Shift_Name ON humanresources.shift(name);
CREATE UNIQUE INDEX AK_Shift_StartTime_EndTime ON humanresources.shift(start_time, end_time);
CREATE UNIQUE INDEX AK_employee_id ON humanresources.employee(employee_id);