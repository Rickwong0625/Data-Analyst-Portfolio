-- Group By

select * from employee_demographics;

select gender, AVG(age)
from employee_demographics
GROUP BY gender;

select occupation , salary
from employee_salary
GROUP BY occupation, salary;

select gender, AVG(age),MAX(age),MIN(age),COUNT(age)
from employee_demographics
GROUP BY gender;


-- ORDER BY

select *
from employee_demographics
order by first_name DESC;

select *
from employee_demographics
order by gender,age DESC;

select *
from employee_demographics
order by 5,4;
#不推荐用的方式，使用column 号码