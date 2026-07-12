USE DataWarehouse;
GO

/* =========================================================
   Quality Checks - Silver Layer
   ========================================================= */


/* =========================================================
   1. silver.crm_cust_info
   ========================================================= */

-- Check for NULLs or duplicates in primary key
-- Expectation: No Results
SELECT
    cst_id,
    COUNT(*) AS duplicate_count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;


-- Check for unwanted spaces
-- Expectation: No Results
SELECT
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_gndr
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key)
   OR cst_firstname != TRIM(cst_firstname)
   OR cst_lastname != TRIM(cst_lastname)
   OR cst_gndr != TRIM(cst_gndr);


-- Check data standardization
SELECT DISTINCT
    cst_marital_status
FROM silver.crm_cust_info;

SELECT DISTINCT
    cst_gndr
FROM silver.crm_cust_info;


/* =========================================================
   2. silver.crm_prd_info
   ========================================================= */

-- Check for NULLs or duplicates in primary key
-- Expectation: No Results
SELECT
    prd_id,
    COUNT(*) AS duplicate_count
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;


-- Check for unwanted spaces
-- Expectation: No Results
SELECT
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);


-- Check for NULLs or negative values
-- Expectation: No Results
SELECT
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;


-- Check data standardization
SELECT DISTINCT
    prd_line
FROM silver.crm_prd_info;


-- Check invalid date order
-- Expectation: No Results
SELECT
    *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;


/* =========================================================
   3. silver.crm_sales_details
   ========================================================= */

-- Check invalid date order
-- Expectation: No Results
SELECT
    *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;


-- Check sales calculation consistency
-- Expectation: No Results
SELECT DISTINCT
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0
ORDER BY
    sls_sales,
    sls_quantity,
    sls_price;


/* =========================================================
   4. silver.erp_cust_az12
   ========================================================= */

-- Check out-of-range birthdates
-- Expectation: No Results
SELECT DISTINCT
    bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
   OR bdate > GETDATE();


-- Check data standardization
SELECT DISTINCT
    gen
FROM silver.erp_cust_az12;


/* =========================================================
   5. silver.erp_loc_a101
   ========================================================= */

-- Check data standardization
SELECT DISTINCT
    cntry
FROM silver.erp_loc_a101
ORDER BY cntry;


/* =========================================================
   6. silver.erp_px_cat_g1v2
   ========================================================= */

-- Check for unwanted spaces
-- Expectation: No Results
SELECT
    *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
   OR subcat != TRIM(subcat)
   OR maintenance != TRIM(maintenance);


-- Check data standardization
SELECT DISTINCT
    maintenance
FROM silver.erp_px_cat_g1v2;
