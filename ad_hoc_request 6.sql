with cte1 as
(
select
     c.city_name,
     d.month_name,
     sum(total_passengers) as total_passengers,
     sum(repeat_passengers) as repeat_passengers,
     concat(round(sum(repeat_passengers)*100/sum(total_passengers),2),"%") as monthly_repeat_passengers
from 
     fact_passenger_summary p
join 
    dim_date d
on p.month=d.date
join 
    dim_city c 
on p.city_id=c.city_id
group by
  d.month_name,c.city_name
),
cte2 as
(
select 
      c.city_name,
      sum(total_passengers) as total_passengers,
     sum(repeat_passengers) as repeat_passengers,
     concat(round(sum(repeat_passengers)*100/sum(total_passengers),2),"%") as city_repeat_passengers
from
     fact_passenger_summary p
join
    dim_city c
on p.city_id= c.city_id
group by
      c.city_name
)
select
    a.city_name,
    a.month_name,
    a.repeat_passengers,
    a.total_passengers,
	a.monthly_repeat_passengers,
    b.city_repeat_passengers
from
    cte1 a 
join 
    cte2 b
on a.city_name=b.city_name
order by a.city_name ,a.month_name







