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

## 3. Tech Stack and Workflow
**3.1 Technology Stack**
- SQL (Snowflake): Data cleaning, preparation, and exploratory analysis
- Python (Matplotlib, Seaborn): Visualizations (e.g., heatmaps) and exploratory analysis
- Mode Analytics: SQL/Python integration and interactive dashboards
- GitHub: Version control and documentation

**3.2 Workflow**

**3.2.1. Data Extraction (Snowflake)**
- Queried 121K+ Skytrax airline reviews stored in Snowflake
- Filtered 3K+ Frontier Airlines records
- Applied SQL joins, CTEs, and window functions to clean, normalize, and prepare structured datasets
  
**3.2.2. Integration (Mode Analytics)**
- Connected Snowflake directly to Mode Analytics for real-time querying
- Combined SQL and Python within Mode for exploratory data analysis (EDA)

**3.2.3. Exploratory Data Analysis (EDA)**
- Used SQL to identify key service metrics (seat comfort, cabin staff, food, Wi-Fi)
- Applied Python (Matplotlib, Seaborn) to generate trend visualizations, including heatmaps for satisfaction drivers

**3.2.4. Visualization & Insights**
- Built interactive dashboards in Mode Analytics to highlight customer pain points and route-based performance differences
- Designed visuals for comparative analysis across service categories

**3.2.5 Version Control & Documentation (GitHub)**
- Documented SQL scripts, Python notebooks, schema diagrams, and dashboard outputs in GitHub
- Used GitHub for version control, collaboration, and project presentation


