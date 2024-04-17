--Creating new Database named: 'AtliQ_Supply_Chain_DB'
CREATE DATABASE AtliQ_Supply_Chain_DB
USE AtliQ_Supply_Chain_DB    --use database

--See all data after importing all files in SSMS
SELECT * FROM [dbo].[dim_customers]
SELECT * FROM [dbo].[dim_products]
SELECT * FROM [dbo].[dim_date]
SELECT * FROM [dbo].[dim_targets_orders]
SELECT * FROM [dbo].[fact_order_lines]
SELECT * FROM [dbo].[fact_orders_aggregate]

-- Data Cleaning and Data Preprocessing:

--Change columns name of dim_targets_order
EXEC sp_rename '[dbo].[dim_targets_orders].column1', 'customer_id', 'column'        -- Rename column name of column1 to customer_id
EXEC sp_rename '[dbo].[dim_targets_orders].column2', 'ontime_target%', 'column'     -- Rename column name of column2 to ontime_target%
EXEC sp_rename '[dbo].[dim_targets_orders].column3', 'infull_target%', 'column'     -- Rename column name of column3 to infull_target%	
EXEC sp_rename '[dbo].[dim_targets_orders].column4', 'otif_target%', 'column'       -- Rename column name of column3 to otif_target%	

--Dealing with [dbo].[dim_products] table
UPDATE [dbo].[dim_products] SET category='Beverages' WHERE category='beverages'     -- Convert beverages into Beverages

--Remove 'AM' substring from 'product_name' column 
UPDATE [dbo].[dim_products] SET product_name= SUBSTRING(product_name,4,LEN(product_name))
FROM [dbo].[dim_products]

-- Dealing with [dbo].[fact_order_lines] table
-- Working on 'In_Full' column
ALTER TABLE [dbo].[fact_order_lines] ALTER COLUMN In_Full VARCHAR(10)                -- Change the datatype from INT to VARCHAR of In_Full column
UPDATE [dbo].[fact_order_lines] SET In_Full='Yes' WHERE In_Full=1                    -- Update the 'In_Full' marked as 1 to 'Yes'
UPDATE [dbo].[fact_order_lines] SET In_Full='No' WHERE In_Full='0'                   -- Update the 'In_Full' marked as '0' to 'No'

--Rename 'In_Full' column to 'in_full'
EXEC sp_rename '[dbo].[fact_order_lines].In_Full','in_full', 'column'

--Rename 'On_Time' column to 'on_time'
EXEC sp_rename  '[dbo].[fact_order_lines].On_Time','on_time','column'

--Rename 'On_Time_In_Full' column to 'on_time'
EXEC sp_rename  '[dbo].[fact_order_lines].On_Time_In_Full','otif','column'

-- Working on 'On_Time' column
ALTER TABLE [dbo].[fact_order_lines] ALTER COLUMN On_Time VARCHAR(10)                -- Change the datatype from INT to VARCHAR of On_Time column
UPDATE [dbo].[fact_order_lines] SET On_Time='Yes' WHERE On_Time=1                    -- Update the 'On_Time' marked as 1 to 'Yes'
UPDATE [dbo].[fact_order_lines] SET On_Time='No' WHERE On_Time='0'                   -- Update the 'On_Time' marked as 0 to 'No'
  
-- Working on 'otif' column
ALTER TABLE [dbo].[fact_order_lines] ALTER COLUMN otif VARCHAR(10)                   -- Change the datatype from INT to VARCHAR of otif column
UPDATE [dbo].[fact_order_lines] SET otif='Yes' WHERE otif=1                          -- Update the 'otif' marked as 1 to 'Yes'
UPDATE [dbo].[fact_order_lines] SET otif='No' WHERE otif='0'                         -- Update the 'otif' marked as 0 to 'No'


-- Dealing with [dbo].[fact_orders_aggregate] table
--Working on 'on_time' column
ALTER TABLE [dbo].[fact_orders_aggregate] ALTER COLUMN on_time VARCHAR(10)           -- Change the datatype from INT to VARCHAR of on_time column
UPDATE [dbo].[fact_orders_aggregate] SET on_time='Yes' WHERE on_time=1               -- Update the 'on_time' marked as 1 to 'Yes'
UPDATE [dbo].[fact_orders_aggregate] SET on_time='No' WHERE on_time='0'              -- Update the 'on_time' marked as 0 to 'No'

--Working on 'in_full' column
ALTER TABLE  [dbo].[fact_orders_aggregate] ALTER COLUMN in_full VARCHAR(10)          -- Change the datatype from INT to VARCHAR of in_full column
UPDATE [dbo].[fact_orders_aggregate] SET in_full='Yes' WHERE in_full=1               -- Update the 'in_full' marked as 1 to 'Yes'
UPDATE [dbo].[fact_orders_aggregate] SET in_full='No' WHERE in_full='0'              -- Update the 'in_full' marked as 0 to 'No'
  
--Working on 'otif' column
ALTER TABLE  [dbo].[fact_orders_aggregate] ALTER COLUMN otif VARCHAR(10)             -- Change the datatype from INT to VARCHAR of otif column
UPDATE [dbo].[fact_orders_aggregate] SET otif='Yes' WHERE otif=1                     -- Update the ' otif' marked as 1 to 'Yes'
UPDATE [dbo].[fact_orders_aggregate] SET otif='No' WHERE otif='0'                    -- Update the ' otif' marked as 0 to 'No'
  