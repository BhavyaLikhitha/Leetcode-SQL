-- Write your PostgreSQL query statement below
with cte as(
    select person_name, 
    turn, 
    sum(weight) over(order by turn) as running_weight
    from queue
)
select person_name
from cte
where running_weight <= 1000
order by turn desc
limit 1;
