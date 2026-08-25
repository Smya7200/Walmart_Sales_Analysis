import pandas as pd

#read shape of data to verify:
df = pd.read_csv(r"C:\Users\smya7\Downloads\SQL Walmart Portfolio Project Scripts\walmart_sales_clean.csv")
print(df.head())
print(df.info())
print(df.shape)

#verify for any nulls or duplicated values = 0:
print(df.isnull().sum())
print(df.duplicated().sum())

#Prepare date:
print(df.columns.tolist())
df["Date"] =pd.to_datetime(df["Date"])

df["Year"] = df["Date"].dt.year
df["Month"] = df["Date"].dt.month
df["Quarter"] = df["Date"].dt.quarter

print(df[["Date", "Year", "Month", "Quarter"]].head())

print("-------------------------------------------------")

#Correlation Analysis Review (Make sure correaltions are correct, and are exact to SQL):
correlations = df[
    ["Weekly_Sales", "Unemployment", "Fuel_Price", "CPI", "Temperature"]
].corr().round(2)
print(correlations["Weekly_Sales"].sort_values(ascending=False))

#finding p value
from scipy.stats import ttest_ind

holiday_sales = df[df["Holiday_Flag"] == 1]["Weekly_Sales"]
non_holiday_sales = df[df["Holiday_Flag"] == 0]["Weekly_Sales"]

test = ttest_ind(
    holiday_sales,
    non_holiday_sales,
    equal_var=False,
)

print(f"t-statistic: {test.statistic:.2f}")
print(f"p-value: {test.pvalue:.2f}")
print("-------------------------------------")
from scipy.stats import f_oneway
#Testing Store differences in Weekly_Sales
store_groups = [
    group["Weekly_Sales"].values
    for _, group in df.groupby("Store")
]

anova_result = f_oneway(*store_groups)

print(f"F-statistic: {anova_result.statistic:.3f}")
print(f"p-value: {anova_result.pvalue:.3f}")
print("------------------------------------")

#Multiple Regression:
import statsmodels.formula.api as smf

model = smf.ols(
    "Weekly_Sales ~ Unemployment + Fuel_Price + CPI + Temperature + Holiday_Flag",
    data=df
).fit()

print(model.summary())

print("-------------------------------")

model_2 = smf.ols(
    "Weekly_Sales ~ C(Store) + Unemployment + Fuel_Price + CPI + Temperature + Holiday_Flag",
    data=df
).fit()

print(model_2.summary())
print("--------------------------------------")

model_3 = smf.ols(
    "Weekly_Sales ~ C(Store) + C(Month) + C(Year)+ Unemployment + Fuel_Price + CPI + Temperature + Holiday_Flag",
    data=df
).fit()

print(model_3.summary())