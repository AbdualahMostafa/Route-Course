Use MyCompany
--- 1. Display all the employees Data.select * from Employee--- 2. Display the employee First name, last name, Salary and Department number
select Fname,Lname,Salary,Dno
From Employee

--- 3. Display all the projects names, locations and the department which is responsible for it.select Pname,Plocation,Dnumfrom Project--- 4. select Fname+' '+Lname [Full Name],Salaryfrom EmployeeUpdate EmployeeSet Salary += Salary * 0.1 *12--- 5. -- The Id in this is SSNselect SSN,Fname+' '+Lname [Full Name]from Employeewhere Salary>1000--- 6.select  SSN,Fname+' '+Lname [Full Name]from EmployeeUpdate EmployeeSet Salary+=Salary*12where salary>10000--- 7.select Fname+' '+Lname [Full Name],Salaryfrom Employeewhere Sex='F'--- 8.select Dname,Dname from Departmentswhere MGRSSN=968574--- 9.select Pnumber,Pname,Plocationfrom Projectwhere Dnum=10