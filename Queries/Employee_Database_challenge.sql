-- Unique titles
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
		rt.first_name,
        rt.last_name,
        rt.title
INTO unique_titles
FROM retirement_titles AS rt
	WHERE (rt.to_date = '9999-01-01')
	ORDER BY rt.emp_no, rt.to_date DESC;

-- Retiring titles
SELECT COUNT(ut.emp_no), ut.title 
INTO retiring_titles
FROM unique_titles AS ut
	GROUP BY ut.title
	ORDER BY count(ut.emp_no) DESC;

-- Mentorship eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
    e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentor_elig
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
     AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;