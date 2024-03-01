create database Musician
use Musician 

create table Musician(
M_Id int primary key identity(1,1),
M_Name varchar(20),
Ph_number int,
City varchar(20) default 'Cairo',
Street varchar(20)
)

create table Album(
A_Id int primary key,
Title varchar(20),
_Date date
)

create table Song(
_Title varchar(50) primary key,
Author varchar(20)
)

create table Instrument(
_Name varchar(50) primary key,
_Key int
)

create table Mus_Song(
Title varchar(50) references Song(_Title),
ID int references Musician(M_Id),
primary key(Title,ID)
)

create table Mus_Instrument(
id int references Musician(M_Id),
_name varchar(50) references Instrument(_Name),
primary key(id,_name)
)

create table Album_Song(
TTitle varchar(50) references Song(_Title),
A_Id int references Album(A_Id),
primary key(TTitle,A_Id)
)




