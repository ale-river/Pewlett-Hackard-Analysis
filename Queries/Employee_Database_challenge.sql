-- ASSIGNMENT MODULE 7
-- DELIVERY 1: The Number of Retiring Employees by Title
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	i.title,
	i.from_date,
	i.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS i
ON (e.emp_no = i.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, title DESC;

-- Count the retired people
SELECT COUNT(un.emp_no),
	un.title
INTO retiring_titles
FROM unique_titles AS un
GROUP BY un.title
ORDER BY COUNT(title) DESC;

-- DELIVERY 2: The Employees Eligible for the Mentorship Program
-- Create a Mentorship Eligibility table for current employees
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
LEFT OUTER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
LEFT OUTER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;