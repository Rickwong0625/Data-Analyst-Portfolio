-- Window Functions

select	gender,AVG(salary) as avg_salary
from employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
group by gender
;

select	gender,AVG(salary) OVER(partition by gender)
from employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
select	dem.first_name,dem.last_name,AVG(salary) OVER(partition by gender)
from employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
select	dem.first_name,dem.last_name,gender,salary,
SUM(salary) OVER(partition by gender order by dem.employee_id) as Rolling_Total
from employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
select	dem.employee_id,dem.first_name,dem.last_name,gender,salary,
ROW_NUMBER() OVER(partition by gender ORDER BY salary DESC) AS row_num,
Rank() OVER(partition by gender ORDER BY salary DESC) rank_num,
Dense_Rank() OVER(partition by gender ORDER BY salary DESC) denserank_num
from employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;