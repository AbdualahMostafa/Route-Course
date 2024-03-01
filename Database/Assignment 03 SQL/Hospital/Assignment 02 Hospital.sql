create database Hospital
use Hospital 

create table Patient(
P_Id  int primary key identity(1,2),
PName varchar(20) not null,
DOP date default getdate(),
CId int,  --- this is a foreign key and i will handle it by alter
WId int   --- this is a foreign key and i will handle it by alter
)

create table Consultant(
C_ID int primary key identity(5,10),
CName varchar(20)not null
)

create table Ward(
W_ID int primary key,
WName varchar(50),
N_Number int          --- this is a foreign key and i will handle it by alter
)

create table Nurse(
Number int primary key ,
Name varchar(20) not null,
Address varchar(20) default 'Al Maadie',
W_Id int			 --- this is a foreign key and i will handle it by alter
)

create table Drug(
D_Code int primary key,
Dosage varchar(20)
)

create table Drug_Brand(
Code int references Drug(D_Code),
Brand varchar(10),
primary key(Code,Brand)
)

create table Patient_Consultant(
P_id int references Patient(P_Id),
C_id int references Consultant(C_Id),
primary key(P_id,C_id)
)

create table Patient_Drug(
P_id int references Patient(P_Id),
C_id int references Consultant(C_ID),
datte date not null,
ttime time not null,
ddosage varchar(20),
primary key(P_id,C_id)
)

create table Patient_Nurse(
P_id int references Patient(P_Id),
Num int references Nurse(Number),
datte date not null,
ttime time not null,
ddosage varchar(20),
primary key(P_id,Num)
)

alter table Patient
add foreign key(CId) references Consultant(C_ID)

alter table Patient 
add foreign key(WId) references Ward(W_ID)

alter table Ward 
add foreign key(N_Number) references Nurse(Number)

alter table Nurse
add foreign key(W_Id) references Ward(W_ID)

