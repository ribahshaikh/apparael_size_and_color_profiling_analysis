-- Data Exploration and Basic Analysis
-- Retrieve Top 10 Records from the Table
SELECT *
FROM customer_purchases
LIMIT 10;

-- Distinct Items Purchased
SELECT DISTINCT Item_Purchased 
FROM customer_purchases;

-- Distinct Available Sizes
SELECT DISTINCT Size 
FROM customer_purchases;

-- Analyze the distribution of purchases across age groups:
SELECT 
    CASE 
        WHEN Age < 20 THEN 'Below 20'
        WHEN Age BETWEEN 20 AND 30 THEN '20-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        WHEN Age BETWEEN 51 AND 60 THEN '51-60'
        ELSE 'Above 60'
    END AS Age_Group,COUNT(*) AS Total_Purchases
FROM customer_purchases
GROUP BY Age_Group
ORDER BY Total_Purchases DESC;

-- Performance Analysis by Items
-- Items, total units sold and total revenue
SELECT DISTINCT Item_Purchased, Count(*) as Total_Units_Sold, SUM(Purchase_Amount_USD) as Total_Revenue
FROM customer_purchases
GROUP BY Item_Purchased
ORDER BY Total_Units_Sold DESC;

-- Size And Color Distribution
-- Size Distribution by Items Purchased
SELECT Item_Purchased, Size, COUNT(*) AS Total_Sold
FROM Customer_Purchases
GROUP BY Item_Purchased, Size
ORDER BY Total_Sold DESC;

-- Color Distribution by Items Purchased
SELECT Item_Purchased, Color, COUNT(*) AS Total_Sold
FROM Customer_Purchases
GROUP BY Item_Purchased, Color
ORDER BY Total_Sold DESC;

-- Seasonal Trends
-- Seasonal Trends based on Items and their colors
SELECT Season, Item_Purchased, Color, COUNT(*) AS Total_Sold
FROM Customer_Purchases
GROUP BY Season, Item_Purchased, Color
ORDER BY Total_Sold DESC;

-- Seasonal Analysis of Revenue
SELECT Season, SUM(Purchase_Amount_USD) AS Total_Revenue
FROM customer_purchases
GROUP BY Season
ORDER BY Total_Revenue DESC;

-- Performance by Size and Color
-- Size Performance by Item Purchased and Revenue
SELECT Item_Purchased, Size, COUNT(*) AS Total_Units_Sold, SUM(Purchase_Amount_USD) AS Total_Revenue
FROM Customer_Purchases
GROUP BY Item_Purchased, Size
ORDER BY Total_Revenue DESC;

-- Item Color Performance by Item Purchased and Revenue
SELECT Item_Purchased, Color, COUNT(*) AS Total_Units_Sold, SUM(Purchase_Amount_USD) AS Total_Revenue
FROM Customer_Purchases
GROUP BY Item_Purchased, Color
ORDER BY Total_Revenue DESC;

-- Ranking Based Insights
-- Retrieves the most popular size for each item based on the total units sold in each category.
WITH ranked_items AS (
			SELECT Item_Purchased, Size, COUNT(*) AS Total_Units_Sold,
				   DENSE_RANK() OVER(PARTITION BY Item_Purchased ORDER BY Count(*) DESC) AS drank
			FROM Customer_Purchases
			GROUP BY Item_Purchased, Size
)
SELECT Item_Purchased, Size, Total_Units_Sold
FROM ranked_items
WHERE drank=1
ORDER BY Total_Units_Sold DESC;

-- Retrieves the most popular color for each item based on the total units sold in each category.
WITH ranked_items AS (
			SELECT Item_Purchased, Color, COUNT(*) AS Total_Units_Sold,
				   DENSE_RANK() OVER(PARTITION BY Item_Purchased ORDER BY Count(*) DESC) AS drank
			FROM Customer_Purchases
			GROUP BY Item_Purchased, Color
)
SELECT Item_Purchased, Color, Total_Units_Sold
FROM ranked_items
WHERE drank=1
ORDER BY Total_Units_Sold DESC;

-- Retrieves the most popular color for each item within each season
WITH ranked_items AS (
			SELECT Season, Item_Purchased, Color, COUNT(*) AS Total_Units_Sold,
				   DENSE_RANK() OVER(PARTITION BY Season, Item_Purchased ORDER BY Count(*) DESC) AS drank
			FROM Customer_Purchases
			GROUP BY Season, Item_Purchased, Color
)
SELECT Season, Item_Purchased, Color, Total_Units_Sold
FROM ranked_items
WHERE drank=1
ORDER BY Total_Units_Sold DESC;








