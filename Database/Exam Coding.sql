Use Library

-- 1. Write a query that displays Full name of an employee who has more than
-- 3 letters in his/her First Name

select concat(Fname,' ',Lname) 'Full Name'
from Employee
where len (Fname)> 3
------------------------------------------------------
-- 2. Write a query to display the total number of Programming books
-- available in the library with alias name ‘NO OF PROGRAMMING
-- BOOKS’ 

select Count(B.Title) 'NO OF PROGRAMMINGBOOKS'
from Book B,Category C
where B.Cat_id=C.Id
group by B.Cat_id
having B.Cat_id=1
------------------------------------------------------
-- 3. Write a query to display the number of books published by
--(HarperCollins) with the alias name 'NO_OF_BOOKS'.

select Count(*) 'NO_OF_BOOKS'
from Book B,Publisher P
where P.Id=B.Publisher_id
and P.Name='HarperCollins'
-----------------------------------------------------
-- 4. Write a query to display the User SSN and name, date of borrowing and
--due date of the User whose due date is before July 2022

select B.User_ssn,u.User_Name,b.Borrow_date,b.Due_date
from Users u,Borrowing b
where u.SSN=b.User_ssn 
and b.Due_date between '2021-02-27' and '2022-07-30'
-----------------------------------------------------
-- 5. Write a query to display book title, author name and display in the
--following format,
--[Book Title] is written by [Author Name]

select concat(B.Title,' is written by ',A.Name)
from Book B,Book_Author BA,Author A
where B.Id=BA.Book_id and BA.Author_id=A.Id
--------------------------------------------------------
-- 6. Write a query to display the name of users who have letter 'A' in their names

select User_Name
from Users
where User_Name like '%A%'
---------------------------------------------------------
-- 7. Write a query that display user SSN who makes the most borrowing

select User_ssn
from Borrowing
where Amount=(select max(Amount)
				from Borrowing
		   	 )

------------------------------------------------------------
-- 8. Write a query that displays the total amount of money that each user paid
-- for borrowing books. 

select u.SSN,u.User_Name,SUM(B.Amount)
from Users u,Borrowing B
where u.SSN=B.User_ssn
group by u.User_Name,u.SSN
----------------------------------------------------------
-- 9. write a query that displays the category which has the book that has the
-- minimum amount of money for borrowing

select C.cat_name,B.title,W.Amount 
from Category C,Book B,Borrowing W
where C.Id=B.Cat_id and B.Id=w.Book_id
and W.Amount=(select 
		 min(Amount)from Borrowing)
---------------------------------------------------------

-- 10. write a query that displays the email of an employee if it's not found,
-- display address if it's not found, display date of birthday

select coalesce (Email,Address,convert(varchar(50),DOB),'Not Found')
from Employee
------------------------------------------------------

-- 11. Write a query to list the category and number of books in each category
-- with the alias name 'Count Of Books'.

select c.Id,count(b.Cat_id)'Count Of Books'
from Category c,Book b
where c.Id=b.Cat_id
group by c.Id

select C.Cat_name 'Category',count(B.Id) 'Count Of Books'
from Category C,Book B
where C.Id=B.Cat_id
group by C.Cat_name
----------------------------------------------------

-- 12. Write a query that display books id which is not found in floor num = 1
-- and shelf-code = A1.

select B.Id
from Book B,Shelf S,Floor F
where S.Code=B.Shelf_code and S.Floor_num=F.Number
and s.Floor_num <> 1 and b.Shelf_code <> 'A1'
---------------------------------------------------------------
-- 13. Write a query that displays the floor number , Number of Blocks and
-- number of employees working on that floor

select f.Number,f.Num_blocks,count(f.MG_ID) 'NumberOfEmployeesWorkingOnThatFloor' 
from Employee e,Floor f
where e.Floor_no=f.Number
group by f.Num_blocks,f.Number
-------------------------------------------------------

-- 14. Display Book Title and User Name to designate Borrowing that occurred
-- within the period ‘3/1/2022’ and ‘10/1/2022’.

select u.User_Name,b.Title
from Users u,Borrowing w,Book b
where w.User_ssn=u.SSN and w.Book_id=b.Id 
and w.Borrow_date between '3-1-2022' and '10/1/2022'
---------------------------------------------------------------------

-- 15.Display Employee Full Name and Name Of his/her Supervisor as Supervisor Name.

select emp.Fname,managers.Fname
from Employee emp,Employee managers
where managers.Id=emp.Super_id
------------------------------------------------------------------

-- 16.Select Employee name and his/her salary but if there is no salary display
-- Employee bonus.

select concat(Fname,' ',Lname) 'Full Name',coalesce (Salary,Bouns) 'Amount'
from Employee 
-----------------------------------------------------------------

-- 17.Display max and min salary for Employees

select max(Salary) 'MaxSalary',min(Salary) 'MinSalary'
from Employee
-----------------------------------------------------------------

-- 18.Write a function that take Number and display if it is even or odd 

create function GuessEvenOdd(@Num int)
returns nvarchar(20)
as 
begin 
  declare @temp nvarchar(20)
  
  if @Num % 2 = 0
    set @temp = 'even'
  else 
    set @temp = 'odd'
  
  return @temp
end;
select dbo.GuessEvenOdd(8) AS Result
-------------------------------------------------------------

-- 19.write a function that take category name and display Title of books in that category

create function Solve(@temp varchar(20))
returns varchar(30)
as 
 begin 
   declare @x varchar(20)
   select @x=b.Title
   from Category c,Book b
   where c.Id=b.Cat_id 
   and c.Cat_name=@temp
   return @x
 end 
 select dbo.Solve('programming ')
 -------------------------------------------------------

 -- 20. write a function that takes the phone of the user and displays Book Title ,
-- user-name, amount of money and due-date

create function GetValues(@PhoneNum varchar(20))
returns table
as 
return  (

		select  u.User_Name,b.Title,w.Amount,w.Due_date
		from Book b,Borrowing w,Users u,User_phones v
		where b.Id=w.Book_id and w.User_ssn=u.SSN 
		and v.Phone_num=@PhoneNum
		)
select * from dbo.GetValues('0123654122')
------------------------------------------------------------

-- 21.Write a function that take user name and check if it's duplicated
-- return Message in the following format ([User Name] is Repeated
-- [Count] times) if it's not duplicated display msg with this format [user
-- name] is not duplicated,if it's not Found Return [User Name] is Not Found




---------------------------------------------------------------------------

-- 22.Create a scalar function that takes date and Format to return Date With That Format.

create function dbo.FormatDate(@date datetime, @format nvarchar(max))
returns nvarchar(max)
as
begin
  declare @formattedDate nvarchar(max);
  set @formattedDate = format(@date, @format);
  return @formattedDate;
end
select dbo.FormatDate(getdate(),'%Y-%m-%d')
---------------------------------------------------------

-- 23.Create a stored procedure to show the number of books per Category



----------------------------------------------------------

-- 24.Create a stored procedure that will be used in case there is an old manager
-- who has left the floor and a new one becomes his replacement. The
-- procedure should take 3 parameters (old Emp.id, new Emp.id and the
-- floor number) and it will be used to update the floor table.


-------------------------------------------------------------------
-- 25.Create a view AlexAndCairoEmp that displays Employee data for users
-- who live in Alex or Cairo.

create view  AlexAndCairoEmp
as 
select e.*
from Users u,Employee e
where u.Emp_id=e.Id
and e.Address in ('Cairo','Alex')

select * from AlexAndCairoEmp
---------------------------------------------------------------

-- 26.create a view "V2" That displays number of books per shelf

alter view V2
as 
select S.Code,b.Title,count(b.Id) 'num_books'
from Shelf S left join Book b
on s.Code=b.Shelf_code
group by S.Code,b.Title
having b.Title is not null 
select * from V2
---------------------------------------------------------------