create database CompanyLLC

use CompanyLLC

create table Employee(
	Id int,
	Name nvarchar(50),
	Surname nvarchar(50),
	Email nvarchar(50),
	Salary int
)



insert into Employee
values('1','Rufet','Mezemov','mezemovrufet@gmail.com','1000'),
('2','Elbrus','Hasanzade','hasanzadeelbrus@gmail.com','1100'),
('3','Parvin','Yaqgubzade','pyaqubzada@gmail.com','1200'),
('4','Benovshe','Hacizade','hacizadeb@yahoo.com','1300'),
('5','Samir','Quluzade','samir1999@yahoo.com','1400'),
('6','Fuad','Muradov','f.muradov@std.beu.edu.az','1500'),
('7','Nergiz','Babayeva','nargizbabayeva@std.beu.edu.az','1600'),
('8','Nurmehemmed','Nabiyev','nurunabiyev@mail.ru','1700')


select (name + ' ' + surname) as Fullname, SUBSTRING(Email,CHARINDEX('@',Email)+1,Len(Email)) as Domain from employee



create table Students(
	Id int primary key identity,
	Name nvarchar(25) not null,
	Surname nvarchar(25),
	Email nvarchar(50)  constraint Email_UQ  unique
)

insert into Students
values('Vusal','Bagirov','vusal.bagirov@yandex.ru'),
('Ahad','Tagiyev','ahadvt@code.edu.az'),
('Hasan','Nuruzade','h.nuruzade@code.edu.az')

insert into Students
values(null,'Quliyeva','lalaig@code.edu.az')

alter table Students
alter column Name nvarchar(25)


alter table Students
drop constraint Email_UQ


alter table Students
add constraint Email_UQ unique(Email)

alter table Students
add Point int

alter table Students
add constraint Point_Check Check(Point<=100)

insert into Students
values('Nurlan','Mammadli','nurlanym@code.edu.az',100)

select Avg(point)as Average from students

select * from students
where point>(select avg(point) from students)


create table Groups(
	Id int primary key identity,
	Name nvarchar(20) constraint Name_UQ unique
)

insert into Groups
values('P223'),
('P225'),
('P325'),
('P405'),
('P355'),
('P500')


alter table Students
add GroupId int constraint FK_Stundents_GroupId foreign key(GroupId)
references Groups(Id)


insert into Students
values('Nurxan','Masimzade','nmasimzade@code.edu.az',75,null)

-- Join queries --

select * from Students
inner join Groups
on Students.GroupId = Groups.Id


select st.Id,st.Name,gr.Name from Students as st
left join Groups as gr
on st.GroupId = gr.Id

select * from Students
right join Groups
on Students.GroupId = Groups.Id


select * from students
full outer join groups
on students.GroupId = Groups.Id

create table Certificates(
	Id int primary key identity,
	Name nvarchar(20),
	Min int,
	Max int
)


insert into Certificates
values(N'Adi',65,85),
(N'Şərəf',86,95),
(N'Yüksək şərəf',96,100)

select * from certificates

select (s.Name + ' ' + s.Surname) as Fullname,s.point,c.Name as Diploma from Students s
join Certificates c
on s.Point between c.min and c.max


create table Teachers(
	Id int primary key identity,
	Fullname nvarchar(70),
	Profession nvarchar(30)
)


create table TeacherStudent(
	Id int primary key identity,
	StudentId int foreign key(StudentId) references Students(Id) ,
	TeacherId int foreign key(TeacherId) references Teachers(Id)
)


select t.Fullname as 'Teacher Name', (s.Name + ' ' + s.Surname) as 'Student Fullname' from TeacherStudent as ts
join Teachers as t
on ts.TeacherId = t.Id
join Students as s
on ts.StudentId = s.Id