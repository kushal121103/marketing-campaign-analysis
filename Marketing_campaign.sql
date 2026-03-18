USE [marketing campaign]
GO
--1>)Checking Dataset
SELECT * FROM [dbo].[marketing_campaign]


--2)Removing unnecessary columns
ALTER TABLE [dbo].[marketing_campaign]
DROP COLUMN Z_CostContact, Z_Revenue;

--3)Checking missing values
SELECT * FROM [dbo].[marketing_campaign]
WHERE income IS NULL 

DELETE FROM [dbo].[marketing_campaign]
WHERE income IS NULL

SELECT * FROM [dbo].[marketing_campaign]
WHERE income IS NULL

--4)Which Product Category Generates the Most Revenue
SELECT 
SUM(MntWines) AS Wine_Revenue,
SUM(MntFruits) AS Fruit_Revenue,
SUM(MntMeatProducts) AS Meat_Revenue,
SUM(MntFishProducts) AS Fish_Revenue,
SUM(MntSweetProducts) AS Sweet_Revenue,
SUM(MntGoldProds) AS Gold_Revenue
FROM [dbo].[marketing_campaign];


--5)Most Popular Purchase Channel
SELECT 
SUM(NumWebPurchases) AS Web_Purchases,
SUM(NumCatalogPurchases) AS Catalog_Purchases,
SUM(NumStorePurchases) AS Store_Purchases
FROM [dbo].[marketing_campaign];


--6)Marketing Campaign Response Rate
SELECT 
COUNT(*) AS Total_Customers,
SUM(CAST(Response AS INT)) AS Total_Responses,
(SUM(CAST(Response AS INT))*100.0/COUNT(*)) AS Response_Rate
FROM [dbo].[marketing_campaign];


--7)Which Income Group Spends the Most
SELECT 
CASE 
WHEN Income < 30000 THEN 'Low Income'
WHEN Income BETWEEN 30000 AND 60000 THEN 'Middle Income'
ELSE 'High Income'
END AS Income_Group,
AVG(
MntWines +
MntFruits +
MntMeatProducts +
MntFishProducts +
MntSweetProducts +
MntGoldProds
) AS Avg_Spending
FROM [dbo].[marketing_campaign]
GROUP BY 
CASE 
WHEN Income < 30000 THEN 'Low Income'
WHEN Income BETWEEN 30000 AND 60000 THEN 'Middle Income'
ELSE 'High Income'
END
ORDER BY Avg_Spending DESC;


--8)Which Age Group Spends the Most
SELECT 
CASE 
WHEN (2026 - Year_Birth) < 30 THEN 'Under 30'
WHEN (2026 - Year_Birth) BETWEEN 30 AND 45 THEN '30-45'
WHEN (2026 - Year_Birth) BETWEEN 46 AND 60 THEN '46-60'
ELSE '60+'
END AS Age_Group,
AVG(
MntWines +
MntFruits +
MntMeatProducts +
MntFishProducts +
MntSweetProducts +
MntGoldProds
) AS Avg_Spending
FROM [dbo].[marketing_campaign]
GROUP BY 
CASE 
WHEN (2026 - Year_Birth) < 30 THEN 'Under 30'
WHEN (2026 - Year_Birth) BETWEEN 30 AND 45 THEN '30-45'
WHEN (2026 - Year_Birth) BETWEEN 46 AND 60 THEN '46-60'
ELSE '60+'
END
ORDER BY Avg_Spending DESC;


--9)Which Marital Status Group Spends the Most
SELECT 
Marital_Status,
AVG(
MntWines +
MntFruits +
MntMeatProducts +
MntFishProducts +
MntSweetProducts +
MntGoldProds
) AS Avg_Spending
FROM [dbo].[marketing_campaign]
GROUP BY Marital_Status
ORDER BY Avg_Spending DESC;


--10)Which Education Level Has Highest Income
SELECT 
Education,
AVG(Income) AS Avg_Income
FROM [dbo].[marketing_campaign]
GROUP BY Education
ORDER BY Avg_Income DESC;



--11)Do Customers With Kids Spend Less
SELECT 
Kidhome,
AVG(
MntWines +
MntFruits +
MntMeatProducts +
MntFishProducts +
MntSweetProducts +
MntGoldProds
) AS Avg_Spending
FROM [dbo].[marketing_campaign]
GROUP BY Kidhome
ORDER BY Avg_Spending DESC;



--12)Which Campaign Was Most Successful
SELECT 
SUM(CAST(AcceptedCmp1 AS INT)) AS Campaign1,
SUM(CAST(AcceptedCmp2 AS INT)) AS Campaign2,
SUM(CAST(AcceptedCmp3 AS INT)) AS Campaign3,
SUM(CAST(AcceptedCmp4 AS INT)) AS Campaign4,
SUM(CAST(AcceptedCmp5 AS INT)) AS Campaign5
FROM [dbo].[marketing_campaign];


--13)Top 10 Highest Spending Customers
SELECT TOP 10
ID,
Income,
(MntWines +
MntFruits +
MntMeatProducts +
MntFishProducts +
MntSweetProducts +
MntGoldProds) AS Total_Spending
FROM [dbo].[marketing_campaign]
ORDER BY Total_Spending DESC;


--14)Website Visits vs Purchases
SELECT 
AVG(NumWebVisitsMonth) AS Avg_Web_Visits,
AVG(NumWebPurchases) AS Avg_Web_Purchases
FROM [dbo].[marketing_campaign];


--15)Most Recent Customers
SELECT TOP 20
ID,
Recency
FROM [dbo].[marketing_campaign]
ORDER BY Recency ASC;