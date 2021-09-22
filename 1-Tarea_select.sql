/*Qué contactos de proveedores tienen la posición de sales representative?*/
select s.contact_name 
from suppliers s 
where s.contact_title = 'Sales Representative';

/*Qué contactos de proveedores no son marketing managers?*/
select s.contact_name, s.contact_title 
from suppliers s 
where s.contact_title != 'Marketing Manager';

/*Cuales órdenes no vienen de clientes en Estados Unidos?*/
select count(*)
from orders o 
where o.ship_country != 'USA';

select count(*)
from orders o 
join customers c using (customer_id)
where c.country !='USA';

/*Qué productos de los que transportamos son quesos?*/
select p.product_name 
from products p 
where p.category_id = 4;

select p.product_name 
from products p 
where p.category_id = (
				select c.category_id
				from categories c
				where c.description='Cheeses');
			
select distinct od.product_id, p.product_name, c.category_id 
from order_details od join products p using (product_id)
join categories c using (category_id)
where c.category_name = 'Dairy Products';

/*Qué ordenes van a Bélgica o Francia?*/
select o.order_id, o.ship_country 
from orders o 
where o.ship_country = 'France' or o.ship_country = 'Belgium';

/*Qué órdenes van a LATAM?*/
select distinct o.ship_country 
from orders o; 

select o.order_id, o.ship_country 
from orders o 
where o.ship_country in ('Argentina', 'Venezuela', 'Mexico','Brazil');

/*Qué órdenes no van a LATAM?*/
select o.order_id, o.ship_country 
from orders o 
where o.ship_country not in ('Argentina', 'Venezuela', 'Mexico','Brazil');

/*Necesitamos los nombres completos de los empleados, nombres y apellidos unidos en un mismo registro*/
select concat(e.first_name,' ' ,e.last_name) as name
from employees e;

/*Cuánta lana tenemos en inventario?*/
select sum(unit_price*units_in_stock)::float8::numeric::money as money
from products p;

/*Cuantos clientes tenemos de cada país?*/
select count(c.customer_id), c.country 
from customers c 
group by c.country;



