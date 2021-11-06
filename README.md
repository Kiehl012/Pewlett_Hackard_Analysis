# Pewlett_Hackard_Analysis
## Overview

Pewlett Hackard (PH), a large employer, was anticipating a "Silver Tsunami." In other words, many employees were reaching retirement age at the same time. To assess the magnitude of these retirements, I analyzed all PH employees to determine exactly how many people were eligible for retirement AND what positions they currently hold. Below are our as well as a few recommendations for management.<br/>

## Results

- Total number of employees eligible for retirement is 90,398 (defined employees) born between 1955 and 1958). That's out of 240,124 active employees, which means that roughly 38% of active employees are eligible for retirement. This is a significant portion of the PH work force, so it's important to have a plan in place to fill these positions.

- In addition to the raw number of retiring employees. We thought it would be useful to know what positions they currently hold. Our analysis found that many of the employees eligible for retirement hold important, high-experience roles. See the table below for a breakdown of retirement-eligible employees by title.

<img width="403" alt="Screen Shot 2021-11-06 at 1 25 08 PM" src="https://user-images.githubusercontent.com/90878911/140621485-aa8de39e-5211-4adb-8921-16226eb25024.png"><br/>

From this breakdown, it's clear that engineering could suffer significant losses at both the lower and senior levels. In addition to that, many senior staff positions are also at risk of turnover.

- In addition to knowledge and human capital losses from these retirements, there is a financial cost too. Many of these employees will be eligible for retirement packages when they leave. In order to help predict that cost, we calculated the number of retirement eligible employees who are also eligible for a retirement package. We defined those people as employess hired between 1985 and 1988. That query yielded 33,118 employees. To make this number a bit more useful in terms of forcasting the cost of these packages, we found the average salary of these individuals was $52,961.49.

- Finally, in an effort to fill these positions when the time comes, it's important to identify employees who could fill these roles. We used birth date as a proxy for experience to identify how many employees might be eligible for a mentorship program to fill future open roles. Specifically, we looked at those who were born in 1965. That search yielded 1,549 employees. 

## Summary

With 90,398 within retirement age, this is a significant shift to prepare for. As we notedabove, there are 33,118 employees eligible for a retirement package with an average salary of  $52,961.49. We calculated those numbers using the following queries:

- Number of employees eligible:<br/><br/>
SELECT COUNT(e.emp_no)<br/>
FROM employees e<br/>
INNER JOIN salaries s ON e.emp_no = s.emp_no<br/>
INNER JOIN dept_emp as de ON e.emp_no = de.emp_no<br/>
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'<br/>
     AND e.hire_date BETWEEN '1985-01-01' AND '1988-12-31'<br/>
	   AND de.to_date = '9999-01-01';<br/>

- Average salary of eligible employees:<br/><br/>
SELECT AVG(s.salary)<br/>
FROM salaries s<br/>
INNER JOIN employees e ON e.emp_no = s.emp_no<br/>
INNER JOIN dept_emp as de ON e.emp_no = de.emp_no<br/>
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'<br/>
     AND e.hire_date BETWEEN '1985-01-01' AND '1988-12-31'<br/>
	   AND de.to_date = '9999-01-01';<br/><br/>

Additionally, it's important to identify those who can help train other employees to fill the open positions. We noted above that 1,540 employees meet the criteria for the mentorship program; however, the raw number of people doesn't help us much. To make this more useful, we ran another query to identify how many mentorship-eligible employees currently work in the three positions with the highest number of retiring employees: Senior Engineering, Senior Staff, and Engineering. See that query and the output here:

SELECT COUNT(emp_no) as number_of_employees, title<br/>
FROM mentorship_eligibility<br/>
WHERE title IN ('Senior Engineer', 'Senior Staff', 'Engineer')<br/>
GROUP BY title<br/>
ORDER BY number_of_employees DESC;<br/>

<img width="362" alt="Screen Shot 2021-11-06 at 3 23 56 PM" src="https://user-images.githubusercontent.com/90878911/140622858-922ddb1d-0928-4048-b87e-c0c8f58e27f6.png">
<br/><br/>

Fortunately, this shows us that a large portion of mentorship-eligible employees are currently working in positions that will have the highest retirement turnover. We can easily compile a list of names for each of these positions and give it to PH human resources to get the program started with the best possible candidates.

