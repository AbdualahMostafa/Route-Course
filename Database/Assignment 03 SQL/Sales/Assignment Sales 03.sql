create database Sales

use Sales

create table Employee(
Emp_Id int primary key,
Emp_Name varchar(20) not null,
Emp_Num int             --- this is a foreign key and i will  hadle it by alter
)

create table Sales(
Num int primary key,
Loc varchar(20),
S_id int references Employee(Emp_Id)
)

create table Property(
P_Id int primary key,
Address varchar(50),
City varchar(20),
State varchar(10),
Code int,
Number int references Sales(Num)
)

create table Ownerr(
O_Id int primary key,
O_Name varchar(20)
)

create table Property_Ownerr(
PID int references Property(P_Id),
OID int references Ownerr(O_Id),
Precent int,
primary key(PID,OID)
)

alter table Employee
add foreign key(Emp_Num) references Sales(Num)