SELECT emp_no, 
		first_name, 
		last_name
FROM employees;

SELECT title, 
		from_date, 
		to_date
FROM titles;

--Select data from both tables into new table, joining on primary key and filtering on birth date.
SELECT e.emp_no, 
		e.first_name, 
		e.last_name, 
		t.title, 
		t.from_date, 
		t.to_date
INTO retirement_titles
FROM employees e
INNER JOIN titles t ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT * FROM retirement_titles
ORDER BY emp_no ASC
LIMIT 10;

-- Use Dictinct with Orderby to remove duplicate rows
SSELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

--First, retrieve the number of titles from the Unique Titles table. 
--Then, create a Retiring Titles table to hold the required information.
--Group the table by title, then sort the count column in descending order.

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

--DELIVERABLE 2

--write a query to create a Mentorship Eligibility table that holds the employees 
--who are eligible to participate in a mentorship program.
SELECT DISTINCT ON(e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
INTO mentorship_eligibility
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN titles t ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;
