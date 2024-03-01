Use ITI

/* 1. Display instructors who have salaries less than the average salary 
 of all instructors. */
Select *
From Instructor
where Salary < (select avg(Salary) from Instructor)
------------------------------------------------------------
-- 2. Display the Department name that contains the instructor who 
-- receives the minimum salary.
Select D.Dept_Name
From Department D,Instructor I
where D.Dept_Id=I.Ins_Id 
and I.Salary=(select min(Salary) from Instructor)
------------------------------------------------------------
-- 3. Select max two salaries in instructor table. 
Select top(2) Salary as theMaxTwoSalary
From Instructor
order by salary desc
-------------------------------------------------------------
/* 4. Write a query to select the highest two salaries in Each 
Department for instructors who have salaries. “using one of 
Ranking Functions” */select Dept_Id , Salary from
(
select Dept_Id , Salary ,ROW_NUMBER () over(partition by dept_id order by salary desc) as rn
from Instructor
where Dept_Id is not null
)as newtable
where rn<=2select Dept_Id , Salary ,ROW_NUMBER () over(partition by dept_id order by salary desc) as rn
from Instructor
where Dept_Id is not null-----------------------------------/* 5. Write a query to select a random student from each department. 
“using one of Ranking Functions” */select Dept_Name,St_Fname
from
(
select d.Dept_Name,s.St_Fname ,ROW_NUMBER() over (partition by d.dept_id order by Newid()) as RN
from Department d  join Student s
on s.Dept_Id = d.Dept_Id
) as newtable
where rn=1
--==================================================================================


Use MyCompany
/* 1. Display the data of the department which has the smallest 
employee ID over all employees' ID. */
select d.*
from  Employee e , Departments d
where e.Dno = d.Dnum
and e.SSN = (select min(ssn) from Employee)
--------------------------------------------------
-- 2. . List the last name of all managers who have no dependents

--using left outer join
select e.Lname
from Departments d inner join Employee e on d.MGRSSN = e.SSN
left outer join Dependent dep on dep.ESSN = e.SSN
where dep.ESSN is null

--using subquery
select e.Lname
from Departments d inner join Employee e on d.MGRSSN = e.SSN
and e.SSN not in(select ESSN from Dependent)
----------------------------------------------------------------------
/* 3. For each department if its average salary is less than the average 
salary of all employees display its number, name and number of 
its employees */
Select Dno as DeptNum,d.Dname,count(e.SSN) numofemp
From Employee e , Departments D
where Dno is not null  and d.Dnum=e.Dno
group by Dno,d.Dname
having AVG(Salary)<(Select AVG(Salary) from Employee)
------------------------------------------------------
-- 4. Try to get the max 2 salaries using subquery
select salary
from employee
where salary IN 
(
    select  TOP (2) salary
    from employee
    order by  salary desc
)
-----------------------------------------------------------------
/* 5. Display the employee number and name if he/she has at least one 
dependent (use exists keyword) self-study. */
Select e.Fname,e.SSN
From Employee e
where exists( select 1
from Dependent d
where d.ESSN=e.SSN )
