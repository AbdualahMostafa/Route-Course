Use MyCompany

--- 1. For each project, list the project name and the total hours per 
-- week (for all employees) spent on that project.
Select P.Pname,SUM(W.Hours)*7 as TotalHoursPerWeek
From Project P join Works_for W
on W.Pno = P.Pnumber
group by P.Pname
--------------------------------------------------------
--- 2. For each department, retrieve the department name and the 
-- maximum, minimum and average salary of its employees.
Select D.Dname,Min(E.Salary) as Minimum_Sal ,Max(E.Salary) as Maximum_Sal,
SUM(E.Salary)/Count(E.SSN) as Average_Sal
From Departments D join Employee E
on D.Dnum = E.Dno
group by D.Dname
---------------------------------------------------
--- 3. Retrieve a list of employees and the projects they are working 
-- on ordered by department and within each department, 
-- ordered alphabetically by last name, first name.
Select E.*,Pname
From Employee E inner join Works_for W
on E.SSN=W.ESSn 
inner join Project P
on P.Pnumber=W.Pno
order by E.Dno,E.Fname,E.Lname
---------------------------------------------------------
--- 4. Try to update all salaries of employees who work in Project ‘Al 
-- Rabwah’ by 30%
Update Employee 
Set Salary+=Salary*0.3
Select E.*,Pname
From Employee E inner join Works_for W
on E.SSN=W.ESSn 
inner join Project P
on P.Pnumber=W.Pno
where P.Pname='Al Rabwah'
-------------------------------------------------
--- DML
--- 1. In the department table insert a new department called "DEPT IT" , with id 100, employee with SSN = 112233 as a 
-- manager for this department. The start date for this manager 
-- is '1-11-2006'.

Insert into Departments
Values ('DEPT IT',100,112233,11/1/2006)
--------------------------------------------------
--- 2. Do what is required if you know that : Mrs.Noha 
/* Mohamed(SSN=968574) moved to be the manager of the 
new department (id = 100), and they give you(your SSN 
=102672) her position (Dept. 20 manager) 

a. First try to update her record in the department table */

Update Departments
Set MGRSSN=968574
where Dnum=100

-- b) Update your record to be department 20 manager.

Insert into Employee
Values ('Abdullah','Mostafa',102672,'2002-12-30','Beni Suef','M',10000,968574,NULL)

Update Departments
Set MGRSSN=102672
where Dnum=20

-- c) Update the data of employee number=102660 to be in 
-- your teamwork (he will be supervised by you) (your SSN =102672)
Update Employee
Set Dno=20
where SSN=102660

Update Employee
Set Superssn=102672
where SSN=102660
-----------------------------------------------------
--- 3 
/*
Unfortunately the company ended the contract with Mr.Kamel 
Mohamed (SSN=223344) so try to delete him from your 
database in case you know that you will be temporarily in his 
position.
Hint: (Check if Mr. Kamel has dependents, works as a department manager, 
supervises any employees or works in any projects and handles these cases).
*/

Update Employee
Set Superssn=102672
where Superssn=223344


Update Dependent
Set ESSN=102672
where ESSN=223344

Update Departments
Set MGRSSN=102672
where MGRSSN=223344

Update Works_for
Set ESSn=102672
where ESSn=223344

delete from Employee
where SSN=223344