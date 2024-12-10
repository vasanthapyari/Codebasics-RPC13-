with cte1 as
(
select 
      c.city_name,
      d.month_name,
	  sum(fare_amount) as monthly_revenue
from 
    fact_trips t
join
    dim_date d
on  t.date = d.date
join 
    dim_city c
on t.city_id=c.city_id
group by 
     d.month_name,c.city_name
),
cte2 as
(
 select
       c.city_name,
       sum(fare_amount) as total_revenue
from 
    fact_trips t
join
    dim_city c
on t.city_id=c.city_id
group by
      c.city_name
      
),
cte3 as
(
select
      a.city_name,
      a.month_name,
      a.monthly_revenue,
      b.total_revenue,
      rank() over(partition by a.city_name order by a.monthly_revenue  desc) as rank_order
      
from 
    cte1 a
    join cte2 b
      on a.city_name=b.city_name
)
select
    city_name,
    month_name,
    monthly_revenue,
    concat(round(monthly_revenue*100/total_revenue,2),"%")  as percent_cotribution
from
    cte3 
where rank_order=1
order by 
    city_name






















     
    
     