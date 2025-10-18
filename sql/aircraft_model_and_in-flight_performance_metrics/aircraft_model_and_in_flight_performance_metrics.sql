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
WHERE airline = 'Frontier Airlines';

-- Inflight Service Rating (composite average)
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
