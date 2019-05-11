--Create tables:

DROP TABLE departments;

CREATE TABLE departments(
	dept_no VARCHAR   NOT NULL,
    	dept_name VARCHAR   NOT NULL,
	PRIMARY KEY(dept_no)
);

DROP TABLE employees;

CREATE TABLE employees(
    	emp_no INT   NOT NULL,
   	birth_date DATE   NOT NULL,
    	first_name VARCHAR   NOT NULL,
    	last_name VARCHAR   NOT NULL,
    	gender VARCHAR   NOT NULL,
    	hire_date DATE   NOT NULL,
    	PRIMARY KEY (emp_no),
);


DROP TABLE dept_manager;

CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY(dept_no, emp_no), 
	FOREIGN KEY(dept_no, emp_no) REFERENCES (departments.dept_no, employees.emp_no)
);


DROP TABLE dept_emp;

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(6) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY(emp_no, dept_no) REFERENCES (departments.dept_no, employees.emp_no)
); 



DROP TABLE Salaries;

CREATE TABLE Salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY(emp_no, salary),
	FOREIGN KEY(emp_no) REFERENCES employees.emp_no
);



DROP TABLE titles;

CREATE TABLE titles(
	emp_no INT   NOT NULL,
    	title VARCHAR   NOT NULL,
   	to_date DATE   NOT NULL,
    	from_date DATE   NOT NULL,
    	PRIMARY KEY (emp_no,title,from_date),
	FOREIGN KEY (emp_no) REFERENCES employees.emp_no
);



--1. List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries ON salaries.emp_no = employees.emp_no;


--2. List employees who were hired in 1986.

SELECT first_name, last_name, emp_no, hire_date
FROM employees
WHERE hire_date BETWEEN '01/01/1986' AND '12/31/1986';


--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT departments.dept_no, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM dept_manager
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON employees.emp_no = dept_manager.emp_no;


--4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT employees.last_name, employees.first_name, departments.dept_name, dept_emp.emp_no
FROM departments
INNER JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
INNER JOIN employees ON employees.emp_no = dept_emp.emp_no;


--5. List all employees whose first name is "Hercules" and last names begin with "B." 

SELECT first_name, last_name
FROM employees
WHERE 
	first_name = 'Hercules'
	AND last_name LIKE 'B%';


--6. List all employees in the Sales department, including their employee number, last name, first name, and department name 

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN titles ON titles.emp_no = employees.emp_no
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_name = 'Sales';



--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

Select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM departments, employees, dept_emp 
WHERE
employees.emp_no = dept_emp.emp_no AND
dept_emp.dept_no = departments.dept_no AND
departments.dept_name IN ('Sales', 'Development')
ORDER by departments.dept_no;


--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(*) as frequency
FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC;

