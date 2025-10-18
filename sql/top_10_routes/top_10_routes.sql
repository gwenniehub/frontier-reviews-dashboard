WITH route_stats AS (
  SELECT 
    o.city || ' → ' || d.city AS route,
    COUNT(*) AS num_reviews,
    ROUND(AVG(AVERAGE_RATING), 2) AS avg_rating
  FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED r
  JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_LOCATION o 
    ON r.origin_location_id = o.location_id
  JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_LOCATION d 
    ON r.destination_location_id = d.location_id
  WHERE r.airline = 'Frontier Airlines'
    AND o.city IS NOT NULL AND o.city <> 'Unknown'
    AND d.city IS NOT NULL AND d.city <> 'Unknown'
  GROUP BY o.city, d.city
)
SELECT *
FROM route_stats
ORDER BY num_reviews DESC
LIMIT 10;
