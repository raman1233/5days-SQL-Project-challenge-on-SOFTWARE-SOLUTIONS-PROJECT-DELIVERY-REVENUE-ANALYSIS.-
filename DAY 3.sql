-- Clients with no completed projects
SELECT c.client_name 
FROM Clients c
WHERE
    c.client_id NOT IN (
        SELECT DISTINCT p.client_id
        FROM Projects p
        WHERE p.status = 'Completed'
    );

-- Projects managed by specific managers whose name start from  "A"
SELECT p.project_name
FROM  Projects p
INNER JOIN 
    Employees e ON p.project_manager_id = e.employee_id
WHERE
    p.project_manager_id IN (
        SELECT e.employee_id
        FROM Employees e
        WHERE e.role = 'Project Manager'                                             
          AND SUBSTRING(e.first_name, 1, 1) = 'A'
    );

-- Top 3 industries by total revenue:
SELECT c.industry,SUM(s.revenue) AS total_revenue
FROM Clients c
INNER JOIN Sales s ON s.client_id=c.client_id
GROUP BY c.industry
ORDER BY total_revenue  DESC
LIMIT 3;

-- Projects with above-average budget for their industry:
SELECT p.project_name, p.budget,c.industry
FROM Projects p
INNER JOIN Clients c ON p.client_id = c.client_id
WHERE
    p.budget > (
        SELECT AVG(sub_p.budget) 
        FROM Projects sub_p
        INNER JOIN Clients sub_c ON sub_p.client_id = sub_c.client_id
        WHERE sub_c.industry = c.industry 
    );

-- Sales impact of highly-rated projects
SELECT p.project_name,p.delivery_rating,SUM(s.revenue) as total_revenue
FROM Projects p
INNER JOIN Sales s ON s.project_id=p.project_id
WHERE delivery_rating='5'
GROUP BY p.project_name
ORDER BY total_revenue DESC;

-- Categorize projects by profit/loss:
SELECT
    project_name,
    budget,
    actual_cost,
    CASE
        WHEN budget > actual_cost THEN 'Profitable'        
        WHEN budget = actual_cost THEN 'Break-even'        
        WHEN budget < actual_cost THEN 'Loss'             
        ELSE 'Unknown'                                     
    END AS profit_status   
FROM
    Projects;



