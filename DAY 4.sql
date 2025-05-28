-- Monthly project completions:
SELECT DATE_FORMAT(end_date, '%Y-%m') AS completion_month,
       COUNT(project_id) AS Number_of_Completed_Projects
FROM Projects
WHERE status = 'Completed'
GROUP BY completion_month 
ORDER BY completion_month ASC;
    
-- Average project duration by status
SELECT status, 
AVG(DATEDIFF(end_date, start_date)) AS average_duration_days
FROM Projects
GROUP BY status
ORDER BY status;
    
-- Rank projects by budget within each client 
SELECT c.client_name,p.project_name,p.budget,
 RANK() OVER (
        PARTITION BY c.client_id  
        ORDER BY p.budget DESC    
    ) AS budget_rank       
FROM Projects p
INNER JOIN Clients c ON c.client_id=p.client_id
ORDER BY
    budget_rank  ASC ;
    
-- Sales increase from previous sale for each client
SELECT c.client_name,s.sale_date, s.revenue,
    LAG(s.revenue, 1, 0) OVER (
        PARTITION BY c.client_id
        ORDER BY s.sale_date
    ) AS previous_sale_revenue
FROM Sales s
INNER JOIN Clients c ON s.client_id = c.client_id
ORDER BY c.client_name, s.sale_date;

-- Cumulative revenue by sales representative over time
SELECT e.first_name,e.last_name,s.sale_date,s.revenue,
SUM(revenue) OVER (
PARTITION BY s.sales_rep_id
ORDER BY sale_date
) AS running_total_revenue
FROM Employees e
INNER JOIN Sales s ON s.sales_rep_id=e.employee_id





