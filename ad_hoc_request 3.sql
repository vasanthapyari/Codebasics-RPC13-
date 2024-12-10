
SELECT 
    c.city_name AS city,
    concat(round(SUM(CASE WHEN rt.trip_count = 2 THEN rt.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(rt.repeat_passenger_count), 0),2),"%") AS pct_2_trips,
    concat(round(SUM(CASE WHEN rt.trip_count = 3 THEN rt.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(rt.repeat_passenger_count), 0),2),"%") AS pct_3_trips,
    concat(round(SUM(CASE WHEN rt.trip_count = 4 THEN rt.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(rt.repeat_passenger_count), 0),2),"%") AS pct_4_trips,
    concat(round(SUM(CASE WHEN rt.trip_count = 5 THEN rt.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(rt.repeat_passenger_count), 0),2),"%") AS pct_5_trips,
    concat(round(SUM(CASE WHEN rt.trip_count = 6 THEN rt.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(rt.repeat_passenger_count), 0),2),"%") AS pct_6_trips,
    concat(round(SUM(CASE WHEN rt.trip_count = 7 THEN rt.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(rt.repeat_passenger_count), 0),2),"%") AS pct_7_trips,
    concat(round(SUM(CASE WHEN rt.trip_count = 8 THEN rt.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(rt.repeat_passenger_count), 0),2),"%") AS pct_8_trips,
    concat(round(SUM(CASE WHEN rt.trip_count = 9 THEN rt.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(rt.repeat_passenger_count), 0),2),"%") AS pct_9_trips,
    concat(round(SUM(CASE WHEN rt.trip_count = 10 THEN rt.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(rt.repeat_passenger_count), 0),2),"%") AS pct_10_trips
FROM 
    dim_repeat_trip_distribution rt
JOIN 
    dim_city c ON rt.city_id = c.city_id
GROUP BY 
    c.city_name
ORDER BY 
    c.city_name
