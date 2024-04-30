-- Project: Performing Aggregation Using SQL Aggregate Functions
#############################
-- Task One: Introduction
-- In this task, we will retrieve data from tables in the employees database
#############################
-- 1.1: Retrieve all records in the employees table

SELECT * FROM employees;

-- 1.2: Retrieve all records in the departments table

SELECT * FROM departments;

-- 1.3: Retrieve all records in the dept_emp table

SELECT * FROM dept_emp;

-- 1.4: Retrieve all records in the salaries table

SELECT * FROM salaries;

#############################
-- Task Two: COUNT()
-- In this task, we will learn how to retrieve data from the employees
-- database using the COUNT() function
#############################

-- 2.1: How many employees are in the company?

SELECT COUNT(*) AS TotalEmployees
FROM employees;

-- 2.2: Is there any employee without a first name?  

SELECT * 
FROM employees
WHERE first_name IS NULL OR first_name = '';

-- Alternative Solution

SELECT COUNT(*) 
FROM employees
WHERE first_name IS NULL OR first_name = '';


-- 2.3: How many records are in the salaries table

SELECT COUNT(*) CountOfSalaryRecords
FROM salaries;


-- 2.4: How many annual contracts with a value higher than or equal to
-- $100,000 have been registered in the salaries table?

SELECT COUNT(*) 
FROM salaries 
WHERE salary >= 100000;


-- 2.5: How many times have we paid salaries to employees?

SELECT COUNT(*) AS total_salary_payments
FROM salaries;

#############################
-- Task Three: SELECT DISTINCT & GROUP BY
-- In this task, we will understand the difference between SELECT DISTINCT
-- and GROUP BY to retrieve data from the employees database
#############################

###########

-- 3.1: Select different names from the employees table

SELECT first_name, last_name AS unique_names
FROM employees
GROUP BY first_name, last_name;

-- 3.2: How many different names can be found in the employees table?

SELECT COUNT(DISTINCT first_name, last_name) AS "Number of Unique Names"
FROM employees;

-- 3.3: How many different first names are in the employees table?

SELECT COUNT(DISTINCT first_name) AS "Number of Unique First Names"
FROM employees;

-- 3.4: Select different first name are in the employees table?

SELECT first_name AS unique_first_names
FROM employees
GROUP BY first_name, last_name;

-- 3.5: How many different first name are in the employees table
-- and order by first name in descending order?

SELECT DISTINCT first_name AS distinct_first_names
FROM employees
ORDER BY first_name DESC;

  
-- 3.6 How many different departments are there in the "employees" database?

SELECT COUNT(DISTINCT dept_no) AS 'Count of different departments'
FROM dept_emp;

-- 3.7: Retrieve a list of how many employees earn over $80,000 and
-- how much they earn. Rename the 2nd column as emps_with_same_salary?

SELECT salary, COUNT(emp_no) AS emps_with_same_salary
FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary ASC;


#############################
-- Task Four: HAVING
-- In this task, you will learn how to set conditions on the output of 
-- aggregate functions using the HAVING clause
#############################

-- 4.1: Retrieve a list of all employees who were employed on and after 1st of January, 1990.
SELECT * 
FROM employees
WHERE hire_date >= '1990-01-01';

-- Will this produces the same result?

SELECT *
FROM employees
HAVING hire_date >= '1990-01-01';

-- 4.2: Extract a list of names of employees, where the number of employees is more than 15
-- Order by first name.

SELECT first_name, COUNT(first_name) as names_count
FROM employees
GROUP BY first_name
HAVING COUNT(first_name) > 15
ORDER BY first_name; 


-- 4.3: Retrieve a list of employee numbers and the average salary.
-- Make sure the you return where the average salary is more than $120,000

SELECT emp_no, AVG(salary) 
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) >= 120000;

-- 4.4: Extract a list of all names that have encountered less than 200
-- times. Let the data refer to people hired after 1st of January, 1999

SELECT first_name, last_name, COUNT(*) AS occurrence
FROM employees
WHERE hire_date > '1999-01-01'
GROUP BY first_name, last_name
HAVING COUNT(*) < 200;

-- 4.5: Select the employees numbers of all individuals who have signed 
-- more than 1 contract after the 1st of January, 2000

SELECT emp_no, COUNT(emp_no) AS 'Number of contracts'
FROM salaries
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1;


#############################
-- Task Five: SUM
-- In this task, you will learn how to retrieve data from the employees
-- database using the SUM() function
#############################

-- 5.1: Retrieve the total amount the company has paid in salary?

SELECT SUM(salary)
FROM salaries;
    
-- 5.2 What do you think will happen here

# SELECT SUM(*)
# FROM salaries;

-- Answer: Error will be detected.

-- 5.3: What is the total amount of money spent on salaries for all 
-- contracts starting after the 1st of January, 1997?

SELECT SUM(salary)
FROM salaries
WHERE from_date >= '1997-01-01';


#############################
-- Task Six: MIN() and MAX()
-- In this task, you will learn how to retrieve data from the employees
-- database using the MIN() and MAX() function
#############################

-- 6.1: What is the highest salary paid by the company?

SELECT MAX(salary) 
FROM salaries;

-- 6.2: What is the lowest salary paid by the company?

SELECT MIN(salary) 
FROM salaries;

    
-- 6.3: What is the lowest employee number in the database?

SELECT MIN(emp_no)
FROM employees;

-- 6.4: What is the highest employee number in the database?

SELECT MAX(emp_no)
FROM employees;


#############################
-- Task Seven: AVG()
-- In this task, you will learn how to retrieve data from the employees
-- database using the AVG() function
#############################

-- 7.1: How much has the company paid on average to employees?

SELECT AVG(salary) AS AverageSalary
FROM salaries;

-- 7.2: What is the average annual salary paid to employees who started
-- after the 1st of January, 1997

SELECT AVG(salary) as AverageAnnualSalary
FROM salaries
JOIN employees ON salaries.emp_no = employees.emp_no
WHERE employees.hire_date > '1997-01-01';


#############################
-- Task Eight: ROUND()
-- In this task, you will learn how to tidy up the result set from an 
-- aggregate function using ROUND(). In addition, you will perform some arithmetic
-- operations by combining different aggregate function
#############################


-- 8.1: Round the average salary to the nearest whole number
   
SELECT ROUND(AVG(salary)) 
FROM salaries;


-- 8.2: Round the average salary to a precision of cents.

SELECT ROUND(AVG(salary),2) 
FROM salaries;

-- 8.3: Round the average amount of money spent on salaries for all
-- contracts that started after the 1st of January, 1997 to a precision of cents

SELECT ROUND(AVG(salary),2) 
FROM salaries
WHERE from_date > '1997-01-01';

-- 8.4: Arithmetic operations can also be performed in PostgreSQL

-- Finding the range for salary

SELECT MAX(salary)-MIN(salary) AS 'RANGE'
FROM salaries;








