-- Retrieve all projects:
SELECT * FROM Projects

-- List unique client industries:
SELECT * FROM Clients

-- Count active projects
SELECT COUNT(*) as In_Progress
FROM Projects
WHERE status = 'In Progress';

-- Find highly-rated projects
SELECT project_name ,delivery_rating,client_id
FROM Projects
WHERE delivery_rating =5 or delivery_rating=4
ORDER BY delivery_rating desc;

-- Identify top-earning sales
SELECT sale_id ,sale_date,revenue
FROM Sales
ORDER BY revenue DESC
LIMIT 5;

-- Projects completed in Quarter 1 of  2024
SELECT project_name ,end_date
FROM Projects
Where end_date>='2024-01-01' and end_date<='2024-03-31'

