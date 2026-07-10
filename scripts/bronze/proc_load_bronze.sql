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

-- Inserting data
EXEC bronze.load_bronze

USE DataWarehouse;
GO
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 

BEGIN
	DECLARE @start_time_whl_batch DATETIME,@end_time_whl_batch DATETIME;
	DECLARE @start_time DATETIME,@end_time DATETIME;
	BEGIN TRY
		SET @start_time_whl_batch = GETDATE();
		PRINT 'Loading Bronze Layer';
		PRINT '===============================================================';
		PRINT '----------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------------';
		-- bulk insert of cust info
		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING TABLE :bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds'; 

		

		-- bulk insert of prd info
		PRINT '>>TRUNCATING TABLE :bronze.crm_prd_info';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds'; 

		-- bulk insert of sales details
		PRINT '>>TRUNCATING TABLE :bronze.crm_sales_details';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds'; 


		PRINT '----------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------------------';

		-- bulk insert of erp cust data
		PRINT '>>TRUNCATING TABLE :bronze.erp_cust_az12';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds'; 



		-- bulk insert of erp loc data
		PRINT '>>TRUNCATING TABLE :bronze.erp_loc_a101';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds'; 

	

		-- bulk insert of px cat data
		PRINT '>>TRUNCATING TABLE :bronze.erp_px_cat_g1v2';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\ASUS\Myworks\projects\microsoft_data_warehouse_project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds'; 
		SET @end_time_whl_batch = GETDATE();
		PRINT 'WHOLE BATCH LOAD DURATION:'+ CAST(DATEDIFF(second,@start_time_whl_batch,@end_time_whl_batch) AS NVARCHAR) + ' seconds'; 

	END TRY
	BEGIN CATCH
		PRINT '===============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===============================================';
	END CATCH
	
END

