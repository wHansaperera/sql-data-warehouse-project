/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE 
        @start_time DATETIME,
        @end_time DATETIME,
        @batch_start_time DATETIME,
        @batch_end_time DATETIME;

    BEGIN TRY
        SET @batch_start_time = GETDATE();

        PRINT '=========================================';
        PRINT 'Loading Bronze Layer';
        PRINT '=========================================';

        PRINT '-----------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '-----------------------------------------';


        PRINT '>> Truncating Table: bronze.crm_cust_info';
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        PRINT '>> Truncating Table: bronze.crm_prd_info';
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        PRINT '>> Truncating Table: bronze.crm_sales_details';
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        PRINT '-----------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '-----------------------------------------';


        PRINT '>> Truncating Table: bronze.erp_cust_az12';
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.erp_cust_az12;

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.erp_loc_a101;

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        SET @batch_end_time = GETDATE();

        PRINT '=========================================';
        PRINT 'Bronze Layer Loading Completed';
        PRINT 'TOTAL LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '=========================================';

    END TRY

    BEGIN CATCH
        PRINT '=========================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR STATE: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=========================================';
    END CATCH
END;
GO

EXEC bronze.load_bronze;
GO
