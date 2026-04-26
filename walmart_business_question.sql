elect * from walmart_data
--qustion no 1
select 
payment_method,
count(*) as total_transacations,
sum(quantity) as total_quantity
from walmart_data
group by 1;

--question no 2
select 
branch,
category,
round(avg(rating)::numeric,2) as avg_rating
from walmart_data
group by 1,2
order by 1,3 desc;

--question no 3
select * from
  (select
branch,
to_char(to_date(date,'dd,mm,yy'),'DAY') as day,
rank() over (partition by branch order by count(*) desc) as rank,
count(*) 
from walmart_data
group by 1,2)
where rank=1;


--question no 4
select 
payment_method,
sum(quantity)
from walmart_data
group by 1 order by 2 desc

--question no 5
select 
city,
category,
max(rating) as maximun_rating,
min(rating) as minimum_rating,
round(avg(rating)::numeric,2) as avg_rating
from walmart_data
group by 1,2
order by 1

--question no 5

select category,
round(sum(total)::numeric,0) as total_revenue,
round(sum(total*profit_margin)::numeric,0) as total_profit
from walmart_data group by 1


--question no 7
select * from
(select
branch,
payment_method,
count(*),
rank()over(partition by branch order by count(*) desc) as rank
from walmart_data 
group by 1,2)
where rank =1;

--question no 8
SELECT 
branch,
case when extract(hour from (time::time))<12 then 'MORNING'
when extract (hour from (time::time)) between 12 and 17 then 'AFTERNOON'
else 'EVENING'
end shift,
count(*) as total_order
FROM WALMART_DATA
group by 1,2
order by 1,3 desc

--question no 9
with sale_2022 as (
select 
branch,
sum(total) as revenue
from walmart_data
where extract(year  from to_date(date,'dd,mm,yy') )=2022
group by 1),
sale_2023 AS 
(select 
branch,
sum(total) as revenue
from walmart_data
where extract(year  from to_date(date,'dd,mm,yy') )=2023
group by 1)
select ly.branch,
ly.revenue as last_year,cy.revenue as current_year,
round((ly.revenue-cy.revenue)::numeric/ly.revenue::numeric*100,2) as decrease_ratio
FROM sale_2022 as ly inner join sale_2023 as cy
on ly.branch=cy.branch
where ly.revenue>cy.revenue
order by 1;



































