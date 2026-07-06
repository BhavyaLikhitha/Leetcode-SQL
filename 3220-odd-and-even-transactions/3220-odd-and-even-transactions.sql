-- Write your PostgreSQL query statement below
select transaction_date, 
coalesce(sum(case when amount % 2 = 1 then amount end),0) as odd_sum,
coalesce(sum(case when amount % 2 = 0 then amount end),0) as even_sum 
from transactions
group by 1
order by transaction_date asc;