Use ITI

--- 1.
select distinct Ins_Name  
from Instructor

--- 2.
select I.Ins_Name,D.Dept_Name
from Instructor I left join Department D
on D.Dept_Id=I.Dept_Id

--- 3.
Select St_Fname+' '+St_Lname [Full Name],Crs_Name, grade
from Student S inner join Stud_Course SC
on S.St_Id=SC.St_Id	
		inner join 
		Course C 
		on C.Crs_Id=SC.Crs_Id

--- Bouns
--- @@AnyExpression Its a global variable and 
--- global variable is a named memory variable that you access through SQL statements
select @@VERSION  -- its mean the version of microsoft sql server 2022(RTM-GDR)
select @@SERVERNAME -- its mean the name of the server i use  (lenovo-laptop)

