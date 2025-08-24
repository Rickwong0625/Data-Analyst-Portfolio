-- Having VS Where

select gender,avg(age)
from employee_demographics
group by gender
HAVING AVG(age) > 40;

select occupation, avg(salary)
from employee_salary
where occupation LIKE '%manager%'
group by occupation
having avg(salary) > 75000;