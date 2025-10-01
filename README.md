# Frontier Airlines Analysis 
## 1. Overview 
- Scope: 3,000 Frontier Airlines reviews from 2015 to 2025, sourced from [AirlineQuality.com](https://www.airlinequality.com/airline-reviews/%7Bairline%E2%80%91slug%7D/) (Skytrax), covering multiple airlines.
- Goal: Identify what drives Frontier’s customer satisfaction and turn those insights into actionable improvements, benchmarked against other ULCCs for context.
- Method:
  + SQL (Snowflake): Data extraction, cleaning, normalization, and preparation of the review dataset
  + Python (Pandas, Seaborn): Exploratory data analysis, per-route heatmaps, and feature importance
  + Mode Analytics: Interactive dashboards and visualizations.
- Key Insights:
  + Frontier’s overall sentiment is relatively weak: the average rating sits low, and the proportion of reviewers who would recommend the airline signals ample room for improvement.
  + In Economy, satisfaction is most strongly tied to Food & Beverages and Cabin Staff Service — passengers consistently cite those as differentiators.
  + In Non-Economy, Seat Comfort and Food & Beverages stand out: negative feedback in these areas correlates strongly with overall dissatisfaction.
  + When compared with other ULCCs, Frontier shows particular underperformance in the recommendation rate.
 
## 2. Dataset
2.1. Data Model (Star Schema)

- Dimension Tables

| Table              | Purpose                                                   |
|:-------------------|:----------------------------------------------------------|
| `dim_customer`     | Passenger information                                     |
| `dim_aircraft`     | Aircraft attributes                                       |
| `dim_location`     | Airport/city keys for origin, destination, transit        |
| `dim_date`         | Calendar table for submission & flight dates              |


- Fact Table
  + `fct_review_enriched` One row per review per flight with quantitative metrics
