select 
        c.city_name,
	  count(trip_id) as total_trips,
      round( sum(fare_amount)/sum(distance_travelled_km),2) as avg_fare_per_km,
      round( sum(fare_amount)/(count(trip_id)),2) as avg_fare_per_trip,
	  concat(round((COUNT(trip_id) * 100.0 / SUM(COUNT(trip_id))over()),2), "%") as percentage_contribution
from  
     fact_trips t
join 
     dim_city c 
  on t.city_id= c.city_id
group by  
     c.city_name
