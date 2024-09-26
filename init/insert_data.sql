-- This script imports data from CSV files into corresponding tables using COPY command
-- Each COPY command uses ',' as delimiter and first row is expected to be column headers.
-- The following order of execution is designed to account for foreign depencencies:
-- titles --> departments --> employees --> salaries --> dept_emp --> dept_manager

COPY titles
FROM '/docker-entrypoint-initdb.d/raw_data/titles.csv'
DELIMITER ','
CSV HEADER;

COPY departments
FROM '/docker-entrypoint-initdb.d/raw_data/departments.csv'
DELIMITER ','
CSV HEADER;

COPY employees
FROM '/docker-entrypoint-initdb.d/raw_data/employees.csv'
DELIMITER ','
CSV HEADER;

COPY salaries
FROM '/docker-entrypoint-initdb.d/raw_data/salaries.csv'
DELIMITER ','
CSV HEADER;

COPY dept_emp
FROM '/docker-entrypoint-initdb.d/raw_data/dept_emp.csv'
DELIMITER ','
CSV HEADER;

COPY dept_manager
FROM '/docker-entrypoint-initdb.d/raw_data/dept_manager.csv'
DELIMITER ','
CSV HEADER;