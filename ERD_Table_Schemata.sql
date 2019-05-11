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

