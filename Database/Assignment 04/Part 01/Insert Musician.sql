Use Musician



--Insert into Musician
insert into Musician
values(7,'Sedra',11,'PortSaid','Saido'),(8,'Rana',88,'Cairo','Talat Harb')

--Insert into Album
insert into Album
values(25,'ElDonya',getdate()),(30,'Sa3baan Alya Nafcy',getdate())

--Insert into Instrument
insert into Instrument
values('Piano',28),('Bell',30)

--Insert into Song
insert into Song
values('AboSenn','Amr Salama'),('ElSadawy','Amr Khaled')

--Insert into Album_Song
insert Album_Song
values('AboSenn',5),('El3mroshy',10)

--Insert into Mus_Song
insert into Mus_Song
values('ElSadawy',5),('El3mroshy',7)

--Insert into Mus_Instrument
insert into Mus_Instrument
values(2,'Piano'),(4,'Bell')