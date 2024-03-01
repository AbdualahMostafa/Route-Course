Use MyCompany

--- 1.
select D.Dnum,D.Dname,E.SSN,E.Fname,E.Lname
from Departments D inner join Employee E
on D.MGRSSN=E.ssn

--- 2.
Select D.Dname,P.Pname 
from Departments D inner join Project P
on D.Dnum=P.Dnum

--- 3.
select dt.* ,E.Fname , E.Lname
from Dependent Dt inner  join Employee E
on E.SSN=Dt.ESSN

--- 4.
select *
from Project
where City in('alex','cairo')

--- 5.
select*
from Project
where Pname like 'a%'

--- 6.
select *
from Employee
where Salary between 1000 and 2000 and Dno=30 

--- 7.
select E.Fname+' '+E.Lname [Full Name]
from Employee E inner join Works_for W
on E.SSN=W.ESSn
inner join Project P
on P.Pnumber=W.Pno
where Dnum=10 and Hours>=10 and Pname='AL Rabwah'

--- 8.
select E.Fname,E.Lname,P.PName
from Employee E inner join Works_for W
on E.SSN=W.ESSn
inner join Project p 
on P.Pnumber=W.Pno
order by Pname

--- 9.
select P.Pnumber,D.Dname,E.Lname,E.Address,E.Bdate
from Employee E inner join Departments D
on D.Dnum=E.Dno
inner join Project p
on P.Dnum=D.Dnum
where City='Cairo'