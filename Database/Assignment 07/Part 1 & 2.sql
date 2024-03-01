use iti
 -- part 01  

-- 1. Create a scalar function that takes a date and returns the Month 
-- name of that date.
create function fdata(@data date)
returns varchar(20)
begin
       return(select format(@data,'MMMM'))
	   end

select  dbo.fdata('2000-01-01')
----------------------------------------------
-- 2. Create a multi-statements table-valued function that takes 2
-- integers and returns the values between them.

alter function valuebetweenthem(@num1 int,@num2 int)
returns @table table
(
	num int

)

as  

   begin
 
     while (@num1<@num2-1)
	
	  	begin
		 set @num1+=1
	  insert into @table
	  select @num1
	 
	  end
     
	return
	end

	select *from valuebetweenthem(10,20)
---------------------------------------------------------
-- 3. Create a table-valued function that takes Student No and 
-- returns Department Name with Student full name.

create function studentwithdepartment(@id int)
returns table
as
return
(
   select concat(st_fname,' ',st_lname,' ') as fullname,dept_name
     from student s,Department d
	 where s.Dept_Id=d.Dept_Id

)

select *from studentwithdepartment(1)
--------------------------------------------------------------
-- 4. Create a scalar function that takes Student ID and returns a 
/*message to user 
a. If first name and Last name are null then display 'First 
name & last name are null'
b. If First name is null then display 'first name is null'
c. If Last name is null then display 'last name is null'
d. Else display 'First name & last name are not null' */

create function returnmessage(@id int)
returns varchar(50)
begin
        declare @fan varchar(50)
		 if @id in(select st_id from Student where St_Fname is null and St_Lname is null)
 		 	 select @fan='first and last name is null'
       else if @id in(select st_id from Student where St_Fname is null and St_Lname is not null  )
 		 	 select @fan='first name is null'
		else if @id in(select st_id from Student where St_lname is null and St_fname is not null)
 		 	 select @fan='last name is null'
       else
	   select @fan='last name and last name is not null'


			 return @fan
			 end


select dbo.returnmessage(1)
--------------------------------------------------------
-- 5. Create a function that takes an integer which represents the 
--format of the Manager hiring date and displays department 
--name, Manager Name and hiring date with this format.

create function mang_dept(@num int)
returns table
as
return
(
        select i.Ins_Name,d.Dept_Name,d.Manager_hiredate
		from Instructor i ,Department d
		where i.Ins_Id=d.Dept_Manager
		and CONVERT(DATE,CONVERT(VARCHAR(50), @num),101)in(d.Manager_hiredate)
        
)

select *from  mang_dept(20080504)
----------------------------------------------------------
--6 6. Create multi-statement table-valued function that takes a string
/* a. If string='first name' returns student first name
b. If string='last name' returns student last name 
c. If string='full name' returns Full Name from student table 
(Note: Use “ISNULL” function) */

create function takestring(@takes varchar(50))
returns @table table
(
  
  name varchar(100)

)
as 
begin
 
         if @takes='first name'
		 insert into @table
		 select isnull(St_Fname,' ') from student 
	
		  
    	 else if @takes='last name'
		 insert into @table
		 select isnull(St_lname,' ') from student 
		 
		 else if @takes='full name'
		 insert into @table
		 select  isnull (St_Fname,' ')+' ' +isnull (St_Fname,' ') from student 
	
		 return
		 end

select *from takestring('full name')
------------------------------------------------------------------		  
-- 7. Create function that takes project number and display all 
--employees in this project (Use MyCompany DB
create function project_number(@num int)
returns table
as
return
(
 select e.*
 from employee e,works_for w,project p
  where e.ssn=w.essn
  and w.pno=p.pnumber
  and @num =e.dno

)

select *from project_number(20)
--------------------------------------------------------------------
--------------------------------------------------------------------

-- part 02(views)
-- 1. Create a view that displays the student's full name, course 
--name if the student has a grade more than 50. 

create view vdata
as
    select isnull(s.St_Fname,' ')+' '+isnull(s.St_lname,' ') as fullname
	 ,c.Crs_Name
	from student s,Stud_Course sc ,Course c
	where s.St_Id=sc.St_Id
	and c.Crs_Id=sc.Crs_Id
	and sc.Grade>50

 select *from vdata
-------------------------------------------------------------
-- 2. Create an Encrypted view that displays manager names and 
-- the topics they teach. 
create view vins_top
with encryption
as
 select i.Ins_Name,t.Top_Name
 from Instructor i join Department d
  on i.Ins_Id=d.Dept_Manager
  join Student s
  on s.Dept_Id=d.Dept_Id
  join Stud_Course sc
   on s.St_Id=sc.St_Id
   join Course c
   on c.Crs_Id=sc.Crs_Id
   join Topic t
   on t.Top_Id=c.Top_Id
-------------------------------------------------------------------
-- 3. Create a view that will display Instructor Name, Department 
/* Name for the ‘SD’ or ‘Java’ Department “use Schema binding” 
and describe what is the meaning of Schema Binding */

  create view dbo.ins_dept
  with schemabinding
  as
  select i.Ins_Name,d.Dept_Name
 from dbo.Instructor i join dbo.Department d
  on i.Dept_Id=d.Dept_Id
  where  d.Dept_Name in('java','sd')
   --Schema binding is a feature in SQL Server that helps enforce
   --a relationship between database objects, such as views or functions,
   --and the underlying tables they reference. When you create an object
   --with schema binding, you are essentially binding that object to the 
   --schema of the underlying tables. This means that the structure of the 
   --underlying tables cannot be modified in a way that would break the schema-bound object.
-------------------------------------------------------------------------------
-- 4. Create a view that will display the project name and the 
-- number of employees working on it. (Use Company DB)
     create view project_employee
	 as
	 select p.pname,count(ssn)
	 from employee e, Departments d,project p
	  where e.dno=d.dnum
	  and p.dnum=d.dnum
	  group by p.pname
----------------------------------------------------------------
-- 1. Create a view named “v_clerk” that will display employee 
-- Number ,project Number, the date of hiring of all the jobs of 
-- the type 'Clerk'.

create view hr.v_clerk
as

     select e.empno,p.projectno,w.Enter_Date
	 from hr.employee e,dbo.works_on w, hr.project p
	 where e.empno=w.empno
	 and w.projectno = p.projectno
	 and w.job='clerk'
-------------------------------------------------------------------------
-- 2. Create view named “v_without_budget” that will display all 
-- the projects data without budget

create view hr.v_without_budget
as
select ProjectName,projectno
   from hr.project 
---------------------------------------------------------------------  
-- 3. Create view named “v_count “ that will display the project 
-- name and the Number of jobs in it

 create view hr.v_count 
  as
  select p.ProjectName ,count(w.EmpNo)as countjob
	 from dbo.works_on w, hr.project p
	 where p.projectno=w.projectno
	 group by p.ProjectName
------------------------------------------------------------------------
-- 4. Create view named ” v_project_p2” that will display the emp# 
-- s for the project# ‘p2’ . (use the previously created view “v_clerk”)

 create view hr.v_project_p2
 as
  select empno
  from hr.v_clerk
  where projectno=2
------------------------------------------------------------

-- 5. modify the view named “v_without_budget” to display all DATA in project p1 and p2.
alter  view hr.v_without_budget
as
select *
   from hr.project 
------------------------------------------------------------------  
-- 6. Delete the views “v_ clerk” and “v_count”

 --1
  drop view hr.v_clerk
 --2
  drop view hr.v_count
-----------------------------------------------------  
  
-- 7. Create view that will display the emp# and emp last name who works on deptNumber is ‘d2’
    create view hr.v_dept1
	as
   select e.empno,e.emplname
   from hr.employee e,department d
   where e.deptno=d.deptno
   and d.Deptno=2
-----------------------------------------------------------------------

-- 8. Display the employee lastname that contains letter “J” (Use 
-- the previous view created in Q#7)   
   select emplname
   from hr.v_dept1
   where emplname like '%[j]%'
---------------------------------------------------------------------------   

-- 9. Create view named “v_dept” that will display the department# and department nam
    create view hr.v_dept
	as
	select deptname,deptno
	from dbo.Department