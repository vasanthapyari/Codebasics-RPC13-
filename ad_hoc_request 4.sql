with city_newpassenger as
  (
     select
		  c.city_name,
		  sum(new_passengers) as total_new_passengers
     from fact_passenger_summary ps
     join dim_city c
     on ps.city_id=c.city_id
	 group by c.city_name
  ),
city_ranking as
    ( 
       select
			  city_name,
			  total_new_passengers,
			  rank()over(order by total_new_passengers desc ) as rank_desc,
			  rank() over(order by total_new_passengers asc) as rank_asc
	   from city_newpassenger)
select
     city_name,
     total_new_passengers,
     case
         when rank_desc<=3 then "Top 3"
         when rank_asc <=3 then "Bottom 3"
         else null
	end as category
from city_ranking
where rank_desc <= 3 OR rank_asc <= 3
ORDER BY 
    category, rank_desc;