-- Limit & Aliasing

select * From employee_demographics
limit 3;

select * From employee_demographics
order by age DESC
limit 3;

select * From employee_demographics
order by age DESC
limit 2,1;

-- Aliasing

select gender , avg(age) as avg_age 
from employee_demographics
group by gender
having avg_age > 40 ;