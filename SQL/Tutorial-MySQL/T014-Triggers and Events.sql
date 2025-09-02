-- Triggers and Events

select * 
from employee_demographics;

select * 
from employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW  
BEGIN
	INSERT INTO employee_demographics(employee_id,first_name,last_name)
    VALUES (NEW.employee_id,NEW.first_name,NEW.last_name);
END $$
DELIMITER ;

insert into employee_salary(employee_id,first_name,last_name,occupation,salary,dept_id)
values(13,'Jean-Ralphio','Saperstein','Exntertainment 720 CEO','1000000',NULL);

-- EVENTS

select *
from employee_demographics;

DELIMITER $$
create event delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

SHOW VARIABLES LIKE 'event%';