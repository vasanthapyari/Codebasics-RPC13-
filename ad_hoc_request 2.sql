select 
      c.city_name,
      d.month_name,
      mtt.total_target_trips,
      count(trip_id) as actuval_trip,
      case
           when count(trip_id)>mtt.total_target_trips then "Above Target"
           else "Below Target"
	 end as perfoarmance_status,
     concat(round(((count(trip_id)-mtt.total_target_trips)*100/mtt.total_target_trips),2),"%") as pct_difference
from fact_trips ft
join dim_date d
     on ft.date=d.date
join dim_city c
     on ft.city_id = c.city_id
join targets_db.monthly_target_trips mtt
     on c.city_id=mtt.city_id and d.start_of_month=mtt.month
group by 
      c.city_name,d.month_name,mtt.total_target_trips
      