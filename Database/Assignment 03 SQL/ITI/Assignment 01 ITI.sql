create database ITI
use ITI
create table Student(
Stu_Id int primary key,
Fname varchar(20)  not null,
Lname varchar(20) not null,
Address varchar(50) not null,
Age int not null,
Dept_Id int  --- this is a foreign key and i will handle it by alter 
)

create table Course(
CrsID int primary key identity(1,1),
CName varchar(20) default 'Database',
Duration int,
Desciption varchar(20),
T_Id int   --- this is a foreign key and i will handle it by alter 
)

create table Departments(
DeptId int primary key identity(1,1),
DeptName varchar(10) default 'CS',
InsId int,   --- this is a foreign key and i will handle it by alter 
HiringDate date default getdate()
)

create table Instructor(
Ins_ID int primary key identity(1,1),
InsName varchar(20) default 'End Ahemed Khaled',
Bouns money default 1000,
Ins_Address varchar(20) default 'Cairo',
Salary money default 5000,
HourRate int,
Dpt_ID int references Departments(DeptId)
)

create table Topic(
TID int primary key identity (5,10),
TName varchar(20) default 'Mapping'
)

create table Stu_Crs(
Stu_Id int references Student(Stu_Id),
Crs_Id int references Course(CrsID),
Grade int,
primary key(Stu_Id,Crs_Id)
)

create table Crs_Ins(
CID int references Course(CrsID),
Ins_id int references Instructor(Ins_ID),
Evaluation varchar(50) not null,
primary key(CID,Ins_id)
)

alter table Student 
add foreign key(CId) references Course(CrsID)

alter table Course
add foreign key(T_Id) references Topic(TID)

alter table Departments
add foreign key(InsId) references Instructor(Ins_ID)

