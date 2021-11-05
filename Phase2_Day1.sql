--create new database

CREATE DATABASE TrainingDB;

--use existing database
USE TrainingDB;

--create new db table named 'department'
CREATE TABLE Department
(deptId int,
deptName varchar(200),
deptLoc varchar(200),
deptAddedDate datetime);

--retrieve all data from department table
select * from Department;

--insert data to table
insert into Department values(101,'Sales','Chennai',GETDATE());
insert into Department values(102,'Testing','Bangalore','2021-11-01');  --generally used format
insert into Department values(103,'Development','Hyderabad','11-01-2021');
insert into Department values(104,'Admin','Hyderabad','11-2021-01');

--insert data to specific columns
insert into Department(deptId,deptName,deptLoc) values(105,'Advertisement','Chennai');

--update specific records
update Department
set deptLoc='Head',deptAddedDate=GETDATE()  --add cols to be updated separated with commas
where deptId=104;

--update all records
update Department
set deptAddedDate=GETDATE();

--delete specific records
delete from Department where deptLoc='Head';

--delete all records
delete from Department;

--drop table
drop table Department;

--creating table with constraints (keys)
--primary key-no null or duplicate values
--not null-duplicate can be there but no null values
--check-allows only the values mentioned
--default-adds default values to cols when data is not inserted

CREATE TABLE Department
(deptId int primary key,
deptName varchar(200) not null,
deptLoc varchar(200) check (deptLoc in ('Chennai','Bangalore','Hyderabad')),
deptAddedDate datetime default GETDATE());

--insert sample data to department
insert into Department values(101,'Sales','Chennai',GETDATE());
insert into Department values(102,'Testing','Hyderabad',default);
insert into Department(deptId,deptName,deptLoc) values(103,'Development','Bangalore');
insert into Department values(104,'Admin','Bangalore',default);
insert into Department values(105,'Production','CHennai',default);

select * from Department;

--create table with foreign key
--foreign key-helps in creating referncial integrity b/w tables
--unique constraint-No duplicate values
CREATE TABLE Employee
(empId int primary key,
empName varchar(200) not null,
empMail varchar(200) unique,
empSal float check(empSal>5000),
empAddedDate datetime default GETDATE(),
deptId int foreign key references Department(deptId));

select * from Employee;

--insert sample data to employee table
insert into Employee values(5001,'Karthik Sharma','karthik@gmail.com','12000',default,101);
insert into Employee values(5002,'King Kochhar','king@gmail.com','20000',default,102);
insert into Employee values(5003,'Shivani Bachan','shivani@gmail.com','22000',default,101);
insert into Employee values(5004,'Anashwara Krishnan','anu@gmail.com','15000',default,102);
insert into Employee values(5005,'Ashwini Patel','ashwini@gmail.com','30000',default,103);
insert into Employee values(5006,'Anupam Paul','anupam@gmail.com','8000',default,104);
insert into Employee values(5007,'Kakon Chattaraj','kakon@gmail.com','10000',default,103);
insert into Employee values(5008,'Kapil Singh','kapil@gmail.com','21000',default,104);
insert into Employee values(5009,'Lee Jukyuong','Lee@gmail.com','21000',default,null);

--projection: restricting columns
select empId,empName,empSal from Employee;

--selection: restricting rows
select * from Employee where empSal>15000;

--projection and selection: restricting columns and rows
select empId,empName,empSal from Employee where empSal>15000;

--arithmetic operator (+,-,*,/)
select empId,empName,empSal*12 as 'Annual Salary'  --Annual Sal is the col which will show *12 result, Annual Salary is alias name, if name is not given it will show No column name
from Employee where empSal>15000;

--logical operators (AND ,OR,NOT)
select empId,empName,empSal 
from Employee 
where empSal>=10000 and empSal<=20000;

select empId,empName,empSal 
from Employee 
where empName='Karthik Sharma' and empSal=12000;

select empId,empName,empSal 
from Employee 
where empName='Karthik Sharma' or empName='Kakon Chattaraj' or empSal=8000;

select empId,empName,empSal 
from Employee 
where empName='Karthik Sharma' and not empSal=20000;

--misc operators (between,not between,in,not in,is null)
--between will include upper and lower limit
select empId,empName,empSal 
from Employee 
where empSal between 10000 and 20000;

select empId,empName,empSal 
from Employee 
where empSal not between 10000 and 20000;

select empId,empName,empSal 
from Employee 
where empName in ('Karthik Sharma','Kakon Chattaraj','Shivani Bachan');

select empId,empName,empSal 
from Employee 
where empName not in ('Karthik Sharma','Kakon Chattaraj','Shivani Bachan');

select * from Employee where deptId is null;

--like operator
select empId,empName,empSal 
from Employee 
where empName like '%a';

select empId,empName,empSal 
from Employee 
where empName like '%a%';

select empId,empName,empSal 
from Employee 
where empName like '_a%';

select empId,empName,empSal 
from Employee 
where empName like 'S%';

--join: retrieveing data from more than one table
--retrieve empName and their deptName
select Employee.empName,Employee.empSal,Department.deptName,Department.deptLoc
from Employee join Department   --table which has foreign key should be on left, table whose col is being used as foreign key dhould be on right
on Employee.deptId=Department.deptID;

-- giving alias name for tables
select e.empName,e.empSal,d.deptName,d.deptLoc
from Employee e join Department d  
on e.deptId=d.deptID
and e.empSal>15000;

--joins in sql
--inner join/equi join/default join
--outer join: left outer join/right outer join/full outer join


--left outer join: retrieves all records from left table and only matched records from right table
select e.empName,e.empSal,d.deptName,d.deptLoc
from Employee e left outer join Department d  
on e.deptId=d.deptID;

--right outer join: retrieves all records from right table and only matched records from left table
select e.empName,e.empSal,d.deptName,d.deptLoc
from Employee e right outer join Department d  
on e.deptId=d.deptID;

--full outer join: retrieves all matcghed and unmatched records from both tables
select e.empName,e.empSal,d.deptName,d.deptLoc
from Employee e full outer join Department d  
on e.deptId=d.deptID;

--pending:
--self join
--cross join
--joining tables without join keyword