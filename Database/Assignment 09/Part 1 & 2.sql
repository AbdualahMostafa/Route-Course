-- part 1

-- 
create table department
(
    DeptNo  INT PRIMARY key, 
    DeptName VARCHAR(50),
    deptLocation VARCHAR(50)
)

insert into  department
VALUES (1,'Research','NY'),
(2,'Accounting','DS'),
(3,'Marketing','KW')

CREATE TABLE Employee (
  EmpNo INT PRIMARY KEY,
  EmpFName VARCHAR(100) not null,
   EmplName VARCHAR(100) not null,
  DepartNO int foreign key references department(DeptNo)  ,
  salary INT unique 
 )

 insert into  Employee
VALUES (25348,'Mathew','Smith',	3,2500),
(10102,	'Ann','Jones',3,3000),
(18316,'John','Barrymore',1,2400)

 insert into  Project
VALUES (1,'Apollo',120000),
(2,'Gemini',95000),
(3,'Mercury',185600)

 insert into  works_on
VALUES (10102,1,'Analyst','2006.10.1'),
(10102,3,'Manager','2012.1.1')
-------------------------------------------------------------------------

--Testing Referential Integrity
--1
display error because foreign key not 
match primary key in employee table
and
and table has two primary key  
and when you insert you should give him two primary key 

--2
update dbo.Works_on
set empno=11111
where empno=10102

display error because foreign key not 
match primary key in employee table


--3
update HumanResourceSchema.Employee
set EmpNo=22222
where empno=10102

display error because 
match primary key in employee table
match foreign key in table works_on 


--4
delete works_on
where EmpNo = 10102
delete from Employee
where EmpNo = 10102
------------------------------------------------------------------------
--Table Modification
--1
alter table epmployee add  TelephoneNumber varchar(50)

--2
alter table epmployee drop column TelephoneNumber 

--3
create Schema Company

create Schema HumanResourceSchema

alter Schema company
transfer dbo.department

alter Schema company
transfer dbo.Project 

alter Schema HumanResourceSchema
transfer dbo.Employee


--3
update Company.project
set budget =budget+budget*0.1 
from dbo.works_on w, HumanResourceSchema.Employee e
,Company.project p
where e.EmpNo = w.EmpNo 
and w.ProjectNo=p.ProjectNo 
and w.EmpNo =10102 
and w.job='manager'

--4
update Company.department
set deptname ='Sales'
from Company.department d, HumanResourceSchema.Employee e
where e.departno = d.deptno
and e.empfname='james'

--5
update dbo.works_on 
set enter_date ='12.12.2007'
from dbo.works_on w, HumanResourceSchema.Employee e
,Company.project p, Company.department d
where  e.departno = d.deptno
and e.EmpNo = w.EmpNo 
and w.ProjectNo=p.ProjectNo 
and d.deptname='Sales'
and p.projectno=1

--6

delete from   dbo.works_on 
from Company.department d, HumanResourceSchema.Employee e,
 dbo.works_on w
where e.departno = d.deptno
and e.EmpNo = w.EmpNo 
and d.deptlocation='KW'


--part 02
--1

create table AuditTable2
(
  ProjectNo int ,
  UserName  varchar(50),
  ModifiedDate date,
  Budget_Old int,
  Budget_New int
)

create trigger auditTirgger7
on hr.project
after update
as

    if update(Budget )
	insert into AuditTable2
	select ProjectNo ,suser_sname(),getdate(), (select Budget from deleted),Budget from inserted


update hr.Project
set Budget=1000
where ProjectNo=2



--use iti

--•	Create an index on column (Hiredate) that
--allows you to cluster the data in table Department. What will happen?

create view  Department_hire
with schemabinding
as
   select d.Dept_Id,d.Dept_Desc,d.Dept_Location,d.Dept_Manager,d.Dept_Name,d.Manager_hiredate from 
   dbo.Department d


   create  unique clustered index	dateindex
   on dbo.Department_hire(Manager_hiredate)

   display error because age has duplicates
   or when create nonclustered index display
    you donot have unique index
--------------------------------------------------------------------

--2 Create an index that allows you to enter unique ages in the student table. What will happen?

 create unique index  index_student
 on student(st_age)

display error because age has duplicates
------------------------------------------------------------------------
--3-Try to Create Login Named(RouteStudent) who can access Only student and Course tables from ITI DB then 
--allow him to select and insert data into tables and deny Delete and update






