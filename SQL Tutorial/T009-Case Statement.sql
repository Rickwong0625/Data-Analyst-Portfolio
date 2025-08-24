-- Case	Statements

select first_name,last_name,age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END as Age_Bracket
from employee_demographics;


-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

select first_name,last_name,salary,
CASE 
	WHEN salary < 50000 THEN salary + (salary * 0.05)
    WHEN salary > 50000 THEN salary + (salary * 0.07)
END as NEW_SALARY,
CASE
	WHEN dept_id = 6 THEN salary * .10
END as Bonus
from employee_salary;

select*
from employee_salary;
select*
from parks_departments;