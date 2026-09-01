# Walmart Sales Analysis - Project Overview
## Business Question: What factors are strongly associated with Walmart’s weekly sales?

The goal of this project is to investigate holidays, date (month, year, and quarter), and economic/environmental factors that are potentially strongly associated with Walmart’s weekly sales. The analysis combines descriptive statistics, correlation analysis, statistical testing and modelling, regression, and data visualization to identify which factors are most relevant and which have limited explanatory power.

Walmart Inc. (WMT) is an American multinational chain omnichannel retail corporation. In this dataset, the sales revenue years are 2010-2012. The factors in the dataset include Weekly Sales, Date, Holiday flag, CPI (Consumer Price Index), Fuel Price, and Temperature. 

## Data Dictionary:



## Insight Summary:
•	Time and seasonality are important. Factors such as holidays, dates (month, year, and quarter), and stores affect revenue growth for Walmart Inc.
•	The first linear regression model with economic/environmental factors explained 2.5% (R2) of the variation in weekly sales. After incorporating store, time, and holiday factors increased substantially to 93.7% (R2). 
•	Holidays weeks had approximately ~7.84% higher average sales than non-holiday weeks. Average weekly sales reached $1.12 million across all stores during holiday seasons from 2010-2012. Compared to non-holiday average weekly sales of $1.04 million during non-holiday weeks.
•	Store differences were substantial across 2010-2012. Store 20 had approximately $2.11 million in average weekly sales. While Store 33 had the lowest average weekly sales at approximately $259.8 thousand in average weekly sales.
•	Average weekly sales had a decrease of 1.27% from 2010-2011, and a 1.20% decline from 2011-2012.

## Dashboard (Power BI):



## Limitations: 
•	The dataset covers 2010-2012 making the conditions dated and does not accurately represent the current retail and economic conditions.
•	The analysis identifies associations rather than casual relationships. The higher sales observed during holidays do not establish holidays as a direct cause of the increase in weekly sales.
•	The available dataset does not cover potentially important factors such as region characteristics, population size, store size, and promotional spending.


## Methods Summary: 
To evaluate which factors influenced weekly sales for Walmart Inc. The analysis used the following methods:
PostgreSQL:
Analyzing Store Performance:
•	Clean the dataset in PostgreSQL (checking for blanks, nulls, and duplicates)
•	Perform descriptive statistics of weekly sales (MAX, MIN, and AVG)
•	Which stores performed the best in average weekly sales and vice versa
•	Which stores performed the best during holiday season?
Correlation Analysis of Economic and Environmental Factors (Numerical):
•	Analyze correlation between weekly sales and 4 factors:
a.	Weekly Sales vs. Unemployment
b.	Weekly Sales vs. CPI
c.	Weekly Sales vs. Fuel Price
d.	Weekly Sales vs. Temperature
Holiday, Store, and Date Factors Analysis:
•	Analyzed how spread out the weekly average sales are across stores.
•	Analyzed weekly sales during holidays vs. non-holidays.
•	Calculated the sales percentage difference in weekly average sales for holidays vs. non-holidays
Seasonality Analysis:
•	Analyzed monthly average sales
•	Analyzed quarterly average sales
•	Analyzed yearly average sales
•	Calculated the yearly change in total sales using LAG window function.

Python
Libraries: pandas, scipy.stats, and statsmodels
•	I prepared date to be split into three sections: yearly, monthly, and quarterly
•	I verified for any nulls or duplicates to verify csv file
•	I performed correlation analysis in python of CPI, fuel price, temperature, and unemployment vs. weekly sales.
•	I performed two sample T-test analysis on holiday sales vs. non-holiday sales to see if there is a noticeable difference in weekly average sales.
•	Built multiple linear regression models to evaluate the relationship between weekly sales in store, date, fuel price, holiday status, CPI, temperature, and unemployment.
Power BI:
•	Visualized average weekly sales by Holiday vs. Non-Holiday.
•	Visualized average weekly sales by store.
•	Visualized average weekly sales monthly.
•	Visualized average weekly sales on a yearly basis.
•	Created cards to highlight holiday sales lift.
•	Built an interactive dashboard to allow comparison of store and time-based performances.
