# Clothing Insights: Size and Color Trends Analysis

## Project Overview
The goal of this project is to provide a comprehensive analysis of size and color distribution across different items, locations, and seasons to inform inventory management, sales strategies, and marketing decisions. Using SQL, this project aims to derive key insights into product performance, customer preferences, and seasonal trends, ultimately enabling data-driven decisions to optimize inventory levels and improve revenue.

## Project Goal
This project targets the following insights:
1. **Size and Color Distribution by Items:** Analyze the popularity of sizes and colors across all items.
2. **Item Performance and Revenue Analysis:** Determine the total units sold and total revenue generated for each item.
3. **Seasonal Trends in Item and Color Sales:** Identify seasonal patterns in item sales and color preferences to optimize seasonal inventory planning.
4. **Top-Performing Sizes for Each Item:** Rank and identify the most popular size for each item based on the number of units sold.
5. **Top-Performing Colors for Each Item:** Identify the most popular colors for each item based on the total units sold and revenue.
6. **Seasonal Color Trends by Item:** Understand which colors perform best for each item during different seasons.

## SQL Scripts

### 1. Data Exploration and Basic Analysis
#### 1.1 Retrieve Top 10 Records from the Table
```sql
SELECT *
FROM customer_purchases
LIMIT 10;
```

#### 1.2 Distinct Items Purchased
```sql
SELECT DISTINCT Item_Purchased
FROM customer_purchases;
```

#### 1.3 Distinct Sizes Available
```sql
SELECT DISTINCT Size 
FROM customer_purchases;
```

#### 1.4 Analyze the distribution of purchases across age groups
```sql
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
```

### 2. Performance Analysis by Items
#### 2.1 Items, Total Units Sold, and Total Revenue
```sql
SELECT DISTINCT Item_Purchased, Count(*) as Total_Units_Sold, SUM(Purchase_Amount_USD) as Total_Revenue
FROM customer_purchases
GROUP BY Item_Purchased
ORDER BY Total_Units_Sold DESC;
```

### 3. Size And Color Distribution
#### 3.1 Size Distribution by Items Purchased
```sql
SELECT Item_Purchased, Size, COUNT(*) AS Total_Sold
FROM Customer_Purchases
GROUP BY Item_Purchased, Size
ORDER BY Total_Sold DESC;
```

#### 3.2 Color Distribution by Items Purchased
```sql
SELECT Item_Purchased, Color, COUNT(*) AS Total_Sold
FROM Customer_Purchases
GROUP BY Item_Purchased, Color
ORDER BY Total_Sold DESC;
```

### 4. Seasonal Trends
#### 4.1 Seasonal Trends based on Items and their colors
```sql
SELECT Season, Item_Purchased, Color, COUNT(*) AS Total_Sold
FROM Customer_Purchases
GROUP BY Season, Item_Purchased, Color
ORDER BY Total_Sold DESC;
```

#### 4.2 Seasonal Revenue Analysis 
```sql
SELECT Season, SUM(Purchase_Amount_USD) AS Total_Revenue
FROM customer_purchases
GROUP BY Season
ORDER BY Total_Revenue DESC;
```

### 5. Performance by Size and Color
#### 5.1 Size Performance by Item Purchased and Revenue
```sql
SELECT Item_Purchased, Size, COUNT(*) AS Total_Units_Sold, SUM(Purchase_Amount_USD) AS Total_Revenue
FROM Customer_Purchases
GROUP BY Item_Purchased, Size
ORDER BY Total_Revenue DESC;
```

#### 5.2 Item Color Performance by Item Purchased and Revenue
```sql
SELECT Item_Purchased, Color, COUNT(*) AS Total_Units_Sold, SUM(Purchase_Amount_USD) AS Total_Revenue
FROM Customer_Purchases
GROUP BY Item_Purchased, Color
ORDER BY Total_Revenue DESC;
```

### 6. Ranking Based Insights
#### 6.1 Most Popular Size for Each Item
```sql
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
```

#### 6.2 Most Popular Color for Each Item
```sql
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
```

#### 6.3 Most Popular Color for Each Item Within Each Season
```sql
WITH ranked_items AS (
			SELECT Season, Item_Purchased, Color, COUNT(*) AS Total_Units_Sold,
				   DENSE_RANK() OVER(PARTITION BY Season, Item_Purchased ORDER BY Count(*) DESC) AS drank
			FROM Customer_Purchases
			GROUP BY Season, Item_Purchased, Color
)
SELECT Season, Item_Purchased, Color, Total_Units_Sold, drank
FROM ranked_items
WHERE drank=1
ORDER BY Total_Units_Sold DESC;
```

## Findings
1. **Item List:** Sweater, Jeans, Shirt, Shorts, Pants, Jacket, Hoodie, T-shirt
2. **Sizes Available:** S, M, L, XL
3. **Shirts generated the highest revenue ($10,332) despite Pants being the most sold item (171 units), indicating that revenue per unit for Shirts is higher compared to other items.**
4. **Size M is the most popular size across different items, with Shirts (86 units) and Jackets (82 units) being the highest-selling items in this size, showing a clear preference for Size M in the majority of the top-selling categories.**
5. **Pink Hoodies and Yellow Shorts are the top-selling color-item combinations, with 13 units each sold, suggesting that these specific color choices are highly favored by customers for these items.**
6. **Winter generated the highest revenue ($20,187), followed by Fall ($19,358) and Spring ($19,102), while Summer ($15,482) had the lowest revenue. This indicates a peak in sales during colder seasons.**
7. **Size M is the most popular size across multiple items, with Shirts (86 units) leading the list, followed closely by Jackets (82 units) and Pants (80 units). This indicates a strong preference for Size M among customers, making it a key size to focus on for inventory planning.**
8. **The results show that Cyan Pants and Blue Jackets dominate the Fall season, while Pink Hoodies and Yellow Shorts remain popular in both Winter and Fall. Seasonal color preferences are evident, with diverse choices like Cyan Jackets in Spring, suggesting the importance of aligning color offerings with seasonal demand trends.**

## Conclusion
The analysis of clothing sales data reveals key insights into customer preferences, highlighting the significance of size and color trends across different items and seasons. 
Size M emerged as the most popular size, with strong sales across various items, making it essential for inventory optimization. 
In terms of colors, specific color-item combinations like Pink Hoodies and Yellow Shorts showed consistent demand, indicating the need to stock these popular variants. 
Furthermore, seasonal analysis demonstrated that colder seasons, particularly Winter, generate the highest revenue, driven by a clear preference for specific items and colors like Cyan Pants and Blue Jackets in Fall. 
These findings underscore the importance of aligning inventory and marketing strategies with customer preferences for size, color, and seasonality, enabling more informed decision-making to boost sales and enhance customer satisfaction.













