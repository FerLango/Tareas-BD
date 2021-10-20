--1. Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?
select c.first_name, c.last_name, c.email, c3.country 
from customer c 
	join address a using (address_id)
	join city c2 using (city_id)
	join country c3 using (country_id) 
where c3.country = 'Canada'

--2. Qué cliente ha rentado más de nuestra sección de adultos?
select c.first_name, c.last_name, count(*) as cantidad
from customer c 
	join rental r using (customer_id)
	join inventory i using (inventory_id)
	join film f using (film_id)
where f.rating = 'NC-17'
group by c.first_name, c.last_name 
order by cantidad desc
limit 2;

--3. Qué películas son las más rentadas en todas nuestras stores?
select f.title, count(*) as cantidad --, s.store_id
from film f 
	join inventory i using (film_id)
	join rental r using (inventory_id)
	join store s using (store_id)
group by f.film_id --, s.store_id 
order by cantidad desc
limit 1;

--4. Cuál es nuestro revenue por store?
select s.store_id, sum(p.amount)
from store s 
	join inventory i using (store_id)
	join rental r using (inventory_id)
	join payment p using (customer_id)
group by s.store_id 
order by s.store_id;
	
	





