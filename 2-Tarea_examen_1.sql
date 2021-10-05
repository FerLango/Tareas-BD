--Obtener un reporte de edades de los empleados para checar su elegibilidad para seguro de gastos médicos menores.
select e.first_name, e.last_name, age(now(), e.birth_date) 
from employees e; 

--Cuál es la orden más reciente por cliente?
select c.company_name, c.contact_name ,o.order_date 
from orders o 
	join customers c using (customer_id)
order by o.order_date desc;

--De nuestros clientes, qué función desempeñan y cuántos son?
select c.contact_title, count(c.contact_title) 
from customers c 
group by c.contact_title;

--Cuántos productos tenemos de cada categoría?
select c.category_name, count(c.category_name) 
from products p 
	join categories c using (category_id)
group by c.category_name; 

--Cómo podemos generar el reporte de reorder? (de los que ya están debajo del nivel)
select p.product_id, p.product_name, p.units_in_stock, p.reorder_level 
from products p 
where p.units_in_stock <= p.reorder_level; 

--A donde va nuestro envío más voluminoso?
select o.ship_city, o.ship_country ,o.freight 
from orders o 
where o.freight = (select max(o2.freight) from orders o2); 
 
select o.ship_city, o.ship_country ,o.freight 
from orders o 
order by o.freight desc limit 1;

--Cómo creamos una columna en customers que nos diga si un cliente es bueno, regular, o malo?
select c.company_name, /*od.unit_price, od.quantity, od.discount,*/ 
	sum(od.unit_price*od.quantity*(1-od.discount)) as total  
from customers c 
	join orders o using (customer_id)
	join order_details od using (order_id)
group by c.company_name
order by total;

--create view nombre as
select t.company_name, t.total,
	case 
		when t.total < 10000 then 'malo'
		when t.total >= 10000 and t.total <100000 then 'regular'
		else 'bueno'
	end as categoria
from (
	select c.company_name, /*od.unit_price, od.quantity, od.discount,*/ 
		sum(od.unit_price*od.quantity*(1-od.discount)) as total  
	from customers c 
		join orders o using (customer_id)
		join order_details od using (order_id)
	group by c.company_name
	order by total
) as t;

--Qué colaboradores chambearon durante las fiestas de navidad?
select e.first_name, e.last_name, o.order_date, extract(month from o.order_date) as mes, extract(day from o.order_date) as dia
from employees e 
	join orders o using (employee_id)

select distinct e.first_name, e.last_name
from employees e 
	join orders o using (employee_id)
where extract(month from o.order_date) = 12 
	and extract(day from o.order_date) in (24,25)

--Qué productos mandamos en navidad?
select p.product_name 
from orders o 
	join order_details od using (order_id)
	join products p using (product_id)
where extract(month from o.order_date) = 12 
	and extract(day from o.order_date) in (24,25)
	
--Qué país recibe el mayor volumen de producto?
select o.ship_country, sum(o.freight) as volumen
from orders o 
group by o.ship_country 
order by volumen desc 
limit 1;
























