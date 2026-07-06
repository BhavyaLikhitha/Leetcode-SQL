WITH cte AS (
    SELECT visited_on, SUM(amount) AS amount
    FROM customer 
    GROUP BY visited_on
),
cte1 AS (
    SELECT 
        visited_on,
        SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS rn
    FROM cte
)
SELECT visited_on, amount, average_amount
FROM cte1
WHERE rn >= 7
ORDER BY visited_on ASC;