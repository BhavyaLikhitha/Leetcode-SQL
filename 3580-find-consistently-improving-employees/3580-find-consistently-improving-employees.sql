-- Write your PostgreSQL query statement below
WITH last3 AS (
    SELECT 
        e.employee_id, e.name, pr.rating,
        ROW_NUMBER() OVER (PARTITION BY e.employee_id ORDER BY pr.review_date DESC) AS rn
    FROM employees e
    JOIN performance_reviews pr ON e.employee_id = pr.employee_id
)
SELECT 
    employee_id, name,
    MAX(CASE WHEN rn = 1 THEN rating END) - MAX(CASE WHEN rn = 3 THEN rating END) AS improvement_score
FROM last3
WHERE rn <= 3
GROUP BY employee_id, name
HAVING 
    COUNT(*) = 3
    AND MAX(CASE WHEN rn = 1 THEN rating END) > MAX(CASE WHEN rn = 2 THEN rating END)
    AND MAX(CASE WHEN rn = 2 THEN rating END) > MAX(CASE WHEN rn = 3 THEN rating END)
ORDER BY improvement_score DESC, name ASC;