SELECT
   seat_type,
   COUNT(*) AS num_reviews,
   ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1) AS total_count
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
WHERE seat_type IS NOT NULL
GROUP BY seat_type
ORDER BY num_reviews DESC;
