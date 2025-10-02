-- 1. Key metrics 
-- Value for Money 
SELECT
  ROUND(AVG(VALUE_FOR_MONEY),2) AS avg_value_for_money
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE airline = 'Frontier Airlines';
-- Seat Comfort
SELECT 
  ROUND(AVG(SEAT_COMFORT),2) AS avg_seat_comfort
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE airline = 'Frontier Airlines'; 
-- Food and Beverages
SELECT 
  ROUND(AVG(FOOD_AND_BEVERAGES),2) AS avg_food_and_beverages
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE airline = 'Frontier Airlines';
-- Cabin Staff Service 
SELECT 
  ROUND(AVG(CABIN_STAFF_SERVICE),2) AS avg_cabin_staff_service
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE airline = 'Frontier Airlines';
-- Inflight Entertainment 
SELECT 
  ROUND(AVG(INFLIGHT_ENTERTAINMENT),2) AS avg_inflight_entertainment
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE airline = 'Frontier Airlines';
-- Wifi and Connectivity 
SELECT 
  ROUND(AVG(WIFI_AND_CONNECTIVITY),2) AS avg_wifi_and_connectivity
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE airline = 'Frontier Airlines'
-- Inflight Service 
SELECT 
  ROUND(
    (AVG(seat_comfort)
    + AVG(cabin_staff_service)
    + AVG(food_and_beverages)
    + AVG(inflight_entertainment)
    + AVG(wifi_and_connectivity)
    ) / 5.0, 
    2
  ) AS avg_inflight_service_rating
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE airline = 'Frontier Airlines';

--2. Number of Reviews and Recommendation Rate 
SELECT
    d.CAL_YEAR,
    COUNT(*) AS total_reviews,
    SUM(CASE WHEN recommended = true THEN 1 ELSE 0 END) AS recommended_count,
    ROUND(SUM(CASE WHEN recommended = TRUE THEN 1 ELSE 0 END) / COUNT(*),2) AS recommendation_rate
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED AS fct
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_DATE AS d ON fct.DATE_SUBMITTED_ID=d.DATE_ID
WHERE airline = 'Frontier Airlines'
GROUP BY d.CAL_YEAR
ORDER BY d.CAL_YEAR;

--3.1. Seat Type and In-flight Service 
SELECT 
    SEAT_TYPE,
    ROUND(AVG(seat_comfort), 2)           AS avg_seat_comfort,
    ROUND(AVG(cabin_staff_service), 2)    AS avg_cabin_staff,
    ROUND(AVG(food_and_beverages), 2)     AS avg_food,
    ROUND(AVG(inflight_entertainment), 2) AS avg_entertainment,
    ROUND(AVG(wifi_and_connectivity), 2)  AS avg_wifi,
    ROUND(AVG(value_for_money), 2)        AS avg_value_for_money,
    ROUND(100.0 * AVG(CASE WHEN recommended = TRUE THEN 1 ELSE 0 END), 1) AS recommendation_rate_pct
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE seat_type IS NOT NULL
AND airline = 'Frontier Airlines'
GROUP BY seat_type; 

--3.2. Seat Type and Review Counts
SELECT 
    seat_type,
    COUNT(*) AS num_reviews,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1) AS total_count
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE seat_type IS NOT NULL
GROUP BY seat_type
ORDER BY num_reviews DESC;

--4.Customer Rating Band 
WITH cte AS (
SELECT
d.cal_year AS year,
r.rating_band
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED r
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_DATE d
ON r.date_submitted_id = d.date_id
WHERE r.airline = 'Frontier Airlines'
)
SELECT
year,
rating_band,
COUNT(*) AS review_count,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY year), 1) AS share_pct
FROM cte
GROUP BY year, rating_band, quarter
ORDER BY year,
CASE rating_band 
WHEN 'bad' THEN 1 
WHEN 'medium' THEN 2 
WHEN 'good' THEN 3 
END;

--5. Top 10 Routes
WITH route_stats AS ( 
SELECT o.city || ' → ' || d.city AS route,
COUNT(*) AS num_reviews,
ROUND(AVG(AVERAGE_RATING),2) AS avg_rating
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED r 
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_LOCATION o ON r.origin_location_id = o.location_id 
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_LOCATION d ON r.destination_location_id = d.location_id 
WHERE r.airline = 'Frontier Airlines' 
AND o.city IS NOT NULL AND o.city <> 'Unknown' 
AND d.city IS NOT NULL AND d.city <> 'Unknown' 
GROUP BY o.city, d.city ) SELECT * FROM route_stats 
ORDER BY num_reviews DESC LIMIT 10; 

--6. Aircraft Model and In-Flight Performance Metrics 
SELECT 
    b.aircraft_model,
    COUNT(*) AS review_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1) AS pct_count,
    ROUND(AVG(a.seat_comfort), 2)           AS avg_seat_comfort,
    ROUND(AVG(a.cabin_staff_service), 2)    AS avg_cabin_staff,
    ROUND(AVG(a.food_and_beverages), 2)     AS avg_food,
    ROUND(AVG(a.inflight_entertainment), 2) AS avg_entertainment,
    ROUND(AVG(a.wifi_and_connectivity), 2)  AS avg_wifi,
    ROUND(AVG(a.value_for_money), 2)        AS avg_value_for_money,
    ROUND(AVG(
        (a.seat_comfort + a.cabin_staff_service + a.food_and_beverages +
         a.inflight_entertainment + a.wifi_and_connectivity + a.value_for_money) / 6
    ), 2) AS avg_inflight_service_score
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED AS a
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRCRAFT AS b
    ON a.AIRCRAFT_ID = b.AIRCRAFT_ID
WHERE a.airline = 'Frontier Airlines'
GROUP BY b.aircraft_model
ORDER BY review_count DESC; 

--7. ULCCs Comparison (Frontier, Spirit, Allegiant)
SELECT
    d.CAL_YEAR,
    AIRLINE,
    COUNT(*) AS total_reviews,
    SUM(CASE WHEN recommended = true THEN 1 ELSE 0 END) AS recommended_count,
    ROUND(SUM(CASE WHEN recommended = TRUE THEN 1 ELSE 0 END) / COUNT(*),2) AS recommendation_rate
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED AS fct
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_DATE AS d ON fct.DATE_SUBMITTED_ID=d.DATE_ID
WHERE airline IN ('Frontier Airlines','Spirit Airlines','Allegiant Air')
GROUP BY d.CAL_YEAR, AIRLINE
ORDER BY d.CAL_YEAR;
