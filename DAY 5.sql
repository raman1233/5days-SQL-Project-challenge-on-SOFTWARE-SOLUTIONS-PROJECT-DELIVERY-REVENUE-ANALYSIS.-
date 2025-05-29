-- Client Profitability Analysis (Top 3)
WITH
    ClientRevenue AS (
        SELECT c.client_id, c.client_name,
            SUM(s.revenue) AS total_revenue
        FROM Clients c
        INNER JOIN Sales s ON c.client_id = s.client_id
        GROUP BY c.client_id, c.client_name ),
    ProjectCosts AS (
        SELECT c.client_id,
	    SUM(p.actual_cost) AS total_actual_cost
        FROM Clients c
        INNER JOIN
            Projects p ON c.client_id = p.client_id
        GROUP BY
            c.client_id )
SELECT
    cr.client_name,
    (
        cr.total_revenue - COALESCE(pc.total_actual_cost, 0)
    ) AS profit -- COALESCE handles cases where a client has no projects
FROM
    ClientRevenue cr
LEFT JOIN
    ProjectCosts pc ON cr.client_id = pc.client_id
ORDER BY
    profit DESC
LIMIT
    3;
    
    
-- Impact of Delivery Rating on Revenue:
SELECT
    CASE
        WHEN p.delivery_rating = 5 THEN 'Rating 5'
        WHEN p.delivery_rating < 5 THEN 'Rating Below 5'
        ELSE 'Other/Unrated' 
    END AS delivery_category,
    AVG(s.revenue) AS average_revenue_per_sale,
    COUNT(DISTINCT p.project_id) AS number_of_projects 
FROM Sales s
INNER JOIN Projects p ON s.project_id = p.project_id
WHERE p.delivery_rating IS NOT NULL 
GROUP BY
    CASE
        WHEN p.delivery_rating = 5 THEN 'Rating 5'
        WHEN p.delivery_rating < 5 THEN 'Rating Below 5'
        ELSE 'Other/Unrated'
    END 
ORDER BY 
    delivery_category;
    
    
    -- Employee Productivity and Project Performance
SELECT
    e.employee_id,           
    e.first_name,            
    e.last_name,             
    AVG(p.budget) AS average_project_budget,
    AVG(p.delivery_rating) AS average_project_delivery_rating 
FROM
    Employees e
INNER JOIN
    Projects p ON e.employee_id = p.project_manager_id
WHERE
    e.role = 'Project Manager' 
GROUP BY
    e.employee_id,          
    e.first_name,
    e.last_name
ORDER BY
    average_project_delivery_rating DESC, 
    average_project_budget DESC;          
    
  

-- Quarterly Revenue Growth
WITH QuarterlyRevenue AS (
    SELECT
        YEAR(sale_date) AS sale_year,
        QUARTER(sale_date) AS sale_quarter,
        SUM(revenue) AS total_quarterly_revenue
    FROM
        Sales
    GROUP BY
        YEAR(sale_date),
        QUARTER(sale_date)
),
QuarterlyRevenueWithLag AS (
    SELECT
        sale_year,
        sale_quarter,
        total_quarterly_revenue,
        LAG(total_quarterly_revenue, 1, 0) OVER (
            ORDER BY sale_year ASC, sale_quarter ASC
        ) AS previous_quarter_revenue
    FROM
        QuarterlyRevenue
)
SELECT
    qr.sale_year,
    qr.sale_quarter,
    qr.total_quarterly_revenue,
    qr.previous_quarter_revenue,
    CASE
        WHEN qr.previous_quarter_revenue = 0 THEN NULL
        ELSE ( (qr.total_quarterly_revenue - qr.previous_quarter_revenue) * 100.0 / qr.previous_quarter_revenue )
    END AS quarter_over_quarter_growth_percentage
FROM
    QuarterlyRevenueWithLag qr
ORDER BY
    qr.sale_year DESC,
    qr.sale_quarter ASC;


-- Comprehensive project summary
WITH
    ProjectProfitStatus AS (
        SELECT
            project_id, 
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
            Projects
    ),
    ProjectDuration AS (
        SELECT
            project_id, 
            project_name,
            start_date,
            end_date,
            DATEDIFF(end_date, start_date) AS duration_in_days 
        FROM
            Projects
        WHERE
            end_date IS NOT NULL AND start_date IS NOT NULL 
    )
SELECT
    p.project_name,
    c.client_name,
    e.first_name AS project_manager_first_name,
    e.last_name AS project_manager_last_name,
    p.budget,
    p.actual_cost,
    pps.profit_status,
    p.delivery_rating,
    pd.duration_in_days
FROM
    Projects p
INNER JOIN
    Clients c ON p.client_id = c.client_id
INNER JOIN
    Employees e ON p.project_manager_id = e.employee_id
INNER JOIN
    ProjectProfitStatus pps ON p.project_id = pps.project_id 
INNER JOIN
    ProjectDuration pd ON p.project_id = pd.project_id; 
    
    
    
