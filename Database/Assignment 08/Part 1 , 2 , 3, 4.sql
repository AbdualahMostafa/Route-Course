use iti

--part 1

-- 1. 1.	 Create a view “V1” that displays student data for students who live in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=’tanta’
--Where st_address=’alex’;

create view v1
as

 select *
 from Student s
 where 	s.St_Address in('cairo','alex')
  with check option

Update V1 
set st_address='tanta'
Where st_address='alex';
-------------------------------------------------------------

--use sd32
-- 1.	Create view named “v_dept” that will display the department# and department name
create view  dbo.v_dept
as
 select d.DeptNo,d.DeptName
 from Department d
 
 select * from v_dept
-----------------------------------------------------

-- 2.using the previous view try enter new department data 
--where dept# is ’d4’ and dept name is ‘Development’

insert into v_dept
values(4,'development')
------------------------------------------------------
-- 3.Create view name “v_2006_check” that will display employee Number, 
/* the project Number where he works and the date of joining the project which must be 
from the first of January and the last of December 2006.this view will be used 
to insert data so make sure that the coming new data must match the condition */

create view  v_2006_check
as
 select e.EmpNo,p.ProjectName,w.Enter_Date
 from hr.employee e,hr.Project p,works_on w
  where e.EmpNo=w.EmpNo
  and p.ProjectNo=w.ProjectNo
  and w.Enter_Date between ('2006-01-01') and ('2006-12-31') 
     with check option 
----------------------------------------------------------------

--part02 

-- 1.Create a stored procedure to show the number of students per department.[use ITI DB] 
create proc ShowTheNumberOfStudentsPerDepartment
as

 select d.Dept_Name,count(s.St_Id)
 from Student s,Department d
 where s.Dept_Id=d.Dept_Id
  group by d.Dept_Name

 
 exec ShowTheNumberOfStudentsPerDepartment
---------------------------------------------------

-- 2.Create a stored procedure that will check for the Number of employees in the project 100 if 
--they are more than 3 print message to the user “'The number of employees in the project 100 is 3 or more'” 
--if they are less display a message to the user “'The following employees work for the project 100'” in addition
--to the first name and last name of each one. [MyCompany DB] 

create proc checkfortheNumberofemployeesintheproject
 as
 if (select count(e.SSN) 
          from Employee e,
		  Works_for w,Project p
          where e.SSN=w.ESSn
         and p.Pnumber=w.Pno
         and w.Pno=100 )   >= 3
	  print 'The number of employees in the project 100 is 3 or more'
	  else
	  select e.Fname,e.Lname
          from Employee e,
		  Works_for w,Project p
          where e.SSN=w.ESSn
         and p.Pnumber=w.Pno
         and w.Pno=100


	 checkfortheNumberofemployeesintheproject
--------------------------------------------------------------------------

-- 3.Create a stored procedure that will be used in case an old employee has left the project
--and a new one becomes his replacement. 
--The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number) 
--and it will be used to update works_on table. [MyCompany DB]

create proc oldemployeehaslefttheproject (@oldemp int,@newemp int,@projectno int)
as
update works_for 
set essn=@newemp 
where essn=@oldemp and pno=@projectno 

exec oldemployeehaslefttheproject 968574,968574,100
--------------------------------------------------------------------  
---part3

-- 1.Create a stored procedure that calculates the sum of a given range of numbers

create proc thatcalculatesthesumofagivenrange(@num1 int,@num2 int,@num3 int = 0 output,@num4 int = 0 )
as
 while(@num1<=@num2)
	   begin

	   set @num4+=@num1
	    
	   set @num1+=1
	   end
	   select @num3=@num4


	declare @num int
	execute thatcalculatesthesumofagivenrange 2,4 ,@num output
	select @num
-------------------------------------------------------------------------

-- 2.Create a stored procedure that calculates the area of a circle given its radius

create proc theareaofacirclegivenitsradius(@num1 DOUBLE PRECISION,@num DOUBLE PRECISION output )
as
    
	 select @num=3.14*@num1*@num1
		
declare @num DOUBLE PRECISION
execute theareaofacirclegivenitsradius 4.2 ,@num output 
select @num
-------------------------------------------------------------
--3.Create a stored procedure that calculates the age category 
--based on a person's age ( Note: IF Age < 18 then Category is Child and if  Age >= 18 
--AND Age < 60 then Category is Adult otherwise  Category is Senior) 

create proc calculatestheagecategorybasedonapersonsage (@age int,@name varchar(100)output)

as
  if @age<18
  select @name='Category is Child '

 else if @Age >= 18 AND @Age < 60 
 select @name='Category is Adult '
  
  else
  select @name='Category is Senior'

declare @name varchar(100)
execute calculatestheagecategorybasedonapersonsage  25 ,@name output 
select @name
--------------------------------------------------------------------------

-- 4.	Create a stored procedure that determines the maximum, minimum, and average of a given set of numbers
--( Note : set of numbers as Numbers = '5, 10, 15, 20, 25')

create proc determinesthemaximumandminimumandaverageofagivensetofnumbers 
  (@num1 int,@num2 int ,@num3 int,@num4 int,@num5 int,@max int output,@min int output,@avg int output)
  as 
 SELECT @max=MAX(v),@min=min(v),@avg=avg(v)  
 FROM (VALUES (@num1), (@num2 ), (@num3),(@num4),(@num5)) AS value(v)

 declare @max int ,@min int ,@avg int 
 exec determinesthemaximumandminimumandaverageofagivensetofnumbers 5,10,15,20,25,@max  output,@min  output,@avg  output
 select @max,@min,@avg
-------------------------------------------------------------------
 --part 04

 --1.Create a trigger to prevent anyone from inserting a new record in the Department table
 --( Display a message for user to tell him that he can’t insert a new record in that table )
  
  create trigger preventinsertofdepartment
   on department
   after insert
   as
   print 'you can’t insert a new record in this table '
---------------------------------------------------------------------------- 
--2.Create a table named “StudentAudit”. Its Columns are (Server User Name , Date, Note) 
	create table StudentAudit
	(
	username varchar(50),
	Date1 date,
	note varchar(50)
	)
--------------------------------------------------------------------
--3.Create a trigger on student table after insert to add Row in StudentAudit table 
T--he Name of User Has Inserted the New Student  
--Date Note that will be like ([username] Insert New Row with Key = [Student Id] in table [table name]


create trigger insertintoauditafterstudent
   on student
   after insert
   as
   
   insert into StudentAudit
   select suser_name(),getdate(),CONCAT(' username ',suser_name(),' student id ',st_id, ' table ',' student ' )from inserted 
   
   insert student (St_Id,St_Fname)
   values(48982,'amr')
--------------------------------------------------------------------

-- 4.Create a trigger on student table instead of delete to add Row in StudentAudit table 
--The Name of User Has Inserted the New Student Date
--Note that will be like “try to delete Row with id = [Student Id]” 

create trigger insteadofauditafterstudent
   on student
   instead of delete
   as
   insert into StudentAudit
   select suser_name(),getdate(),concat('try to delete row with id =  ', st_id )from deleted
   
   delete from student
   where st_id=16
------------------------------------------------------------------------

-- 5.Create a trigger that prevents the insertion Process for Employee table in March.

   create trigger preventstheinsertionProcessforEmployeeer
   on Employee
 instead of insert
   as
 
    if format(getdate(),'MMMM') = 'March' 
   print 'you can not enter in march '
   else
   insert into Employee
     select *from inserted 

	 insert into Employee(ssn)
	 values (1858)





