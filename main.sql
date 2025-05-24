Create database sql_challenge_5_days
-- Table 1: Employees
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role VARCHAR(100),
    hire_date DATE
);

INSERT INTO Employees (employee_id, first_name, last_name, role, hire_date) VALUES
(101, 'Alice', 'Johnson', 'Project Manager', '2020-01-15'),
(102, 'Bob', 'Williams', 'Sales Representative', '2019-03-20'),
(103, 'Carol', 'Davis', 'Project Manager', '2021-06-10'),
(104, 'David', 'Miller', 'Sales Representative', '2020-11-01'),
(105, 'Eve', 'Brown', 'Developer', '2018-09-05'),
(106, 'Frank', 'Taylor', 'Project Manager', '2022-02-28'),
(107, 'Grace', 'Moore', 'Sales Representative', '2021-07-19'),
(108, 'Henry', 'Jackson', 'Developer', '2019-04-12');

-- Table 2: Clients
CREATE TABLE Clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(255),
    industry VARCHAR(100),
    region VARCHAR(100)
);

INSERT INTO Clients (client_id, client_name, industry, region) VALUES
(201, 'Global Innovations Inc.', 'Technology', 'North America'),
(202, 'MediCare Solutions', 'Healthcare', 'Europe'),
(203, 'RetailLink Corp.', 'Retail', 'North America'),
(204, 'FinanceFlow Ltd.', 'Finance', 'Asia'),
(205, 'EduTech Group', 'Education', 'Europe'),
(206, 'AutoDrive Systems', 'Automotive', 'North America'),
(207, 'GreenHarvest Foods', 'Agriculture', 'South America');

-- Table 3: Projects
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255),
    client_id INT,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(10, 2),
    actual_cost DECIMAL(10, 2),
    status VARCHAR(50),
    project_manager_id INT,
    delivery_rating INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (project_manager_id) REFERENCES Employees(employee_id)
);

INSERT INTO Projects (project_id, project_name, client_id, start_date, end_date, budget, actual_cost, status, project_manager_id, delivery_rating) VALUES
(301, 'AI-Powered CRM System', 201, '2023-01-10', '2023-06-30', 150000.00, 145000.00, 'Completed', 101, 5),
(302, 'Telemedicine Platform', 202, '2023-03-01', '2023-09-15', 200000.00, 210000.00, 'Completed', 103, 4),
(303, 'E-commerce Redesign', 203, '2023-04-20', '2023-11-01', 120000.00, 118000.00, 'Completed', 101, 5),
(304, 'Investment Analytics Tool', 204, '2023-06-01', '2024-01-31', 180000.00, 175000.00, 'Completed', 103, 5),
(305, 'Online Learning Module', 205, '2023-07-15', '2024-03-10', 90000.00, 95000.00, 'Completed', 106, 3),
(306, 'Supply Chain Optimization', 201, '2023-09-01', NULL, 160000.00, 80000.00, 'In Progress', 101, NULL),
(307, 'Patient Portal Upgrade', 202, '2023-10-10', '2024-05-20', 130000.00, 135000.00, 'Completed', 103, 4),
(308, 'Personalized Marketing Engine', 203, '2023-11-05', NULL, 110000.00, 60000.00, 'In Progress', 106, NULL),
(309, 'Fraud Detection System', 204, '2024-01-01', NULL, 220000.00, 100000.00, 'In Progress', 101, NULL),
(310, 'Student Management System', 205, '2024-02-15', NULL, 100000.00, 40000.00, 'In Progress', 103, NULL),
(311, 'Autonomous Driving Software', 206, '2023-08-01', '2024-04-30', 300000.00, 310000.00, 'Completed', 106, 4),
(312, 'Farm Management App', 207, '2024-03-01', NULL, 80000.00, 20000.00, 'In Progress', 101, NULL),
(313, 'Mobile Banking App', 204, '2022-05-01', '2023-01-20', 190000.00, 195000.00, 'Completed', 103, 3),
(314, 'POS System Integration', 203, '2022-07-01', '2023-02-28', 95000.00, 90000.00, 'Completed', 101, 5),
(315, 'Predictive Maintenance Software', 206, '2024-04-01', NULL, 250000.00, 50000.00, 'In Progress', 106, NULL);

-- Table 4: Sales
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    project_id INT,
    client_id INT,
    sale_date DATE,
    revenue DECIMAL(10, 2),
    deal_status VARCHAR(50),
    sales_rep_id INT,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (sales_rep_id) REFERENCES Employees(employee_id)
);

INSERT INTO Sales (sale_id, project_id, client_id, sale_date, revenue, deal_status, sales_rep_id) VALUES
(401, 301, 201, '2022-12-15', 150000.00, 'Won', 102),
(402, 302, 202, '2023-02-20', 200000.00, 'Won', 104),
(403, 303, 203, '2023-03-25', 120000.00, 'Won', 102),
(404, 304, 204, '2023-05-10', 180000.00, 'Won', 107),
(405, 305, 205, '2023-06-30', 90000.00, 'Won', 104),
(406, 306, 201, '2023-08-20', 160000.00, 'Won', 102),
(407, 307, 202, '2023-09-01', 130000.00, 'Won', 107),
(408, 308, 203, '2023-10-15', 110000.00, 'Won', 102),
(409, 309, 204, '2023-12-20', 220000.00, 'Won', 104),
(410, 310, 205, '2024-01-30', 100000.00, 'Won', 107),
(411, 311, 206, '2023-07-25', 300000.00, 'Won', 104),
(412, 312, 207, '2024-02-20', 80000.00, 'Won', 102),
(413, NULL, 201, '2024-03-10', 50000.00, 'Pending', 102), -- New potential sale, not linked to project yet
(414, NULL, 204, '2024-04-05', 75000.00, 'Lost', 107),     -- Lost deal
(415, 313, 204, '2022-04-15', 190000.00, 'Won', 107),
(416, 314, 203, '2022-06-10', 95000.00, 'Won', 102),
(417, NULL, 202, '2024-05-10', 60000.00, 'Lost', 104),
(418, 315, 206, '2024-03-15', 250000.00, 'Won', 104);
SELECT * FROM Projects
SELECT * FROM Clients
SELECT * FROM Sales
SELECT * FROM Employees