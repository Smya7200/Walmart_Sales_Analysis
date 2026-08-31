--------------------------------
--Analyst: Mya Smith
--CLEAN TABLE
---------------------------------

---------------------------------
--Data Quality Check:
---------------------------------
SELECT *
FROM walmart_sales_clean
LIMIT 10;
---------------------------------
--Descriptive Statistics
---------------------------------
SELECT
	ROUND(MIN(weekly_sales), 2) AS min_weekly_sales,
	ROUND(MAX(weekly_sales), 2) AS max_weekly_sales,
	ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales
FROM walmart_sales_clean;
-------------------------------
--Store Performance
-------------------------------
--- Best Weekly Average Sales (store departments 20,4,14)
SELECT
	store,
	ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales
FROM walmart_sales_clean
GROUP BY store
ORDER BY avg_weekly_sales DESC;

-- Which store departments have the lowest average sales (33,44,5)
SELECT
	store,
	ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales
FROM walmart_sales_clean
GROUP BY store
ORDER BY avg_weekly_sales ASC;


-- Which stores generated the highest total sales? (20, 4,14)
SELECT
	store,
	ROUND(SUM(weekly_sales), 2) AS total_sales
FROM walmart_sales_clean
GROUP BY store
ORDER BY total_sales DESC;

-- Holiday Performance by store, best performance is 20,4,14
SELECT
	store,
	ROUND(AVG(weekly_sales), 2) as avg_weekly_sales
FROM walmart_sales_clean
WHERE holiday_flag = 1
GROUP BY store
ORDER BY avg_weekly_sales DESC;

-----------------------------------------------------------------------
--Correlation Analysis of Economic and Environmental Factors (Numerical):
------------------------------------------------------------------------
--What is the correlation between weekly sales and 4 economic/environmental factors?
SELECT
	ROUND(CORR(weekly_sales, unemployment)::numeric, 2) AS unemployment_corr,
	ROUND(CORR(weekly_sales, fuel_price)::numeric, 2) AS fuel_price_corr,
	ROUND(CORR(weekly_sales, cpi)::numeric, 2) AS cpi_corr,
	ROUND(CORR(weekly_sales, temperature)::numeric, 2) AS temperature_corr
FROM walmart_sales_clean;

--R^2 Analysis of Economic and Environmental Factors:
-- unemployment
SELECT
	ROUND(REGR_R2(weekly_sales, unemployment)::numeric, 4) AS r_squared,
	ROUND((REGR_R2(weekly_sales, unemployment)* 100)::numeric, 2) AS r_squared_percentage,
	ROUND(REGR_SLOPE(weekly_sales, unemployment)::numeric, 4) AS slope
FROM walmart_sales_clean;

--fuel_price
SELECT
	ROUND(REGR_R2(weekly_sales, fuel_price)::numeric, 4) AS r_squared,
	ROUND((REGR_R2(weekly_sales, fuel_price)* 100)::numeric, 2) AS r_squared_percentage,
	ROUND(REGR_SLOPE(weekly_sales, fuel_price)::numeric, 4) AS slope
FROM walmart_sales_clean;

--cpi
SELECT
	ROUND(REGR_R2(weekly_sales, cpi)::numeric, 4) AS r_squared,
	ROUND((REGR_R2(weekly_sales, cpi)* 100)::numeric, 2) AS r_squared_percentage,
	ROUND(REGR_SLOPE(weekly_sales, cpi)::numeric, 4) AS slope
FROM walmart_sales_clean;

--temperature
SELECT
	ROUND(REGR_R2(weekly_sales, temperature)::numeric, 4) AS r_squared,
	ROUND((REGR_R2(weekly_sales, temperature)* 100)::numeric, 2) AS r_squared_percentage,
	ROUND(REGR_SLOPE(weekly_sales, temperature)::numeric, 4) AS slope
FROM walmart_sales_clean;

--Results:
-- Cpi, fuel_price, temperature, and unemployment have low correlation
-----------------------------------------------------------------
--Store, Holiday, and Time vs Weekly_Sales:
------------------------------------------------------------------

--Store vs. Weekly Sales - how much sales differ across stores
SELECT
	store,
	ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales,
	ROUND(STDDEV(weekly_sales), 2) AS sales_stddev
FROM walmart_sales_clean
GROUP BY store
ORDER BY avg_weekly_sales DESC;

--holidays/non-holidays vs weekly sales
SELECT
	holiday_flag,
	COUNT(*) AS weeks,
	ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales,
	ROUND(STDDEV(weekly_sales), 2) AS sales_stddev
FROM walmart_sales_clean
GROUP BY holiday_flag
ORDER BY holiday_flag;

-- What is the sales lift for holidays vs. non-holidays
SELECT
	ROUND(
		(
		 	AVG(weekly_sales) FILTER (WHERE holiday_flag = 1)
			-
			AVG(weekly_sales) FILTER (WHERE holiday_flag = 0)
		 )
		 /
		 AVG(weekly_sales) FILTER (WHERE holiday_flag = 0)
		 * 100,
		 2
	) AS holiday_sales_lift_pct
FROM walmart_sales_clean;
-- Stores avg weekly sales were 7.84% higher during major holidays.

-----------------------------
-- Time/Seasonality Analysis:
-----------------------------
-- Monthly
SELECT
	EXTRACT(MONTH FROM date) AS month,
	ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales
FROM walmart_sales_clean
GROUP BY month
ORDER BY month;

--Quarterly
SELECT
	EXTRACT(QUARTER FROM date) AS quarter,
	ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales
FROM walmart_sales_clean
GROUP BY quarter
ORDER BY quarter;

--Yearly
SELECT
	EXTRACT(YEAR FROM date) AS year,
	ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales
FROM walmart_sales_clean
GROUP BY year
ORDER BY year;

--Yearly change in SUM of sales using LAG:
SELECT
	year,
	total_sales,
	ROUND(
			(total_sales- LAG(total_sales) OVER (ORDER BY year))
			/ LAG(total_sales) OVER (ORDER BY year) * 100, 2
		) AS yoy_growth_pct
FROM (
	SELECT
		EXTRACT(YEAR from date) AS year,
		ROUND(SUM(weekly_sales),2) AS total_sales
	FROM walmart_sales_clean
	GROUP BY year
) yeary_sales
ORDER BY year;

-- Yearly change in average sales
SELECT
	year,
	average_sales,
	ROUND(
			(average_sales - LAG(average_sales) OVER (ORDER BY year))
			/ LAG(average_sales) OVER (ORDER BY year) * 100, 2
	) AS yoy_growth_pct_avg
FROM (
	  SELECT
	  EXTRACT(YEAR from date) AS year,
	  ROUND(AVG(weekly_sales), 2) AS average_sales
	  FROM walmart_sales_clean
	  GROUP BY year
) yearly_avg_sales
ORDER BY year;

------ End of SQL Analysis - will transition to python.