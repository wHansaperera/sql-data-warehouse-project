USE DataWarehouse;
GO

/*==========================================================
  BRONZE CHECKS
==========================================================*/

-- Bronze customer NULL IDs are expected because Bronze is raw.
SELECT *
FROM bronze.crm_cust_info
WHERE cst_id IS NULL;


-- Bronze customer duplicates
SELECT
    cst_id,
    COUNT(*) AS duplicate_count
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL
GROUP BY cst_id
HAVING COUNT(*) > 1;


/*==========================================================
  SILVER CHECKS
==========================================================*/

-- Silver should not have NULL customer IDs
SELECT *
FROM silver.crm_cust_info
WHERE cst_id IS NULL;


-- Silver should not have duplicate customer IDs
SELECT
    cst_id,
    COUNT(*) AS duplicate_count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;


-- Check unwanted spaces in Silver customer names
SELECT *
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
   OR cst_lastname  != TRIM(cst_lastname);


-- Check gender standardization
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;


-- Check marital status standardization
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info;


-- Check product key format
SELECT TOP 20
    prd_key
FROM silver.crm_prd_info;


-- Product keys should usually contain hyphen, not underscore
SELECT *
FROM silver.crm_prd_info
WHERE prd_key LIKE '%[_]%';


-- Check sales product keys
SELECT TOP 20
    sls_prd_key
FROM silver.crm_sales_details;


/*==========================================================
  GOLD CHECKS
==========================================================*/

-- Customer dimension check
SELECT TOP 100 *
FROM gold.dim_customers;


-- Product dimension check
SELECT TOP 100 *
FROM gold.dim_products;


-- Sales fact check
SELECT TOP 100 *
FROM gold.fact_sales;


-- Missing product/customer keys in fact
SELECT
    order_number,
    product_key,
    customer_key,
    sales_amount
FROM gold.fact_sales
WHERE product_key IS NULL
   OR customer_key IS NULL;


-- Source-level check for missing product mapping
SELECT TOP 100
    sd.sls_prd_key,
    pr.product_number,
    pr.product_key
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_products AS pr
    ON sd.sls_prd_key = pr.product_number
WHERE pr.product_key IS NULL;


-- Source-level check for missing customer mapping
SELECT TOP 100
    sd.sls_cust_id,
    cu.customer_id,
    cu.customer_key
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_customers AS cu
    ON sd.sls_cust_id = cu.customer_id
WHERE cu.customer_key IS NULL;

-- get gold table

SELECT *
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_customers AS cu
    ON sd.sls_cust_id = cu.customer_id
