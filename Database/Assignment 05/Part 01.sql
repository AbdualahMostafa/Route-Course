Use ITI

--- 1. Retrieve a number of students who have a value in their age.
select count(St_Age) as NumOfStudents , Dept_Id
from Student
where Dept_Id is not null
group by Dept_Id
------------------------------------------------------
--- 2. Display number of courses for each topic name
select count(*) NumOfCourses , T.Top_Name
from Course C right join Topic T
on T.Top_Id=C.Crs_Id
group by T.Top_Name
--------------------------------------------------------
--- 3. Select Student first name and the data of his supervisor 
select St_Fname,Dept_Id
from Student
---------------------------------------------
--- 4. Display student with the following Format (use isNull function)
-- Student ID Student Full Name Department name
select isnull(St_Id,'Not found')
from Student

select isnull(St_Fname,isnull(St_Lname,'Not Found'))
from Student

select isnull(Dept_Name,'Not Found')
from Department
----------------------------------------------------
--- 5. Select instructor name and his salary but if there is no salary display 
-- value ‘0000’ . “use one of Null Function” 
select Ins_Name , isnull(Salary,0000)
from Instructor
-----------------------------------------------------
--- 6. Select Supervisor first name and the count of students who 
-- supervises on them
select X.St_Fname,count(X.St_Id) StudentSuperVises
from Student X join Student Y
on Y.St_super=X.St_Id and X.St_Fname is not null
group by X.St_Fname
-------------------------------------------------------
--- 7. Display max and min salary for instructors
select Min(Salary) The_MinimumSalary
from Instructor

select Max(Salary) The_MaximumSalary
from Instructor
--------------------------------------------------------
--- 8. Select Average Salary for instructors 
select Sum(Salary)/Count(Ins_Id) as Average
from Instructor
