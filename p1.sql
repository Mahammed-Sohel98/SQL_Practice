create database practice;
use practice;

# ---------------------------------- DDL (create, alter , drop, truncate) Data defination language-------------------------------------------------------

create table data (e_id int, e_name varchar(50),salary decimal(15,2));
show tables;
select * from data;
desc data;
alter table data modify column salary decimal(20,2);
alter table data change column e_name emp_name varchar(30);
alter table data add column mail varchar(40);
alter table data modify column mail varchar(40) after salary;
alter table data add column e_add varchar(50),add column phone varchar(30);
select * from data;
alter table data drop column e_add;
desc data;

# -------------------------DML (insert, delete, update) Data manupulation language -------------------------------------------------------------------

select * from data;

set autocommit = 0;

insert into data values
(101,'sohel',20000,'sohel@gmail.com',1234567892,'HR'),
(102,'alex',25000,'alex@gmail.com',2345678901,'IT_manager'),
(103,'martina',25000,'martina@gmail.com',2231342,'FIN_Assistance'),
(104,'janefer',30000,'janifer@gmail.com',23424,'FIN_Manger');

insert into data(e_id,emp_name,salary,dept) value
(106,'martis',30000,'IT_Admin'),
(107,'tsubsha',25000,'MKT_Lead');


insert into data(e_id,emp_name,salary,mail,dept) value
(108,'martis',30000,'martis@gamail,com','IT_lead'),
(109,'tsubsha',25000,'tsubasha@gmail.com','HR_Associate'),
(110,'hary',20000,'harry@gmail.com','MKT_Intern');

update data set phone = 234242443
where e_id = 103;

start transaction;

update data set emp_name = 'warner',salary = 24000,mail = 'warner@gmail.com'
where e_id = 100;
savepoint a;

insert into data(e_id,emp_name,salary,mail) value
(107,'alpha',30000,'alpha@gamail,com'),
(108,'kaniki',25000,'kaniki@gmail.com');
 SAVEPOINT B;
 
 update data set emp_name = 'Tsubasha',mail = 'tsubasha@gmail.com' where e_id = 106;
 savepoint c;

rollback to a;

delete from  data where e_id = 105 or e_id = 106;
select *  from data;
show tables;


select * from copy;
select * from copy_data;
create table copy_data as select * from data;


# ------------------------DQL (Select) Data query language  ------------------------------------------------------------

select * from data;

select * from data where salary > 24000;

alter table data add column bonus decimal(15,2);
alter table data change column bonus dept varchar(30);
truncate data;


select * from data where salary >25000 and mail is not null;

select emp_name,salary from data where salary > 20000 or salary <25000;
select emp_name,salary from data where salary between 20000 and 25000;

#----------- Wildcard search-------------------------------------
# If we don't know the spacific value then only we use LIKE keyword


select * from data where dept like '%it%';  # find the IT any where in dept column
select * from data where dept like 'M%';	# find the M only present in first place
select * from data where dept like '%m%';	
select * from data where dept like '%N';	# find N but not present in first place

#---- IN -------------------------------------
select * from data;
select * from data where salary in (20000,23000);  # find the multiple value form the salary column
select * from data where emp_name not in ('sohel', 'alex','martina'); # it show othe name from emp_name column exclude these mantion name 

use practice;


# ---------------------------------------------- JOINS ---------------------------------------------------------------------------------



Create table employees (employee_id int auto_increment unique, first_name varchar(30),last_name varchar(30),
jon_id varchar(30),salary decimal(15,2),manager_id int, department_id int)
auto_increment = 100;
alter table employees auto_increment = 100;
select * from employees;
alter table employees change column jon_id job_id varchar(30);

insert into employees(first_name,last_name,job_id,salary,manager_id,department_id) values
('Lax',"De Haan",'AD_VP',17000,100,100),
('Alexahder','Hunoid','IT_PROG',9000,102,30),
('Bruce','Emst','IT_PROG',6000,103,30),
('David','Austin','ACCOUNT',4800,103,70),
('Valli','Pataballa',"STRATEGY PLANNER",14000,103,110),
('Diana','Loentz','IT_DEV',10000,100,30),
('Nancy','Greeberg','MARKETING',12000,102,90),
('Danial','Faviet','RELATIONSHIP_MGR',20000,104,120),
('Jhon','Chen','FINANCE',15000,103,50),
('Ismael','Sciarra','MARKETING',10000,104,40),
("Jose Maunai",'Utman','FINANCE',12000,107,80),
('Michal','Jordan','IT_ADMIN',16000,105,30),
('Mohammed','Arif','ACCOUNT',21000,107,70),
('Kally','Anderson','FINANCE',18000,105,80),
('Stivan','Smith','ACCOUNT',22000,105,70);
insert into employees(first_name,last_name,job_id,salary) values
('Neena','Kochar','CEO',30000);
insert into employees(first_name,last_name,job_id,salary) values
('Steven','King','CA',13000);

update employees set job_id = 'ACCOUNTANT' where employee_id = 103 or employee_id =112 or employee_id=114;

update employees set manager_id = 115 where employee_id = 100;
select * from employees;



Create table department (department_id int , department_name varchar(30));
insert into department values
(30,'IT'),(40,'Sales'),(50,'Finance'),(60,'Account'),(70,'Treasury'),(80,"Corporate Tax"),(90,'Purchasing'),
(100,'Executive'),(110,"Human Resources"),(120,"Public Relation");
Select * from department;
show tables;




# --------------------------------------------------**********------------------------------------------------

alter table department change column  dept_id department_id varchar(30);

# How to find out the common column betwneen tables ?

select column_name from information_schema.columns
where table_schema = 'Practice' and
table_name = 'Employees'
INTERSECT
select column_name from information_schema.columns
where table_schema = 'Practice' and
table_name = 'department';


# What are the column present in both the table


select column_name from information_schema.columns
where table_schema = 'Practice' and
table_name = 'Employees'
union
select column_name from information_schema.columns
where table_schema = 'Practice' and
table_name = 'department';



# --------------------------------------  INNER JOIN  -------------------------------------------------------------

select * from employees;
select * from department;

select * from employees
join department 
using (department_id);

alter table department change column department_id dept_id varchar(30);
select * from department;

select e.employee_id, concat(e.first_name, ' ',e.last_name) `employee name`,e.job_id, e.salary,d.department_name 
from employees E inner join department D on e.department_id = D.dept_id;


# ----------------------------------------- LEFT OUTER JOIN  --------------------------------------------------


select e.employee_id, concat(e.first_name, ' ',e.last_name) `employee name`,e.job_id, e.salary,d.department_name 
from employees E left outer join department D on e.department_id = d.dept_id;



select e.employee_id, concat(e.first_name, ' ',e.last_name) `employee name`,e.job_id, e.salary,d.department_name 
from employees E left join department D on e.department_id = d.dept_id;


# --------------------------------------- RIGHT OUTER JOIN  ----------------------------------------------------

select e.employee_id, concat(e.first_name, ' ',e.last_name) `employee name`,e.job_id, e.salary,d.department_name 
from employees E right outer join department d on e.department_id = d.dept_id;



select * From employees E right join department d on e.department_id = d.dept_id;


# --------------------------------------- FULL OUTER JOIN  ------------------------------------------------------------

select * from employees e left join department d on e.department_id = d.dept_id
union
select * from employees e right join department d on e.department_id = d.dept_id;



# --------------------------------------- SELF JOIN  -------------------------------------------------------------------


select a.employee_id,concat(a.first_name,' ',a.last_name) `Employee name`,concat(b.first_name,' ',b.last_name) `Manager name`,
b.employee_id manager_id
from employees A join employees b on a.manager_id = b.employee_id;



select a.employee_id,concat(a.first_name,' ',a.last_name) `Employee name`,concat(b.first_name,' ',b.last_name) `Manager name`,
b.employee_id manager_id
from employees A join employees b on a.manager_id = b.employee_id
order by manager_id;



# -------------------------------------------------- CROSS JOIN -----------------------------------------------------

select * from employees cross join department;


# -------------------------------------- CONSTRAINTS ( Restrictions ) ---------------------------------------

# 1. NOT NULL Constraint 
 
 create table nn(emp_id int unsigned not null,job_name varchar(30),phone int);
 
 insert into nn values (1,'developer',234234324),
 (2,'admin',3424244);
 insert into nn values (3,"Digital marketer",null);
 
 delete from nn where emp_id = 3;
 select * from nn;
 alter table nn modify column phone int not null;
 insert into nn (job_name) value('Finance');
 
 
 
 # 2. UNIQUE Constraint
 
 
 
 create table uu (e_id int not null,ename varchar(20),pancard varchar(20) unique);
 select * from uu;
 
 insert into  uu values (1,'sohel','234fgh'),
 (2,'Rabi','32hjk');
  insert into uu values (2,'rabi','78hjk');
  
  
  delete from uu where e_id =2;    # delete the row------------
  
  
  select column_name,constraint_name
  from information_schema.key_column_usage
  where  table_name='uu';
  
  alter table uu modify column e_id int unsigned not null unique;
  
  alter table uu add constraint u_id  unique (e_id);
  
  alter table uu add constraint u_id unique (ename);
  
  alter table uu add unique (e_id);
  
alter table uu drop constraint e_id;

select * from uu;



# 3. CHECK Constraint


create table cc (emp_id int unsigned not null unique,salary decimal(15,2), age int unsigned check (age>= 18));

select * from cc;

insert into cc values (1,3242,18);

alter table cc add constraint ch_age check (age>=18);

select table_name,constraint_type,constraint_name
from information_schema.table_constraints
where table_name = 'cc';

alter table cc drop constraint cc_chk_1;

alter table cc drop constraint ch_age;

alter table cc add constraint ch_age check(age >=18),
add constraint ch_e_id check (emp_id>100);

insert into cc values (100,3242,19);

insert into cc values (101,3242,19);

truncate cc;

select * from cc;

select table_name,constraint_type,constraint_name
from information_schema.table_constraints
where table_name = 'cc';

select column_name, constraint_name
from information_schema.key_column_usage
where table_name = 'cc';

alter table cc drop constraint emp_id;

alter table cc add constraint u_id unique (emp_id);


# Primary Key & Foreign key Constraints      ------------------------------------------------------------------

create table emp1(emp_id int unsigned,job_id varchar(30),dept_id int unsigned);

insert into emp1 values (1,'as123',50),(2,'sd234',70);
create table dept1(dept_id int unsigned, dept_name varchar(30));
insert into dept1 values(70,'ai'),(60,'mgr');

truncate dept1;
truncate emp1;

# after insert value into table we cann't assigned foreign key constraint in table.

alter table emp1 add constraint pk_id primary key(emp_id,job_id);

alter table emp1 add constraint fk_dept foreign key (dept_id) references dept1(dept_id);
# we can give foreign key name but we cann't give primary key name by our choice

alter table dept1 add primary key(dept_id);

select column_name,constraint_name
from information_schema.key_column_usage
where table_name='dept1';


select column_name,constraint_name from information_schema.key_column_usage
where table_name = 'emp1';

select table_name,constraint_type,constraint_name
from information_schema.table_constraints
where table_name='cc';

# add primary key and foreign key while creating table and generater relation between tables.alter

create table emp2(emp_id int unsigned,job_id varchar(30),dept_id int unsigned,
primary key(emp_id,job_id),foreign key(dept_id) references dept2(dept_id));

/* if we didn't give any foreign key name then it store default name which is
"that table name_ibfk_number of key we created in a table
example : inplace of table name now it take "EMP2" and inplace of number of  key it take 1 
because we create only 1 foreign key, so the default foreign key name
"emp2_ibfk_1" */


create table dept2(dept_id int unsigned,dept_name varchar(30),
primary key(dept_id));

/* for create relation between two table at first we have create parent table then create child table
then only we create relation between two table 

If we create child table first is give us error*/

select column_name,constraint_name
from information_schema.key_column_usage
where table_name = 'dept2';


alter table emp2 add constraint fk_did foreign key(dept_id) references dept2(dept_id);
alter table emp2 drop foreign key emp2_ibfk_1;


select column_name,constraint_name
from information_schema.key_column_usage
where table_name ='emp2';

# this query give you an Idea which tabe will be the parent table

select column_name,constraint_name,referenced_table_name,referenced_column_name
from information_schema.key_column_usage
where table_name='emp2';

select * from emp2;
insert into emp2 values (1,'as123',50),(2,'sd234',70);

/* If we try to insert value in child table first then it returns below error responce  
Error Code: 1452. Cannot add or update a child row: 
a foreign key constraint fails 
(`practice`.`emp2`, CONSTRAINT `fk_did` FOREIGN KEY (`dept_id`) REFERENCES `dept2` (`dept_id`)) */

/* we cann't insert value in child table with out inserting value in parent table
So, first we have to insert values in parent table */

select * from dept2;
insert into dept2 values(70,'ai'),(60,'mgr');

insert into emp2 values(1,'ai',70),(2,'mgr',60),(3,'It',70);


select * from emp2;
insert into emp2 values (1,'as123',50),(2,'sd234',70);

/* we cann't insert different value in chils table
we must have insert value which is equal to the parent table values */

/* How to update and delete values from both table simulteniously
If we made any changes in any table, same changes happen on other table 
for this we use 3 key word such as:
1 - On delete set null 
2 - on delete cascade
3 - on update cascade

Out of first tow key word we use only one key word while we assign in the table */
 select table_name,column_name,referenced_table_name,referenced_column_name
 from information_schema.key_column_usage where referenced_table_name is not null and table_schema = 'Practice';
 
 select column_name, constraint_name from information_schema.key_column_usage 
 where table_schema = 'practice' and table_name= 'emp2';
 select table_name,constraint_type,constraint_name
 from information_schema.table_constraints where table_schema = 'practice' and table_name is not null;


show tables;


select table_name,column_name,referenced_table_name,referenced_column_name
from information_schema.key_column_usage
where referenced_table_name is not null and table_schema='Practice';

/* How to add on delete cascade in an existing table?

first we have to drop the foreign key constraint then only we assign on delete cascade */
select * from dept2; 
select * from emp2; 

select column_name,table_name,constraint_name
from information_schema.key_column_usage
where table_name ='emp2' and table_schema= 'practice' ;

alter table emp2 drop constraint fk_did;

alter table emp2 add constraint fk_did foreign key (dept_id) references dept2 (dept_id) on delete cascade;

alter table dept2 drop  primary key;

alter table dept2 add constraint primary key (dept_id,dept_name);

delete from dept2 where dept_id = 70 or dept_id = 90 or dept_id = 20;

select * from dept2;
select * from emp2;

alter table emp2 add constraint fk_did foreign key (dept_id) references dept2 (dept_id)  on update cascade;


insert into dept2 values (70,'ai'),(90,'prog'),(20,'fns');

desc emp2;
alter table emp2 drop primary key;

alter table emp2 modify column emp_id int unsigned;
alter table emp2 modify column job_id varchar(40);


select * from dept2;
select * from emp2;

insert into emp2 values (1,'ai',70),(2,'prog',90),(3,'fns',20),(4,'fns',20),(5,'mgr',60),(6,'develpoer',70),(7,'mkt_intern',60);
create table emp2(emp_id int unsigned,job_id varchar(30),dept_id int unsigned);
alter table emp2 add constraint fk_id foreign key (dept_id) references dept2(dept_id) on update cascade;

select column_name,table_name,constraint_name
from information_schema.key_column_usage
where table_schema ='practice' and table_name = 'emp2';
 alter table dept2 drop primary key;
 alter table dept2 add primary key (dept_id);
 
 alter table emp2 drop constraint fk_id;
 alter table dept2 add column slno int unique auto_increment first;
 
 select * from dept2;
 update  dept2 set dept_id = 10 where slno = 2;
select * from emp2;

/* ON update cascade when we update any value in primary key contain column which connect with child table.*/


## STORE PROCEDURE -------------------------------------------------------------------------------------------------------------------
 create table customer (slno int unique auto_increment,id int unsigned,amount int unsigned);
 select * from customer;
 
 DELIMITER //
create procedure input(in enter_id int, in enter_amount int)
begin
insert into customer (id, amount) values (enter_id, enter_amount);
end //
DELIMITER ;
 drop procedure input;
 call input(30,4000);
 
 select * from customer;

DELIMITER //
create procedure new_table(in t_name varchar(30),in column_1 varchar(30), in column1_type varchar(100),
in column_2 varchar(40),in column2_type varchar(100))
begin
declare p_name varchar(30);
set @p_name = concat('create table ', t_name, ' (', column_1, ' ', column1_type, ', ', column_2, ' ', column2_type, ')');
prepare p_table from @p_name;
execute p_table;
deallocate prepare p_table;
end //
DELIMITER ;

/* we should include spaces between the SQL keywords and the table name and column 
definition to ensure the SQL statement is formatted correctly */



drop table product;

select * from product;
desc product;
drop procedure new_table;


##  Data Partioning -------------------------------------------------------------------------------------------------------------------


/* It splits the row of the table into a separate table
There are tree type:
	1 . Range partitioning
    2 . list partitioning
    3 . Hash partitioning */
    
    
-- Range Partiotioning----------------------

-- This partition only applicable for numeric column

create table d1( emp_id int unsigned,name varchar(30),age int unsigned)
partition by range (age) (
		partition P0 values less than (20),
		partition P1 values less than (30), 
		partition P2 values less than (40));
        
Insert into d1 values 
(1,'sumit',10),
(2,'sumit',15),
(3,'sumit',25),
(4,'sumit',21),
(5,'sumit',35),
(6,'sumit',39),
(7,'sumit',30);

select * from d1;

-- show the table based on partition

select * from d1 partition (P0);

insert into d1 values (8,'sumit',20);

insert into d1 values (1,'sumit',40);

-- 01:02:22	insert into d1 values (1,'sumit',40)	Error Code: 1526. Table has no partition for value 40

/* We cann't insert value more then highest partition value
heare higher partition value is less than 40 so that we cann't enter value which is more than equal to 40 */

-- Prevant those type of senario create partion in such a manner where partion value automatical take highest values from that column

alter table d1 add partition ( partition P3 values less than maxvalue);

select * from information_schema.partitions 
where table_schema = 'practice' and table_name = 'd1' and partition_name is not null;

alter table d1 reorganize partition P2 into (partition P2 values less than (50));
alter table d1 drop partition p3;

insert into d1 values (10,'sohel',90);

select * from d1;

select * from d1 partition(p1);
delete from d1 where emp_id = 10;
delete from d1 partition (p3) where emp_id = 10;

select * from information_schema.partitions
where table_schema = 'practice' and table_name = 'd1' and partition_name is not null;


-- List Partition -----------

create table d2 ( id int unsigned, city varchar(50))
				partition by list columns (city)
                (partition p0 values in ('Delhi','Mumbai','Kolkata','Chenai'),
                partition p1 values in ('Bengaluru','Gujrat','Hyderabad'));
                
insert into d2 values (1,'Delhi'),(2,'Gujrat'),(3,'Chenai'),(4,'Hyderabad'),(5,'Mumbai');
select * from d2;
select * from d2 partition (p3);

select * from information_schema.partitions 
where table_schema = 'practice' and table_name = 'd2' and partition_name is not null;

select partition_expression,partition_name,table_rows from information_schema.partitions
where table_schema = 'practice' and table_name = 'd2';

alter table d2 add partition  (partition p3 values in('cuttack','Bhubaneswer','Sambalpur'));


alter table d2 reorganize partition p3 into (partition p3 values in ('cuttack','Bhubaneswer','Sambalpur','up','Mp'));

insert into d2 values (5,'up'),(6,'cuttack'),(7,'Sambalpur'),(8,'Mp');


-- HASH  Partitioning ------------------------------------------------------

/* IN hash partitioning we assign how many partition we want but we cann't give name by own and 
cann't assign values in partition 
* It assign values in partition as pe moduls concept.
* Hash partition applicable for only numerical column. */

create table d3 (Id int unsigned , name varchar(30) , age int unsigned)
				partition by hash (age)
                partitions 5;
                
insert into d3 values (1,'Sohel',23),(2,'Sohel',15),(3,'Sohel',27),(4,'Sohel',67),(5,'Sohel',42),(6,'Sohel',32);
 -- Partition syntax:
 
select * from information_schema.partitions
where table_schema = 'practice' and table_name = 'd3' and partition_name is not null;

insert into d3 values (7,'sohel', 21),(8,'sohel',36);

select * from d3 partition(p2);

/* By using partition syntax we know the partition name which system create.
All we know hash partition store values as per moduls concept.
*system give default partition name i.e (p0,p1,p2,p3-------)

How to store values in partition
each value / created total partition (example 21 is a value and total partion is 5)

* for p0 it store those values whoes remainder is zero(0)
* for p1 it store those values whoes remainder is 1
* for p2 it store those values whoes remainder is 3
likewise it store values in partitions. */


## Trigger ----------------------------------------------------------------------------------------------------------------------------

/* Trigger can be executed when you run one of the following MySQL statement on the table such as
Insert, Update, and delete it can invoked before or after the event */


-- Before  insert Triggeers

create table orders(ID int unsigned, age int unsigned);

DELIMITER //
create trigger bfr_insert
before insert on orders for each row
begin
if new.age < 18 then set new.age = 0;
elseif new.age is null then set new.age = 1;
elseif new.id = 0 then set new.id = 1;
end if;
end //
DELIMITER ; 

insert into orders values (1,16),(null , 18), (2,19);
insert into orders(age) values (34),(18);
insert into orders values (0,34),(0,17);

select * from orders;


-- After Insert Trigger ----------------

create table t1(ID int unsigned,name varchar(30),age int unsigned);
create table t1_rcv(slno int primary key auto_increment,ID int unsigned,name varchar(30),age int unsigned,message text);

DELIMITER //
create trigger after_insert
after insert on t1 for each row
begin
	if new.age < 18 then 
    insert into t1_rcv(ID,age,message)values (new.id,new.age,concat('Please',new.name,'insert age grater then 18'));
    end if;
end //
DELIMITER ;

drop trigger after_insert;

DELIMITER $$
Create trigger before_insert
before insert on t1 for each row
begin
	if new.age < 18 then set new.age = 0;
    end if;
end $$
DELIMITER ;

insert into t1 values(1,'sohel',16),(2,'arif',30),(3,'jk',17),(4,'kumar',18);

show triggers;
desc t1;
truncate t1;
truncate t1_rcv;
select * from t1;	
select * from t1_rcv;


-- Before Update trigger ---------------------------------------

Create table t2 (ID int unsigned,name varchar(30),salary int unsigned);

DELIMITER //
create trigger before_update
before update on t2 for each row
begin
	if new.salary < old.salary then set new.salary = old.salary;
    elseif new.salary > old.salary then set new.salary = new.salary;
    end if;
end //
DELIMITER ;

insert into t2 values (1,'sohel',50000),(2,'raju',70000),(3,'srk',90000),(4,'sohail',60000);
update t2 set salary =49999 where id = 1;
update t2 set salary = 100000 where id = 3;
select * from t2;


-- After update trigger --------------------------------------

create table t2_rcv (slno int unsigned unique auto_increment,ID int unsigned,salary int unsigned,update_time  timestamp default now(),
					message text);

DELIMITER //
create trigger after_update
after update on t2 for each row
begin
	if new.salary != old.salary then 
    insert into t2_rcv (id,salary,message) values(old.id,old.salary,concat(old.name,' salary is updated '));
    end if;
end //
DELIMITER ;
 drop trigger after_update;
update t2 set salary = 60000 where id = 1;
select * from t2;
select * from t2_rcv;
truncate t2_rcv;


-- delete trigger ------------------------------

create table del(slno int unique auto_increment, ID int unsigned, name varchar(30),
				salary int unsigned, delete_time timestamp default now());
                
                
DELIMITER //
create trigger del_value
before delete on t2 for each row
begin
	insert into del(ID,name,salary) values (old.id,old.name,old.salary);
end //
DELIMITER ;

drop trigger del_value;

select * from t2;
insert into t2 values (5,'cater',56000),(6,'Suzuka',77000);

select * from del;
delete from t2 where id = 6 or id = 5;