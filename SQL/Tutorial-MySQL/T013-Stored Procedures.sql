-- Stored Procedures

select *
from employee_salary
where salary >= 50000;

create procedure large_salaries()
select *
from employee_salary
where salary >= 50000;

CALL large_salaries();

-- Delimiter change end ; to other example $$. after use need to change back ;
DELIMITER $$
create procedure large_salaries3()
BEGIN
	select *
	from employee_salary
	where salary >= 50000;
	select *
	from employee_salary
	where salary >= 10000;
END $$
DELIMITER  ;

CALL large_salaries3();



DELIMITER $$
create procedure large_salaries4(p_employee_id int)
BEGIN
	select salary
	from employee_salary
    WHERE employee_id = employee_id_param;
	
END $$
DELIMITER  ;

CALL large_salaries4(1);