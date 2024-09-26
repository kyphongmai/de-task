-- This script creates the schema for the HR database, with 6 tables executed in the following orders to account for foreign key dependencies:
-- 1. titles (no FK): stores all job titles
-- 2. departments (no FK): stores names of all departments
-- 3. employees (FK referencing 'titles'): stores information about all employees
-- 4. salaries (FK referencing 'employees'): stores salary of all employees
-- 5. dept_emp (FK referencing 'employees' and 'departments'): stores relationship between employees and departments (e.g: an employee belongs to which department)
-- 6. dept_manager (FK referencing 'departments' and 'employees'): stores employee ID of all managers

BEGIN;

CREATE TABLE IF NOT EXISTS public.titles
(
    title_id character varying(10),
    title character varying(45) NOT NULL,

	-- Define PK
	PRIMARY KEY (title_id)
);


CREATE TABLE IF NOT EXISTS public.departments
(
    dept_id character varying(10),
    dept_name character varying(45) NOT NULL,

	-- Define PK
    PRIMARY KEY (dept_id)
);


CREATE TABLE IF NOT EXISTS public.employees
(
    emp_id integer,
    title_id character varying(10) NOT NULL,
    birth_date date,
    first_name character varying(45),
    last_name character varying(45),
    sex "char",
    hire_date date,

	-- Define PK and FK
    PRIMARY KEY (emp_id),
	FOREIGN KEY (title_id)
    	REFERENCES public.titles (title_id)
		ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	
	-- Add a CHECK constraint to ensure that 'sex' can only be 'M' or 'F'
    CONSTRAINT check_sex CHECK (sex IN ('M', 'F'))
);


CREATE TABLE IF NOT EXISTS public.salaries
(
    emp_id integer,
    salary numeric(10,2) NOT NULL,

	-- Define PK and FK
	-- PK and FK on emp_id to enforce 1-to-1 relationship between employees and salaries table
    PRIMARY KEY (emp_id),
	FOREIGN KEY (emp_id)
    	REFERENCES public.employees (emp_id)
		ON UPDATE NO ACTION
        ON DELETE NO ACTION,

	-- Define a CHECK constraint to ensure that salary is a positive number
	CONSTRAINT check_salary CHECK (salary > 0)
);


CREATE TABLE IF NOT EXISTS public.dept_emp
(
    emp_id integer NOT NULL,
    dept_id character varying(10) NOT NULL,

	-- Define a composite key that combines emp_id and dept_id
    PRIMARY KEY (emp_id, dept_id),

	-- Define 2 FKs
	FOREIGN KEY (emp_id) 
		REFERENCES public.employees (emp_id) 
		ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	
	FOREIGN KEY (dept_id) 
		REFERENCES public.departments (dept_id) 
		ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE IF NOT EXISTS public.dept_manager(
    dept_id character varying(10) NOT NULL,
	emp_id integer NOT NULL,

	-- Define a composite key that combines emp_id and dept_id
    PRIMARY KEY (dept_id, emp_id),

	-- Define 2 FKs
	FOREIGN KEY (dept_id) 
		REFERENCES public.departments (dept_id) 
		ON UPDATE NO ACTION
        ON DELETE NO ACTION,

	FOREIGN KEY (emp_id) 
		REFERENCES public.employees (emp_id) 
		ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

END;