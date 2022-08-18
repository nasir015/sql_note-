USE store;
# orderby diye sort kora hoy kono akta column er vittite 
SELECT * FROM customers 
-- where customer_id = 2
order by customer_id;
# extract any column from table 
select customer_id , first_name, last_name from customers;

# remove duplicate value from column 
select distinct state from customers;

# arithmetic operation in any column 
select customer_id , points, (points + 100) *100 as bonas from customers;

# where use kore filtaring
select customer_id,points from customers  where points >1000;
select customer_id,state from customers  where state = 'VA';
select * from orders where order_date >= '2018-01-01';

# and or and not operator 
select * from customers where birth_date >= '1990-01-01' and points >1000;
select * from customers where birth_date >= '1990-01-01' or points >3000;
select * from customers where not (birth_date >= '1990-01-01' or points >3000);


# quize 3
 select * from order_items where order_id = 2;
SELECT *,(quantity*unit_price) as total_price  FROM order_items where (quantity*unit_price) >30  ;


# in operator 
select * 
from customers 
where state = "VA" or state ="GA" or state = "FL" ;

select * 
from customers 
where state IN ('VA','GA','FL');

select * 
from customers 
where state NOT IN ('VA','GA','FL');

# quize 4

SELECT * FROM store.products where quantity_in_stock IN (49,38,72);

#between 
select * 
from store.customers
where points >=1000 and points <=3000;


select * 
from store.customers
where points between 1000 and 3000;

#practice 
select * 
from store.customers
where birth_date between '1990-01-01' and '2000-01-01';

# like operator jar maddome amra information ber korbo kono kichur vitte. 
select *
from store.customers
where last_name like 'B%';

#same kahini :)
select *
from store.customers
where last_name like 'B____y';

#practice 

select *
from store.customers
where (address like '%Trail%'or  address like '%Avenue%') or phone like '%9';


# regexp 


#operator simple sorting symboll 
#there are some criteria such as 
#1 ^ use this symboll for find begganing string 
#2 | use for using or 
#3 $ last name ends with ray 
#4 [gim]e thats means wordee e thakbe kintu er age gim er jekono word thakbe ;

select *
from store.customers
where last_name regexp '[avg]e';


select *
from store.customers
where last_name regexp 'e[avg]';

select *
from store.customers
where last_name regexp 'e[a-z]';

select *
from store.customers
where last_name regexp 'D$';

select *
from store.customers
where last_name regexp '^b';

select *
from store.customers
where last_name regexp '^b|$d';

#practice 
select *
from store.customers
where last_name regexp ('^my|se');

select *
from store.customers
where last_name regexp ('b[ru]');

select *
from store.customers
where first_name regexp ('elka|ambur');

select *
from store.customers
where last_name regexp ('ey$|on$');

# Null find out if any null value exitst in any column
select *
from store.customers
where phone is null;

select *
from store.customers
where phone is not null;

# practice 
SELECT shipper_id, count(shipper_id is null)  FROM store.orders
order by shipper_id;

#order by clause 
select *
from store.customers
order by last_name;

select *
from store.customers
order by last_name desc;

#practice 
select *,(unit_price*quantity) as total_price
from store.order_items
where order_id = 2
order by total_price desc;

#  limit operator 

select *
from store.customers
limit 4;

-- specify last 3 digit or middel use following system
select *
from store.customers
limit 7,3;

-- practice 
select * 
from customers
order by points desc
limit 3;

-- inner join section 
select *
from customers c
join orders o on o.customer_id = c.customer_id
order by c.customer_id;

-- join database from multiple databases

use store;
select * 
from store.order_items oi
join sql_inventory.products p on oi.product_id = p.product_id ;

-- self join

use sql_hr;
select m.first_name as manager_name , m.employee_id ,e.first_name as employee_first_name, e.last_name as employee_last_name ,e.employee_id 
from employees e 
join employees m on e.reports_to = m.employee_id;

-- join data from multiple table 
use store;
select o.order_id, c.first_name,c.last_name, o.order_date, os.name as delivary_status
from orders o 
join customers c on o.customer_id = c.customer_id
join order_statuses os on o.status= os.order_status_id;

# practice
use invoicing;

select c.client_id, c.name , p.date as payment_date, pm.name as payment_method
from invoicing.clients c
join invoicing.payments p on c.client_id = p.client_id
join invoicing.payment_methods  pm on p.payment_method = pm.payment_method_id ;


-- OUTER JOIN  two type right and left  right as well as thakbe kintu left e vinno jara order korche and jara order kore nai tarao add thakbe.
select c.customer_id,
	   c.first_name,
       c.last_name,
       o.order_id
FROM store.customers c
left JOIN store.orders o
     ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- outer join to combine multiple table 

select c.customer_id,
	   c.first_name,
       c.last_name,
       o.order_id,
       sh.name
FROM store.customers c
left JOIN store.orders o
     ON c.customer_id = o.customer_id
LEFT JOIN store.shippers sh
     ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;

-- practice 

select o.order_id,
       o.order_date,
       c.first_name as customer,
       sh.name as shipper_name,
       os.name as ststus_of_orders
FROM store.customers c
JOIN store.orders o
     ON c.customer_id = o.customer_id
LEFT JOIN store.shippers sh
     ON o.shipper_id = sh.shipper_id
LEFT join store.order_statuses os
     ON o.status = os.order_status_id;

-- using keyword 

select o.order_id,
       o.order_date,
       c.first_name as customer,
       sh.name as shipper_name,
       os.name as ststus_of_orders
FROM store.customers c
JOIN store.orders o
     using (customer_id)
LEFT JOIN store.shippers sh
     using(shipper_id)
LEFT join store.order_statuses os
     using(order_status_id);

use invoicing;

select *
from payments p
join clients c
	using (client_id)
join payment_methods pm
	using (payment_method_id);

-- natural join domt apply bcz its messed up all result user has no control 

select *
from payments p
natural join clients c;

-- cross join 
use store;
select c.first_name,
       c.points
from customers c
cross join products p 
order by c.first_name;

-- union  its use to show active and inactive any column 
-- combine record single table 
use store;
select 
	 order_id,
     order_date,
     'Active' as status
from orders
where order_date >= '2018-01-01'
union 
select 
	 order_id,
     order_date,
     'Archived' as status
from orders
where order_date < '2018-01-01';

-- combine multiple table 

select first_name
from customers
union
select name
from shippers;

-- practice 
select customer_id,
	   first_name,
	   last_name,
       points,
	  'Bronze' as Type
from store.customers
where  points <2000   
union 
select customer_id,
	   first_name,
	   last_name,
       points,
	  'GOLD' as Type
from store.customers
where  points >=2000 ;

-- insert a row 

insert into customers(customer_id,first_name,last_name, birth_date, phone, address, city, state, points)
values (default,'Nasir','Uddin','2000-06-30',01710631462,'kachua chandpur','chandpur','am',2000);

-- insert multiple row 
insert into shippers (name)
value ('shipper 1'), ('shipper 2'),( 'shipper 3');

-- creating a copy of the table 
create table orders_befor_2018 as 
select * from orders
where order_date < '2018-01-01';

-- updating a single row 
update orders
set order_date = '2019-08-02'
where customer_id = 2;

use invoicing;
update invoices
set payment_total = '0', payment_date = null
where invoice_id = 1;

use store;
update orders
set order_date = '2018-11-18'
where customer_id = 6;

-- updating multiple rows 

use invoicing;
update invoices
set payment_total = '100', payment_date = '1920-01-01'
where client_id =  

				(select client_id
				from clients
				where name= 'Myworks');


update invoices
set payment_total = '100', payment_date = '1920-01-01'
where client_id IN 	 

				(select client_id
				from clients
				where state in ( 'CA','NY'));

#practice 

update orders
set comments = 'gold customer'
where customer_id in
				(select customer_id
				from customers
				where points >3000);


-- Deleting a row 
use invoicing ;
delete from invoices
where invoice_id = 

			(select *
			from clients 
			where name = 'Myworks');


-- aggregate function  
-- max
-- min
-- avg
-- sum
-- count
use invoicing;
select 
	   max(invoice_total)
from invoices;
select 
	   max(invoice_total*4)
from invoices;

-- group by function 
select
	sum(invoice_total) as total ,
    client_id
from invoices
where invoice_date >='2019-07-01'
group by client_id
order by total desc;


select
	client_id,
    city,
    state,
    sum(invoice_total) as total 
from invoices
join clients using (client_id)
group by state, city
order by total desc;

-- having clause 

select
	sum(invoice_total) as total ,
    client_id,
    count(*) as numbers_of_invoices
from invoices
group by client_id
having total>500 and numbers_of_invoices >5;

-- the roll up operator find total of column 

select
	sum(invoice_total) as total ,
    client_id
from invoices
group by client_id with rollup;

select
	state,
    city,
    sum(invoice_total) as total 
    
from invoices
join clients as c using (client_id)
group by state,city with rollup;

-- writing a subquary 
use store;
select *
from products
where  unit_price > (
              select unit_price
              from products
              where product_id = 3
);

-- The in operator
use store;
select *
from products
where product_id not in (select distinct order_id 
from order_items);


-- The all operator
-- select inviuces that are larger than all the invoices of client 3
use invoicing;

select *
from invoicing.invoices
where invoice_total> (

SELECT max(invoice_total)
from invoicing.invoices
where client_id = 3);


select *
from invoicing.invoices
where invoice_total> all(

SELECT max(invoice_total)
from invoicing.invoices
where client_id = 3);


-- The any operator 
-- select client with atleast two invoices

select *
from clients
where client_id in (
select distinct client_id 
from invoicing.invoices
where invoice_id > 2);

select *
from clients
where client_id = ANY (
select distinct client_id 
from invoicing.invoices
where invoice_id > 2);

-- CORRELATED SUBQUERIES
USE	sql_hr;

select *
from sql_hr.employees
where salary<(select avg(salary)
from sql_hr.employees)
order by salary desc;

-- subqueries inside select 
use invoicing;
select 
	invoice_id,
    invoice_total,
    (select avg(invoice_total) from invoices) as average ,
    invoice_total - (select average) as diffrence
    from invoices;


-- subqueries inside from
select *
from (
select 
	invoice_id,
    invoice_total,
    (select avg(invoice_total) from invoices) as average ,
    invoice_total - (select average) as diffrence
    from invoices) as tab
where diffrence >0;


-- numeric function

-- round the number 
select round(3.45);

select round (3.455555 , 1);
-- truncate function 
select truncate(3.4586 , 2);

-- cilling function return smallest nearest value 
select ceiling(4.3);

-- floor 
select floor(4.5) ;

-- abs
select abs(-45);

-- rand function 
select rand() ;



-- string function 

-- length function 
select length('nasir uddin');

-- upper function 
select upper('nasir uddin ');

-- lower function
select lower('Nasir Uddin');

-- Trim
select trim('  nasir  ');
-- rtrim
select rtrim('   nasir  ');
-- ltrim
select length(ltrim('   nasir')) ;

-- left 
select left('Nasir Uddin ', 5);

-- right 
select right('Nasir Uddin',3);

-- substring function 
select substring('Nasir Uddin',7,11);

-- locate 
select locate('U','Nasir Uddin');

-- replace
select replace('Nasir Uddin', 'Uddin ','pinto');

-- concate function 
use store;
select concat(first_name,' ',last_name)as name
from customers;


-- date formating 

select '2019-01-01';

-- now 
select now();

-- curdate 
select curdate();

-- curtime
select curtime();

-- year from now function 

select month (now()),year (now()),day (now()),minute(now()) ,second(now()),hour(now()),dayname (now()),monthname(now()),extract(year from now());

-- date time formating

-- date formating
select date_format(now(), '%d %m %Y');

-- time formating
select time_format(now(), '%h:%i') as time;


-- operation with Date and time function 

-- add day
select date_add(now(), interval 1 day);

-- add month
select date_add(now(), interval 1 month);

-- add year 
select date_add(now(), interval 1 year);

-- substruct year 
select date_add(now(), interval -1 year);

-- date dif
select datediff(curdate(),'2000-10-06' );

-- dif time 
select time_to_sec("2:00")-time_to_sec("1:00");

-- IFNULL & COALESCE

use store;

-- find null and replace 
select 
	order_id,
    ifnull(shipper_id, 'not assign')
from orders;


select 
	order_id,
    coalesce(shipper_id,comments, 'not assign')
from orders;



