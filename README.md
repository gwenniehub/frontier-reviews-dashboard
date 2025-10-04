# Frontier Airlines Analysis 
---
## 1. Overview 
- Scope: 3,000 Frontier Airlines reviews from 2015 to 2025, sourced from [AirlineQuality.com](https://www.airlinequality.com/airline-reviews/%7Bairline%E2%80%91slug%7D/) (Skytrax), covering multiple airlines.
- Goal: Identify what drives Frontier’s customer satisfaction and turn those insights into actionable improvements, benchmarked against other ULCCs for context.

The dashboard can be accessed [here](https://github.com/gwenniehub/frontier-reviews-dashboard/blob/763b3ec97a55d5615f44b5d3a23badb80776a993/Frontier%20Dashboard.pdf).

---

## 2. Team and Pipeline Overview
This project was developed through close collaboration among a diverse data team, each member contributing a specialized role within the end-to-end analytics pipeline. The data engineering team designed and maintained the extraction layer, automating the collection of Skytrax reviews through web scraping pipelines and ensuring the data was properly staged in cloud storage. The data modeling team took responsibility for transforming raw data into structured, reliable models using dbt, implementing data quality checks and schema validation to support analysis at scale.

The data analytics team built upon these models to conduct exploratory and statistical analysis, transforming complex datasets into actionable insights that reveal airline performance patterns and customer experience trends. Complementing this, the visualization and dashboard team focused on presenting these insights through an interactive front-end interface, enabling users to navigate key metrics and uncover service quality indicators.

I contributed as part of the data analytics team, focusing on exploratory data analysis, querying transformed datasets, and generating insights that supported visualization and strategic recommendations. This collaborative workflow reflects a real-world data environment—where engineers, modelers, analysts, and visualization specialists work together seamlessly to deliver a cohesive, insight-driven analysis.

For a comprehensive explanation of the ELT pipeline and its workflow, refer to this repo [skytrax_reviews](https://github.com/MarkPhamm/skytrax_reviews.git)

---

## 3. Architect Overview 
  <img width="827" height="288" alt="Screenshot 2025-10-04 at 12 35 45" src="https://github.com/user-attachments/assets/940c8d58-fd6f-41d1-87e2-f03110eb8113" />

### **3.1. Extraction Layer**
The extraction layer automates the process of collecting, cleaning, and staging Skytrax review data for analysis. It integrates multiple technologies to ensure data reliability, scalability, and security.  

**Key Technologies:**  
- **Python & Pandas** – for web scraping, parsing, and initial data handling  
- **Apache Airflow** – to orchestrate and schedule ETL tasks  
- **AWS S3** – for cloud-based data storage and versioning  
- **Docker** – to containerize and deploy workflows consistently  
- **Snowflake** – as the data warehouse for downstream transformation  

**Workflow Summary:**  
1. **Scraping:** Iterates through the Skytrax airline index, retrieves paginated review pages, and extracts structured fields (ratings, comments, flight details, passenger metadata, and category-specific scores).  
2. **Cleaning:** Standardizes date formats, handles nulls, and enforces consistent schema and data types using Python scripts.  
3. **Staging:** Uploads cleaned data to AWS S3 with IAM-based access control, encryption, and versioning.  
4. **Loading to Warehouse:** Copies cleaned datasets from S3 to Snowflake using the `snowflake_copy_from_s3` operator.  
5. **Task Orchestration:** Airflow DAG manages dependencies in this order 
   `scrape_skytrax_data → clean_data → upload_cleaned_data_to_s3 → snowflake_copy_from_s3`.


### 3.2. Data Cleaning Layer

This layer refines raw review data to ensure consistency and readiness for transformation.  

**Stack:** Python 3.12.5, Pandas, NumPy, Matplotlib, Seaborn  

**Key Steps:**  
- Column standardization - snake_case, special-character cleanup
- Date formatting - ISO 8601 for submission and flight dates
- Text cleaning - verification flag extraction, nationality normalization
- Route parsing - origin, destination, and connections
- Aircraft standardization - unified Airbus/Boeing naming
- Rating conversion - numeric Int64 fields for analysis

Cleaned outputs feed directly into Snowflake for transformation.

### **3.3. Transformation Layer**

This layer transforms cleaned data into structured models to support analytics and reporting.  

**Stack:** dbt (Core), Snowflake, Airflow, GitHub Actions  

**Data model**

<img width="608" height="411" alt="Screenshot 2025-10-02 at 21 21 26" src="https://github.com/user-attachments/assets/2914db60-a8f4-467d-8270-9499244aaaf9" />
    
- Dimension Tables

| Table              | Purpose                                                   |
|:-------------------|:----------------------------------------------------------|
| `dim_customer`     | Passenger information                                     |
| `dim_aircraft`     | Aircraft attributes                                       |
| `dim_location`     | Airport/city keys for origin, destination, transit        |
| `dim_date`         | Calendar table for submission & flight dates              |

- Fact Table
  + `fct_review_enriched` One row per review per flight with quantitative metrics
Incremental dbt jobs maintain data freshness and minimize warehouse cost 
  
**Data Quality Framework:**  
- Schema and relationship tests
- Custom business-logic assertions (e.g., ratings within 0–10)
- Freshness/completeness checks.
CI/CD triggers on code pushes, PRs, weekly runs, and manual executions

---

## 4. Frontier Airlines Analysis & Visualization
### **4.1. Stack**
- SQL (Snowflake): Data cleaning, preparation, and exploratory analysis
- Python (Matplotlib, Seaborn): Visualizations (e.g., heatmaps) and exploratory analysis
- Mode Analytics: SQL/Python integration and interactive dashboards
- GitHub: Version control and documentation

### **4.2. Workflow**

**4.2.1. Data Extraction (Snowflake)**
- Queried 121K+ Skytrax airline reviews stored in Snowflake
- Filtered 3K+ Frontier Airlines records
- Applied SQL joins, CTEs, and window functions to clean, normalize, and prepare structured datasets
  
**4.2.2. Integration (Mode Analytics)**
- Connected Snowflake directly to Mode Analytics for real-time querying
- Combined SQL and Python within Mode for exploratory data analysis (EDA)

**4.2.3. Exploratory Data Analysis (EDA)**
- Used SQL to identify key service metrics (seat comfort, cabin staff, food, Wi-Fi)
- Applied Python (Matplotlib, Seaborn) to generate trend visualizations, including heatmaps for satisfaction drivers

**4.2.4. Visualization & Insights**
- Built interactive dashboards in Mode Analytics to highlight customer pain points and route-based performance differences
- Designed visuals for comparative analysis across service categories

**4.2.5 Version Control & Documentation (GitHub)**
- Documented SQL scripts, Python notebooks, schema diagrams, and dashboard outputs in GitHub
- Used GitHub for version control, collaboration, and project presentation

---

## 5. Key Insights
- Frontier’s overall sentiment is relatively weak: the average rating is low, and the proportion of reviewers who would recommend the airline signals improvement regarding customer service.
- In Economy, satisfaction is most strongly tied to Food & Beverages and Cabin Staff Service, passengers consistently cite those as differentiators.
- In Non-Economy, Seat Comfort and Food & Beverages stand out: negative feedback in these areas correlates strongly with overall dissatisfaction.
- When compared with other ULCCs, Frontier shows particular underperformance in the recommendation rate.

---

## 6. Recommendations

### **6.1 Seat Type** 

<img width="755" height="574" alt="Screenshot 2025-10-02 at 21 47 55" src="https://github.com/user-attachments/assets/5eec8f28-5221-4e3e-a61d-6f5d73957fdc" /> 

- Prioritize service enhancements in Economy Class, especially around Entertainment and Seat Comfort, since this class represents the majority of reviews and customer base
- Reevaluate investment in First Class, as demand is low compared to other segments, suggesting opportunities to optimize costs or reallocate resources


### **6.2 Aircraft Model**

<img width="989" height="745" alt="Screenshot 2025-10-03 at 15 31 16" src="https://github.com/user-attachments/assets/f84d53da-1acb-45ac-a9f1-2164068e8f83" />

- Low sample size limits the reliability of review accuracy
- Aircraft type shows minimal impact on customer satisfaction; focus should shift to other service dimensions

### **6.3 Comparisons among ULCCs**

<img width="984" height="388" alt="Screenshot 2025-10-03 at 15 36 14" src="https://github.com/user-attachments/assets/5233474c-90cb-4e4b-8574-b276550c6834" />

- Airlines in the same price range deliver higher customer satisfaction, giving them a competitive advantage, while many Frontier customers feel the value does not match the price paid
- Frontier should prioritize improving key service metrics to enhance perceived value and close this competitive gap

--- 

## 7. Reflections 


