CREATE DATABASE FinanceAnalytics;
GO
USE FinanceAnalytics;
GO

SELECT TOP 10 *
FROM [dbo].[Financial Risk- Dataset];

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT company_id) AS Unique_Companies,
    COUNT(DISTINCT country) AS Total_Countries,
    COUNT(DISTINCT industry) AS Total_Industries,
    MIN(year) AS First_Year,
    MAX(year) AS Last_Year
FROM [dbo].[Financial Risk- Dataset];

SELECT
    SUM(CASE WHEN company_id IS NULL THEN 1 ELSE 0 END) AS Missing_Company_ID,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS Missing_Country,
    SUM(CASE WHEN industry IS NULL THEN 1 ELSE 0 END) AS Missing_Industry,
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS Missing_Year,
    SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS Missing_Revenue,
    SUM(CASE WHEN profit_margin IS NULL THEN 1 ELSE 0 END) AS Missing_Profit_Margin,
    SUM(CASE WHEN debt_ratio IS NULL THEN 1 ELSE 0 END) AS Missing_Debt_Ratio
FROM [dbo].[Financial Risk- Dataset];

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT CONCAT(
        company_id, '|', country, '|', industry, '|', year
    )) AS Unique_Company_Year_Records
FROM [dbo].[Financial Risk- Dataset];

SELECT
    MIN(revenue) AS Min_Revenue,
    MAX(revenue) AS Max_Revenue,
    MIN(profit_margin) AS Min_Profit_Margin,
    MAX(profit_margin) AS Max_Profit_Margin,
    MIN(debt_ratio) AS Min_Debt_Ratio,
    MAX(debt_ratio) AS Max_Debt_Ratio,
    MIN(default_probability) AS Min_Default_Probability,
    MAX(default_probability) AS Max_Default_Probability
FROM [dbo].[Financial Risk- Dataset];

SELECT
    credit_rating,
    COUNT(*) AS Employee_Records
FROM [dbo].[Financial Risk- Dataset]
GROUP BY credit_rating
ORDER BY Employee_Records DESC;

SELECT
    MIN(bankruptcy_risk_score) AS Min_Risk_Score,
    MAX(bankruptcy_risk_score) AS Max_Risk_Score
FROM [dbo].[Financial Risk- Dataset];

SELECT
    year,
    COUNT(*) AS Record_Count,
    ROUND(AVG(revenue), 2) AS Avg_Revenue,
    ROUND(AVG(profit_margin), 4) AS Avg_Profit_Margin,
    ROUND(AVG(debt_ratio), 4) AS Avg_Debt_Ratio,
    ROUND(AVG(default_probability), 4) AS Avg_Default_Probability
FROM [dbo].[Financial Risk- Dataset]
GROUP BY year
ORDER BY year;

SELECT
    industry,
    COUNT(*) AS Record_Count,
    ROUND(AVG(revenue), 2) AS Avg_Revenue,
    ROUND(AVG(profit_margin), 4) AS Avg_Profit_Margin,
    ROUND(AVG(debt_ratio), 4) AS Avg_Debt_Ratio,
    ROUND(AVG(bankruptcy_risk_score), 2) AS Avg_Bankruptcy_Risk,
    ROUND(AVG(default_probability), 4) AS Avg_Default_Probability
FROM [dbo].[Financial Risk- Dataset]
GROUP BY industry
ORDER BY Avg_Default_Probability DESC;

SELECT
    country,
    COUNT(*) AS Record_Count,
    ROUND(AVG(revenue), 2) AS Avg_Revenue,
    ROUND(AVG(debt_ratio), 4) AS Avg_Debt_Ratio,
    ROUND(AVG(default_probability), 4) AS Avg_Default_Probability
FROM [dbo].[Financial Risk- Dataset]
GROUP BY country
ORDER BY Avg_Default_Probability DESC;

SELECT TOP 10
    company_id,
    country,
    industry,
    year,
    revenue,
    profit_margin,
    debt_ratio,
    bankruptcy_risk_score,
    default_probability
FROM [dbo].[Financial Risk- Dataset]
ORDER BY bankruptcy_risk_score DESC;

SELECT
    CASE
        WHEN bankruptcy_risk_score >= 50 THEN 'High Risk'
        WHEN bankruptcy_risk_score >= 25 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Category,
    COUNT(*) AS Record_Count,
    ROUND(AVG(revenue), 2) AS Avg_Revenue,
    ROUND(AVG(profit_margin), 4) AS Avg_Profit_Margin,
    ROUND(AVG(debt_ratio), 4) AS Avg_Debt_Ratio,
    ROUND(AVG(default_probability), 4) AS Avg_Default_Probability
FROM [dbo].[Financial Risk- Dataset]
GROUP BY
    CASE
        WHEN bankruptcy_risk_score >= 50 THEN 'High Risk'
        WHEN bankruptcy_risk_score >= 25 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END
ORDER BY Avg_Default_Probability DESC;

SELECT
    credit_rating,
    COUNT(*) AS Record_Count,
    ROUND(AVG(profit_margin), 4) AS Avg_Profit_Margin,
    ROUND(AVG(debt_ratio), 4) AS Avg_Debt_Ratio,
    ROUND(AVG(default_probability), 4) AS Avg_Default_Probability
FROM [dbo].[Financial Risk- Dataset]
GROUP BY credit_rating
ORDER BY Avg_Default_Probability DESC;

WITH CountryRisk AS (
    SELECT
        country,
        ROUND(AVG(default_probability), 4) AS Avg_Default_Probability
    FROM [dbo].[Financial Risk- Dataset]
    GROUP BY country
)
SELECT
    country,
    Avg_Default_Probability,
    RANK() OVER (
        ORDER BY Avg_Default_Probability DESC
    ) AS Risk_Rank
FROM CountryRisk
ORDER BY Risk_Rank;