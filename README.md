# Frontier Airlines Analysis 
## 1. Overview 
- Scope: 3,000 Frontier Airlines reviews from 2015 to 2025, sourced from [AirlineQuality.com](https://www.airlinequality.com/airline-reviews/%7Bairline%E2%80%91slug%7D/) (Skytrax), covering multiple airlines.
- Goal: Identify what drives Frontier’s customer satisfaction and turn those insights into actionable improvements, benchmarked against other ULCCs for context.
- Key Insights:
  + Frontier’s overall sentiment is relatively weak: the average rating sits low, and the proportion of reviewers who would recommend the airline signals ample room for improvement.
  + In Economy, satisfaction is most strongly tied to Food & Beverages and Cabin Staff Service — passengers consistently cite those as differentiators.
  + In Non-Economy, Seat Comfort and Food & Beverages stand out: negative feedback in these areas correlates strongly with overall dissatisfaction.
  + When compared with other ULCCs, Frontier shows particular underperformance in the recommendation rate.

The dashboard can be accessed [here](https://github.com/gwenniehub/frontier-reviews-dashboard/blob/763b3ec97a55d5615f44b5d3a23badb80776a993/Frontier%20Dashboard.pdf).

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
  
<img width="608" height="411" alt="Screenshot 2025-10-02 at 21 21 26" src="https://github.com/user-attachments/assets/2914db60-a8f4-467d-8270-9499244aaaf9" />
