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
