--import all data files
DROP TABLE departments;
CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
);

DROP TABLE dept_emp;
CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR,
	from_date VARCHAR,
	to_date VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


DROP TABLE dept_manager;
CREATE TABLE dept_manager (
	dept_no VARCHAR,
	emp_no INT,
	from_date VARCHAR,
	to_date VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

DROP TABLE employees;
CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	birth_date VARCHAR,
	first_name VARCHAR, 
	last_name VARCHAR,
	gender VARCHAR,
	hire_date VARCHAR
);

DROP TABLE salaries;
CREATE TABLE salaries (
	emp_no INT,
	salary INT,
	from_date VARCHAR,
	to_date VARCHAR, 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

DROP TABLE titles;
CREATE TABLE titles (
	emp_no INT,
	title VARCHAR,
	from_date VARCHAR,
	to_date VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--display each table 
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--1. employee details: number, last_name, first_name, gender, salary 
SELECT em.emp_no, em.last_name, em.first_name, em.gender, sal.salary
FROM employees AS em
JOIN salaries AS sal
ON em.emp_no = sal.emp_no;

--2. employees hired in 1986
SELECT * FROM employees;

SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '1986%';

--3. managers of each department: department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates
SELECT * FROM dept_manager;
SELECT * FROM departments;
SELECT * FROM employees;

SELECT d.dept_no, dept_name, dm.emp_no, em.last_name, em.first_name, dm.from_date, dm.to_date  
FROM departments AS d
JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no
JOIN employees AS em
ON dm.emp_no = em.emp_no;

--4. department of each employee with employee number, last name, first name, and department name
SELECT d.dept_no, d.dept_name, em.emp_no, em.last_name, em.first_name
FROM departments AS d 
JOIN dept_emp AS de
ON d.dept_no = de.dept_no
JOIN employees AS em
ON de.emp_no = em.emp_no

--5. employees with first name 'Hercules' and last name 'B%'
SELECT * FROM employees;

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, 
--first name, and department name
SELECT * FROM departments;
SELECT * FROM employee;
 
SELECT d.dept_name, em.emp_no, em.last_name, em.first_name
FROM departments AS d, employees AS em 
WHERE dept_name = 'Sales' AND emp_no IN 
	(
	SELECT emp_no
	FROM dept_emp AS de
	WHERE dept_no IN
		(
		SELECT dept_no
		FROM departments AS d
		WHERE dept_name = 'Sales'
		)
	);
	
--7. List all employees in the Sales and Development departments
--employee number, last name, first name, and department name
SELECT d.dept_name, em.emp_no, em.last_name, em.first_name
FROM departments AS d, employees AS em 
WHERE (dept_name = 'Sales') OR (dept_name = 'Development') AND emp_no IN 
	(
	SELECT emp_no
	FROM dept_emp AS de
	WHERE dept_no IN
		(
		SELECT dept_no
		FROM departments AS d
		WHERE (dept_name = 'Sales') OR (dept_name = 'Development')
		)
	);

--8. In descending order, list the frequency count of employee last names
SELECT last_name, COUNT(last_name) AS name_count 
FROM employees
GROUP BY last_name
ORDER BY name_count DESC

	





