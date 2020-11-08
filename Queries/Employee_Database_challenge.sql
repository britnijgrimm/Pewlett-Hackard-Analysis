--List all employees born between 1952 and 1955
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	j.title,
	j.from_date,
	j.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS j
ON e.emp_no = j.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- List the number of employees approaching retirement per title
SELECT COUNT(emp_no) AS count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT (emp_no) DESC;

--Review tables
SELECT * FROM retirement_titles;
SELECT * FROM unique_titles;
SELECT * FROM retiring_titles;

--List employees that are eligbile to participate in mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	j.title
INTO mentorship_eligbility
FROM employees AS e
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN titles AS j
ON de.emp_no = j.emp_no
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no, de.to_date DESC;
 
--Review table
SELECT * FROM mentorship_eligbility;


--Analysis
--List the number of employees eligible for mentorship program by title
SELECT COUNT(emp_no) AS count, title
FROM mentorship_eligbility
GROUP BY title
ORDER BY COUNT (emp_no) DESC;

--List the total number of employees approching retirement
SELECT COUNT (emp_no)
FROM retirement_titles;

--List the total number of employees eligible for mentorship program
SELECT COUNT (emp_no)
FROM mentorship_eligbility;

SELECT COUNT (emp_no)
FROM employees;