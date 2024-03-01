Use MyCompany

--- 1.Retrieve the names of all employees in department 10 who work more 
-- than or equal 10 hours per week on the "AL Rabwah" project

Select E.Fname+' '+E.Lname as [Full Name]
From Employee E inner join Works_for W
on E.SSN=W.ESSn
inner join Project P
on P.Pnumber=W.Pno
where E.Dno=10 and P.Pname='Al Rabwah' and W.Hours>=10
--------------------------------------------------------
--- 2. Find the names of the employees who were directly supervised by Kamel Mohamed.

Select X.Fname+' '+X.Lname as [Name of Employees],Y.Fname+' '+Y.Lname as [Supervised]
From Employee X join Employee Y
on Y.SSN=X.Superssn
where Y.Fname+' '+Y.Lname='Kamel Mohamed'
-----------------------------------------------------------
--- 3.  Display All Data of the managers
Select E.*
From Employee E join Departments D
on E.SSN=D.MGRSSN
------------------------------------------------------------
--- 4. Retrieve the names of all employees and the names of the projects 
-- they are working on, sorted by the project name
Select E.Fname+' '+E.Lname as [Full Name]
From Employee E inner join Works_for W
on E.SSN=W.ESSn
inner join Project P
on P.Pnumber=W.Pno
order by P.Pname Asc
--------------------------------------------------------------
--- 5. For each project located in Cairo City , find the project number, the 
-- controlling department name ,the department manager last name 
-- ,address and birthdate.

Select P.Pnumber,D.Dname,E.Lname,E.Address,E.Bdate
From Employee E inner join Departments D
on E.SSN=D.MGRSSN
inner join Project p
on P.Dnum=D.Dnum
where City='Cairo'
-----------------------------------------------------------------
--- 6. Display All Employees data and the data of their dependents even if they have no dependents
Select E.*,D.*
From Employee E inner join Dependent D
on E.SSN=D.ESSN