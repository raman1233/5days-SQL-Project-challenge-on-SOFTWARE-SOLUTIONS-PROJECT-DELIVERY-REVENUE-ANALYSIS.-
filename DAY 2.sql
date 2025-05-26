-- Project details with client info:
SELECT p.project_name, c.client_name, c.industry
FROM Projects p
INNER JOIN Clients c ON C.client_id = p.client_id
ORDER BY c.client_name;
    
-- Total revenue per client
SELECT c.client_name,sum(s.revenue) as total_revenue
FROM Sales s
inner join Clients c ON c.client_id= s.client_id
GROUP BY client_name
ORDER BY total_revenue

-- Average project delivery rating by industry:
SELECT c.industry,AVG(p.delivery_rating) as Avg_rating
FROM Clients c 
INNER JOIN Projects p ON p.client_id=c.client_id
group by c.industry
ORDER BY Avg_rating DESC

-- Sales performance by sales representative 
SELECT e.first_name,e.last_name,SUM(s.revenue) AS TOTAL_REVENUE
FROM Employees e
inner join Sales s ON s.sales_rep_id=e.employee_id
WHERE s.deal_status="won"
GROUP BY e.first_name,e.last_name
ORDER BY TOTAL_REVENUE

-- Projects over budget means we have to see where is the budget of the project is lesser than actual cost
SELECT project_name, budget,actual_cost
FROM Projects
WHERE budget< actual_cost
ORDER BY project_name

-- Clients with multiple projects means client having more than 1 project
SELECT  Count(p.project_name) AS counting ,c.client_name
FROM Projects p
INNER JOIN  Clients c ON c.client_id=p.client_id
GROUP BY c.client_name
HAVING  Count(p.project_name) >=2
ORDER BY counting DESC 




