--- DDL => Data Definition Language
--- 1. Create
create database RouteCycle41G01

use RouteCycle41G01 

create table Employee(
SSN int primary key identity (1,1),
FName varchar(20) not null,
LName varchar(20),
Address varchar(50) default 'Cairo',
Salary money default 3000,
BDate date,
Gender char(1),
ManagerId int references Employee(SSN),
DeptId int
)

create table Departments(
DeptNumber int primary key identity (10,10),
DeptName varchar not null,
StartDate date,
ManagerSSN int references Employee(SSN)
)

create table DeptLoctaions(
DeptNumber int references Departments(DeptNumber),
Locations varchar(50) not null,
primary key (DeptNumber,Locations)
)
--- 2. Alter (Update)

alter table Employee
add foreign key(DeptId) references Departments(DeptNumber)

alter table Employee
add Test int
select * from Employee

alter table Employee
alter column Test varchar(20)

alter table Employee
drop column Test

--- 3. Drop (Remove)
alter table Departments
drop constraint FK__Departmen__Manag__4E88ABD4
drop table Employee