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
