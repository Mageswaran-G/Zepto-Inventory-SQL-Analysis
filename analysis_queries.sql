/* ========================================================================
PROJECT: Zepto Inventory Data Analysis
DATABASE: Oracle 10g Express Edition
AUTHOR: [Your Name]
DESCRIPTION: 
This script performs data validation, cleaning, and business analysis 
on the Zepto inventory dataset. It covers stock availability, 
product variety strategies, and inventory valuation.
========================================================================
*/

-- 1. DATA VALIDATION: Record Count Check
-- Purpose: Verify that the total number of records loaded into the database 
-- matches the source CSV file (Expected: 3,732 rows).
SELECT COUNT(*) AS TOTAL_RECORD_COUNT 
FROM ZEPTO;

-- 2. DATA QUALITY CHECK: Identifying Missing Values
-- Purpose: Scan all critical columns to identify incomplete records using OR logic.
-- This helps in deciding whether to impute data or remove bad records.
SELECT * FROM ZEPTO
WHERE 
    CATEGORY IS NULL OR
    NAME IS NULL OR
    MRP IS NULL OR
    DISCOUNTPERCENT IS NULL OR
    AVAILABLEQUANTITY IS NULL OR
    DISCOUNTEDSELLINGPRICE IS NULL OR
    WEIGHTINGMS IS NULL OR
    OUTOFSTOCK IS NULL OR
    QUANTITY IS NULL;

-- 3. CATEGORY ANALYSIS: Listing Unique Product Categories
-- Purpose: Understand the diversity of the inventory by listing all unique 
-- high-level product categories.
SELECT DISTINCT CATEGORY 
FROM ZEPTO
ORDER BY CATEGORY;

-- 4. INVENTORY STATUS: Stock Availability Analysis
-- Purpose: Analyze the ratio of available products vs. out-of-stock items.
-- This metric is crucial for supply chain efficiency and customer satisfaction.
SELECT OUTOFSTOCK, COUNT(*) AS STATUS_COUNT
FROM ZEPTO
GROUP BY OUTOFSTOCK;

-- 5. PRODUCT STRATEGY: Detecting SKU Variations
-- Purpose: Identify products that appear multiple times. In e-commerce, 
-- this indicates a strategy of selling the same item in different quantities/weights 
-- (e.g., 500g vs 1kg) to capture different market segments.
SELECT NAME, COUNT(NAME) AS VARIANT_COUNT
FROM ZEPTO
GROUP BY NAME
HAVING COUNT(NAME) > 1
ORDER BY VARIANT_COUNT DESC;

-- 6. DATA CLEANING: removing Invalid Pricing
-- Purpose: Identify and remove records where price is zero, which indicates 
-- data entry errors or system glitches.
-- Step 6a: View the invalid data
SELECT * FROM ZEPTO
WHERE MRP = 0 AND DISCOUNTPERCENT = 0;

-- Step 6b: Delete the invalid data
DELETE FROM ZEPTO 
WHERE MRP = 0 AND DISCOUNTPERCENT = 0;

-- 7. DATA NORMALIZATION: Standardizing Currency
-- Purpose: The raw data contains pricing in integer format (likely paise). 
-- We update this to standard currency units (Rupees) by dividing by 100.
UPDATE ZEPTO
SET
    MRP = MRP / 100.0,
    DISCOUNTEDSELLINGPRICE = DISCOUNTEDSELLINGPRICE / 100.0;

-- 8. BUSINESS INSIGHT: Inventory Valuation (Potential Revenue)
-- Purpose: Calculate the total monetary value locked in current inventory.
-- Formula: Selling Price * Available Quantity. 
-- This helps identify which products contribute most to the company's asset value.
SELECT NAME, SUM(DISCOUNTEDSELLINGPRICE * AVAILABLEQUANTITY) AS TOTAL_INVENTORY_VALUE
FROM ZEPTO
GROUP BY NAME
ORDER BY TOTAL_INVENTORY_VALUE DESC;