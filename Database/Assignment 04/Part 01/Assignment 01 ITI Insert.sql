Use ITI

-- Insert into Student
insert into Student
values('Khadija','Mohamed','Beni Suef',22,70,NULL),('Ayesha','Ahmed','Mansoura',28,40,NULL)

-- Insert into Department
insert into Department
values(80,'C#','Web Development','Beni Suef',NULL,getdate()),(90,'C++','Geme Development','Menia',NULL,2/2/2009)

-- Insert into Innstructor
insert into Instructor
values(16,'Abdullah','Master',8632.0000,80),(17,'Sedra','Master',8696.0000,90)

-- Insert into Course
insert into Course
values(1300,'Python',40,5),(1400,'Ruby',60,3)

-- Insert into Topic
insert into Topic
values(7,'English'),(8,'Mathmatics')

-- Insert into Ins_Course
insert into Ins_Course
values(2,100,'Bad'),(6,700,'Excllent')

-- Insert into Stud_Course
insert into Stud_Course
values(400,62,80),(300,55,90)

-- DML
Update Instructor
set Salary=4000
where Dept_Id=30

Update Instructor
set Salary+=Salary*0.2

