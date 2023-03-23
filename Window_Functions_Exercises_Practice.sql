use employees;
# ----------------------------------------L-259 WIndow Function Exercise ----------------------------------------------------
select emp_no, 
       dept_no,
       row_number() over () as row_num
from dept_manager;

select emp_no,
       first_name,
       last_name,
       row_number() over (partition by first_name order by last_name asc) as row_num
from employees;

# --------------------------------------- L-262 Window Function Exercises ----------------------------------------------
select * from dept_manager limit 100;
select m.emp_no,
       m.dept_no,
       s.salary,
       row_number() over () as row_num1,
       row_number() over (partition by emp_no order by salary asc) as row_num2
from dept_manager m
join
salaries s on m.emp_no = s.emp_no
order by row_num1, emp_no, salary asc;

select m.emp_no,
       m.dept_no,
       s.salary,
       row_number() over (partition by emp_no order by salary asc) as row_num1,
       row_number() over (partition by emp_no order by salary desc) as row_num2
from dept_manager m
join
salaries s on m.emp_no = s.emp_no;

# ------------------------------------ L-265 Window Functions Exercises -----------------------------------------
select emp_no,
       first_name,
       last_name,
       row_number() over w as row_num
from employees
window w as (partition by first_name order by emp_no asc);

# ------------------------------------ L-268 Window Functions Exercises -----------------------------------------
select a.emp_no,
       min(salary) as min_salary from 
       (select emp_no,
               salary,
               row_number() over w as row_num
from salaries
window w as (partition by emp_no order by salary asc)) a
group by emp_no;
       
select subquery.emp_no,
       min(salary) as min_salary from
       (select emp_no,
               salary,
               row_number() over (partition by emp_no order by salary asc)
from salaries) as subquery
group by emp_no;

select a.emp_no,
       min(salary) as min_salary from
       (select emp_no,
			   salary
from salaries) a
group by emp_no;

select emp_no, salary from salaries order by emp_no limit 1000;

select a.emp_no,
	   a.salary as min_salary from
       (select emp_no, 
               salary,
               row_number() over w as row_num
from salaries 
window w as (partition by emp_no order by salary asc)) a
where a.row_num = 1;

select a.emp_no,
       a.salary as min_2nd_salary from
       (select emp_no,
               salary,
               row_number() over w as row_num
from salaries 
window w as (partition by emp_no order by salary asc)) a
where a.row_num = 2;

# ------------------------------------ L-271 Window Functions Exercises -----------------------------------------
select emp_no,
       salary,
       row_number() over (partition by emp_no order by salary desc) as row_num
from salaries 
where emp_no = '10560';

select m.emp_no,
       count(s.salary) as num_of_salary_contracts
from dept_manager m
join
salaries s on m.emp_no = s.emp_no
group by emp_no
order by emp_no;

select emp_no,
       salary,
       rank() over w as rank_num
from salaries 
where emp_no = '10560'
window w as (partition by emp_no order by salary desc);

select emp_no,
       salary,
       dense_rank() over w as dense_rank_num
from salaries 
where emp_no = '10560'
window w as (partition by emp_no order by salary desc);

# ------------------------------------ L-215 View Lecture -----------------------------------------
select * from dept_emp;

select emp_no, from_date, to_date, count(emp_no) as num
from dept_emp
group by emp_no
having num > 1;

create or replace view v_dept_emp_latest_date as
select emp_no, max(from_date) as from_date, max(to_date) as to_date
from dept_emp
group by emp_no;

select emp_no, max(from_date) as from_date, max(to_date) as to_date
from dept_emp
group by emp_no;

select * from employees.v_dept_emp_latest_date;

# ------------------------------------ L-216 View Exercises -----------------------------------------
select * from salaries;
select * from dept_manager;
create or replace view v_manager_average_salary as
select round(avg(salary),1) as avg_salary
from salaries s
join
dept_manager m on s.emp_no = m.emp_no;

select round(avg(salary),1) as avg_salary
from salaries s
join
dept_manager m on s.emp_no = m.emp_no;


