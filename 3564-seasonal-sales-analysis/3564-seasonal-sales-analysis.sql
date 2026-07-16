# Write your MySQL query statement below
with cte as(select 
CASE 
    WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
    WHEN MONTH(s.sale_date) IN (3, 4, 5) THEN 'Spring'
    WHEN MONTH(s.sale_date) IN (6, 7, 8) THEN 'Summer'
    ELSE 'Fall'
END AS season,
p.category, 
sum(s.quantity) as total_quantity,
sum(s.quantity * s.price) as total_revenue
from sales s
join products p
on s.product_id = p.product_id
group by season, p.category
), cte1 as(
    SELECT 
        season,
        category,
        total_quantity,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY season 
            ORDER BY total_quantity DESC, total_revenue DESC, category ASC
        ) AS rn
    FROM cte
)
select 
season, category, total_quantity, total_revenue
from cte1
where rn = 1
order by season ASC;
