CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE(dept_name)
);
CREATE TABLE employees(
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);
CREATE TABLE dept_emp(
emp_no INT NOT NULL,
dept_no VARCHAR(6) NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
CREATE TABLE dept_manager(
dept_no VARCHAR (4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);
CREATE TABLE titles(
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, from_date)
);
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM titles;

SELECT emp_no, first_name, last_name
INTO retirement_titles
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');
SELECT * FROM retirement_titles;

SELECT ti.title, ti.from_date, ti.to_date, dm.emp_no
FROM titles as ti
INNER JOIN dept_manager as dm
ON ti.emp_no = dm.emp_no;

SELECT rt.emp_no, rt.first_name, rt.last_name, ti.title, ti.from_date, ti.to_date
INTO retirement_title
FROM retirement_titles as rt
INNER JOIN titles as ti
ON rt.emp_no = ti.emp_no

SELECT emp_no, first_name, last_name, title, to_date
INTO retirement_current
FROM retirement_title as rts
WHERE rts.to_date = ('9999-01-01');

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)emp_no, first_name, title, to_date
INTO unique_titles
FROM retirement_current
ORDER BY emp_no, first_name DESC;

SELECT COUNT(ut.emp_no),ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;



