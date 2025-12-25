# 🛒 Zepto E-Commerce Inventory Analysis

## 📌 Project Overview
This project focuses on optimizing inventory management for a quick-commerce platform (Zepto). Using a dataset of **3,732 records**, I performed an end-to-end data analysis process—from bulk data ingestion to actionable business insights.

The goal was to simulate a real-world scenario where raw data is extracted, cleaned, and analyzed to support decisions regarding **stock levels, pricing strategies, and inventory valuation**.

---

## 🛠️ Tech Stack
* **Database:** Oracle 10g Express Edition
* **ETL Tool:** SQL*Loader (Command Line Interface)
* **Language:** SQL (Data Manipulation & Aggregation)
* **Source Data:** Zepto Inventory Dataset (CSV)

---

## 🚀 The Process

### 1. ETL Pipeline (Extract, Transform, Load)
I utilized **Oracle SQL*Loader** to handle the bulk ingestion of the CSV file into the database. This method is preferred in enterprise environments for its speed and efficiency over manual insertion.

* **Command Used:** `sqlldr user/password@software control=sql_loader_control.ctl`
* **Validation:** Verified data integrity by reconciling record counts between source and destination.

### 2. Data Cleaning & Normalization
Raw data is rarely analysis-ready. I applied the following cleaning steps:
* **Quality Checks:** Scanned 9 columns using `OR` logic to identify and handle NULL values.
* **Anomaly Detection:** Identified and removed erroneous records where `MRP` and `DiscountPercent` were both 0.
* **Currency Standardization:** The raw pricing data required normalization. I executed `UPDATE` statements to convert integer values into standard currency units (Rupees).

### 3. Business Analysis & Insights
I wrote complex SQL queries to extract meaning from the data:

* **📉 Stock Availability:**
    * Analyzed the `OutOfStock` flags to determine the immediate product availability ratio.
* **📦 Product Variety Strategy:**
    * Used `GROUP BY` and `HAVING` clauses to identify products with duplicate names. This revealed a **SKU Variant Strategy**, where Zepto lists the same product in multiple weight classes (e.g., 500g vs. 1kg) to maximize customer reach.
* **💰 Inventory Valuation:**
    * Calculated the **Total Inventory Value** (`Selling Price * Available Quantity`). This metric identifies high-value assets sitting in the warehouse, helping stakeholders prioritize marketing efforts for high-revenue items.

---

## 📂 File Structure
* `analysis_queries.sql`: Contains the 8 key SQL queries used for cleaning and analysis.
* `sql_loader_control.ctl`: The control file configuration used for the ETL process.
* `zepto_v2.csv`: (Source data - *not included in repo for privacy/size reasons*).

---

## 📢 Conclusion
This project demonstrates the ability to handle the full data lifecycle: loading raw data via command line tools, sanitizing it using SQL logic, and deriving financial and operational insights for e-commerce growth.