# SQL Data Warehouse Project

This project is a SQL Server Data Warehouse built using the **Bronze, Silver, and Gold** architecture.

The main goal of this project is to load data from CRM and ERP source files, clean and transform the data, and create a business-ready data model for reporting and analytics.

> This project is based on the **Data With Baraa SQL Data Warehouse Project**.  
> Source tutorial: https://www.youtube.com/watch?v=9GVqKuTVANE&t=12581s

---

## Project Overview

This project covers the full data warehouse development process:

- Loading raw data from CSV files
- Building Bronze, Silver, and Gold layers
- Cleaning and standardizing data
- Integrating CRM and ERP data
- Creating fact and dimension views
- Building a Sales Data Mart using a Star Schema
- Running data quality checks

---

## Data Architecture

<img width="1282" height="742" alt="data_architecture" src="https://github.com/user-attachments/assets/a26414db-0219-4ffb-b073-266b02eaf5ae" />


The data warehouse follows three layers:

1.Bronze Layer

The Bronze layer stores raw data from the source systems.

-Data is loaded from CSV files
-No transformation is applied
-Data is stored as-is

2.Silver Layer

The Silver layer contains cleaned and standardized data.

Main work done in this layer:

- Remove invalid records
- Remove duplicates
- Clean unwanted spaces
- Standardize values
- Fix date formats
- Create derived columns

3.Gold Layer

The Gold layer contains business-ready data.

This layer is used for:

- Reporting
- Analytics
- BI dashboards
- SQL analysis

## Data Flow
<img width="1008" height="670" alt="Data_flow" src="https://github.com/user-attachments/assets/d1ce55f5-6bd9-445c-bf74-7028651837e8" />


## Model Integration

<img width="1002" height="857" alt="model_integration" src="https://github.com/user-attachments/assets/ea83d15b-1e26-4b25-892c-7c4a574a2b5b" />

## CRM System

CRM provides:

- Customer information
- Product information
- Sales transaction details

## ERP System

ERP provides:

- Customer birthdate
- Customer gender
- Customer country
- Product category details

The Silver layer prepares this data, and the Gold layer integrates it into a clean reporting model.

## Sales Data Mart

<img width="1002" height="741" alt="Data_mart_Star_schema" src="https://github.com/user-attachments/assets/73df50e8-8d52-4171-b26e-82b5ab20b985" />

The star schema contains:
- Dimention Tables (Products and Customers informations)
- Fact Tables (Sales Details)

# Project Management
<img width="986" height="952" alt="Project_management_Notion" src="https://github.com/user-attachments/assets/71c46a75-9cc5-4f9e-8195-a0f4b0af16fe" />

# Technologies Used
- SQL Server
- SQL Server Management Studio
- T-SQL
- CSV Files
- Draw.io
- Notion
- GitHub

## How to Run This Project
1. Create database and schemas
2. Create Bronze tables
3. Load Bronze data
4. Create Silver tables
5. Load Silver data
6. Create Gold views
7. Run quality checks

# What I Learned

By completing this project, I practiced:

- Data warehouse architecture
- ETL development
- SQL stored procedures
- Data cleaning
- Data transformation
- Data modeling
- Star schema design
- Fact and dimension tables
- Data quality testing

## Credits

This project was created for learning and portfolio purposes.

Original learning source:

Data With Baraa - SQL Data Warehouse Project
https://www.youtube.com/watch?v=9GVqKuTVANE&t=12581s

Special thanks to Baraa Khatib Salkini for the original project guidance and learning materials.
```md


![Data Architecture](docs/images/data_architecture.png)
