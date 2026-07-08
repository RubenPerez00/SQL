-- Ejercicio 2 Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select f.title  as Nombre_pelicula, f.rating as clasificacion
from film f 
where f.rating = 'R';

--Ejercicio 3 Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select a.actor_id , concat(a.first_name , ' ', a.last_name ) as Nombre_completo_actor
from actor a 
order by a.actor_id 
limit 11 offset 29 ;

--Ejercicio 4 Obtén las películas cuyo idioma coincide con el idioma original.
select f.title as titulo
from film f 
where f.language_id  = f.original_language_id ;

--Ejercicio 5 Ordena las películas por duración de forma ascendente.
select f.title as titulo  , f.length  as duracion
from film f 
order by f.length  ;

--Ejercicio 6 Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select concat(a.first_name , ' ', a.last_name ) as Nombre_completo_actor
from actor a 
where a.last_name  like '%ALLEN%' ; 

--Ejercicio 7  Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select count(f.title ) as total_peliculas , RATING as clasificacion
from film f 
group by f.rating ;

--Ejercicio 8 Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select f.title , f.rating as clasificacion , f.length  as duracion
from film f 
where f.rating  = 'PG-13'
or f.length  > 180 ;

--Ejercicio 9 Encuentra la variabilidad de lo que costaría reemplazar las películas.
select variance(f.replacement_cost ) as variabilidad_coste
from film f ;

--Ejercicio 10  Encuentra la mayor y menor duración de una película de nuestra BBDD.
select  MIN(f.length  ) as duracion_minima , MAX(f.length  ) as duracion_maxima
from film f ;

--Ejercicio 11  Encuentra lo que costó el antepenúltimo alquiler ordenado por día
select p.payment_date as dia_pago , p.amount as coste
from payment p 
order by p.payment_date desc 
limit 1 offset 2 ;


--Ejercicio 12 Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.
select f.title, f.rating as clasificacion
from film f 
where f.rating not in  ('NC-17' , 'G') ;


--Ejercicio 13 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select f.rating as clasificacion, AVG(f.length  ) as duracion_media
from film f 
group by f.rating ;


--Ejercicio 14 Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos
select f.title as titulo, f.length  as duracion
from film f 
where f.length  > 180 ;


--Ejercicio 15  ¿Cuánto dinero ha generado en total la empresa?
select SUM(p.amount )
from payment p ;


--Ejercicio 16 Muestra los 10 clientes con mayor valor de id.
select c.customer_id , concat(c.first_name ,  ' ', c.last_name ) as nombre_cliente
from customer c 
order by c.customer_id desc
limit 10 ;


--Ejercicio 17 Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select a.actor_id , concat(a.first_name , ' ', a.last_name ) as nombre_actor, f.title as pelicula
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f
on fa.film_id = f.film_id 
where f.title like '%EGG IGBY%' ;


--Ejercicio 18 Selecciona todos los nombres de las películas únicos.
select distinct f.title 
from film f ;


--Ejercicio 19 Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select f.title as pelicula, f.length  as duracion, c."name" as categoria_pelicula
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on c.category_id = fc.category_id 
where f.length  > 180 
and c."name" like 'Comedy' ;


--Ejercicio 20 Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c."name" as categoria, AVG(f.length ) as media_duracion
from film f 
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on c.category_id = fc.category_id 
group by c."name"  
having AVG(f.length  ) > 110 ;


--Ejercicio 21  ¿Cuál es la media de duración del alquiler de las películas?
select  AVG(r.return_date - r.rental_date) 
from rental r ;


--Ejercicio 22 Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(a.first_name , ' ', a.last_name ) as nombre_actores
from actor a ;


--Ejercicio 23  Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select r.rental_date :: date as fecha, count(r.rental_date ::date)
from rental r 
group by r.rental_date :: date
order by fecha desc ;


--Ejercicio 24 Encuentra las películas con una duración superior al promedio.
select f.title as pelicula, f.length as duracion
from film f 
where f.length > (
select AVG(f.length )
from film f ) ;


--Ejercicio 25 Averigua el número de alquileres registrados por mes.
select to_char(r.rental_date , 'MM-YYYY' ) as month_year, count(r.inventory_id )
from rental r 
group by  to_char(r.rental_date , 'MM-YYYY' )
order by month_year ; 


--Ejercicio 26  Encuentra el promedio, la desviación estándar y varianza del total pagado.
select SUM(p.amount ) as total, AVG(p.amount ) as promedio, stddev(p.amount ) as desviacion_estandar, variance(p.amount ) as varianza
from payment p ;


--Ejercicio 27 ¿Qué películas se alquilan por encima del precio medio?
select f.title as pelicula , f.rental_rate as precio_medio
from film f 
where f.rental_rate > (
select AVG(f2.rental_rate )
from film f2) ;

--Ejercicio 28 Muestra el id de los actores que hayan participado en más de 40 películas.
select a.actor_id ,  concat(a.first_name , ' ', a.last_name ) as actor, count(fa.film_id ) as total_peliculas
from actor a 
inner join film_actor fa 
on a.actor_id  = fa.actor_id 
group by a.actor_id 
having count(fa.film_id ) > 40 ;


--Ejercicio 29 Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible
select f.title as pelicula , count(f.title ) as disponibles
from film f 
left join inventory i 
on i.film_id = f.film_id
group by f.title ;


--Ejercicio 30 Obtener los actores y el número de películas en las que ha actuado.
select a.actor_id ,concat(a.first_name , ' ', a.last_name ) as nombre_actor, count(f.title ) as total_peliculas_rodadas
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id 
left join film f 
on fa.film_id = f.film_id
group by a.actor_id ;


--Ejercicio 31 Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select f.title as pelicula, concat(a.first_name , ' ', a.last_name ) as nombre_actor
from film f 
left join film_actor fa 
on f.film_id = fa.film_id
left join actor a 
on fa.actor_id = a.actor_id
order by nombre_actor ; 


--Ejercicio 32 Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select  concat(a.first_name , ' ', a.last_name ) as nombre_actor , f.title as pelicula
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id 
left  join film f 
on f.film_id = fa.film_id 
order by nombre_actor ; 



--Ejercicio 33 Obtener todas las películas que tenemos y todos los registros de alquiler
select f.title as pelicula, r.rental_id as id_alquiler
from film f 
left join inventory i 
on f.film_id = i.film_id
left join rental r 
on i.inventory_id = r.inventory_id ;


--Ejercicio 34 Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select concat(c.first_name , ' ', c.last_name ) as nombre_cliente , SUM(p.amount ) as total_gastado
from payment p 
inner join customer c 
on c.customer_id = p.customer_id 
group by nombre_cliente  
order by SUM(p.amount ) desc
limit 5 ;

--Ejercicio 35 Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select a.actor_id  ,a.first_name as nombre_actor , a.last_name as apellido_actor
from actor a  
where a.first_name like 'JOHNNY' ;

--Ejercicio 36 Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select a.first_name as nombre , a.last_name as apellido
from actor a ;

--Ejercicio 37 Encuentra el ID del actor más bajo y más alto en la tabla actor
select MIN(a.actor_id ) as id_minimo ,MAX(a.actor_id )  as id_maximo
from actor a ;

--Ejercicio 38 Cuenta cuántos actores hay en la tabla “actor”.
select count(a.actor_id ) as total_actores
from actor a ;

--Ejercicio 39 Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select *
from  actor a 
order by a.last_name ; 

--Ejercicio 40  Selecciona las primeras 5 películas de la tabla “film”.
select f.film_id , f.title as nombre_pelicula
from film f 
limit 5 ; 

--Ejercicio 41 Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select  count( a.first_name) as veces_reptido , a.first_name  as nombre
from actor a 
group by a.first_name 
order by veces_reptido desc ;

--Ejercicio 42 Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r.rental_id ,concat(c.first_name , ' ', c.last_name ) as nombre_cliente 
from rental r 
inner join customer c 
on r.customer_id = c.customer_id ;

--Ejercicio 43 Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres
select r.rental_id , concat(c.first_name , ' ', c.last_name ) as nombre_cliente
from customer c 
left join rental r 
on c.customer_id = r.customer_id
group by r.rental_id , nombre_cliente ;

--Ejercicio 44 Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f 
cross join  category c ;
--No nos aporta nada, ya que nos está sacando cada pelicula dentro de una catergoría, por ejemplo, la película ACADEMY DINOSAUR, se nos está generando con todos los disitintos tipos de categoría que hay... Una fila con comedia, otra con drama, otra fila con family. Por lo que para mi no tiene mucho sentido.

--Ejercicio 45 Encuentra los actores que han participado en películas de la categoría 'Action'
select concat(a.first_name , ' ', a.last_name ) as nombre_actor, f.title  as pelicula ,c.name as categoria_pelicula
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f 
on fa.film_id = f.film_id
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c.name = 'Action' ;

--Ejercicio 46 Encuentra todos los actores que no han participado en películas.
select *
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f 
on fa.film_id = f.film_id
where f.title is null ;

--Ejercicio 47 Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select concat(a.first_name , ' ', a.last_name ) as nombre_actor, count(fa.film_id ) as total_peliculas
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
group by nombre_actor ;

--Ejercicio 48 Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select concat(a.first_name , ' ', a.last_name ) as nombre_actor, count(fa.film_id ) as total_peliculas
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
group by nombre_actor ;

select *
from actor_num_peliculas ;

--Ejercicio 49 Calcula el número total de alquileres realizados por cada cliente.
select c.customer_id, concat(c.first_name, ' ', c.last_name) as nombre_cliente, count(r.rental_id) as total_alquileres
from customer c
left join rental r 
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name ;

--Ejercicio 50 Calcula la duración total de las películas en la categoría 'Action'.
select sum (f.length ) as duracion, c."name" 
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c."name"  = 'Action' 
group by c."name"  ;

--Ejercicio 51 Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as
select c.customer_id, concat(c.first_name, ' ', c.last_name) as nombre_cliente, count(r.rental_id) as total_alquileres
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name;

--Ejercicio 52 Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select f.title as pelicula, count(r.rental_id ) as veces_alquilada
from film f 
left join inventory i 
on f.film_id = i.film_id
left join rental r 
on i.inventory_id = r.inventory_id
group by f.title 
having count(r.rental_id ) > 10 ;

--Ejercicio 53 Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select f.title  as pelicula, concat(c.first_name , ' ', c.last_name ) as nombre_cliente, r.return_date as fecha_devuelta
from film f 
left join inventory i 
on f.film_id = i.film_id
left join rental r 
on i.inventory_id = r.inventory_id
left join customer c 
on r.customer_id = c.customer_id
where c.first_name = 'TAMMY'
and r.return_date is null 
order by pelicula ;

--Ejercicio 54 Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
select concat(a.first_name , ' ', a.last_name ) as nombre_actor,f.title as pelicula , c."name" as categoria_pelicula
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
left join film f 
on fa.film_id = f.film_id
left join film_category fc 
on f.film_id = fc.film_id
left join category c 
on fc.category_id = c.category_id
where c."name" = 'Sci-Fi'
order by a.last_name ;

--Ejercicio 55 Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
select concat(a.first_name , ' ', a.last_name )as nombre_actor, f.title as pelicula, r.rental_date :: date as fecha
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id 
inner join film f 
on fa.film_id = f.film_id
inner join inventory i 
on f.film_id = i.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
where r.rental_date  > (
select  MIN(r2.rental_date   )
from rental r2 
inner join inventory i 
on r2.inventory_id = i.inventory_id
inner join film f2 
on i.film_id = f2.film_id
where f2.title like '%SPARTACUS CHEAPER%'
)
order by a.last_name ;

--Ejercicio 56 Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music'
select concat(a.first_name, ' ', a.last_name ) as nombre_actor, f.title as pelicula, c.name as categoria
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
left join film f 
on fa.film_id = f.film_id
left join film_category fc  
on f.film_id = fc.film_id
left join category c 
on fc.category_id = c.category_id
where c.name not like '%Music%'

--Ejercicio 57 Encuentra el título de todas las películas que fueron alquiladas por más de 8 días
select f.title  as pelicula ,r.return_date::date  - r.rental_date:: date as dias_alquilado
from film f 
inner join film_actor fa 
on f.film_id = fa.film_id
inner join inventory i 
on f.film_id = i.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
where (r.return_date::date  - r.rental_date:: date) > 8 ;

--Ejercicio 58 Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select f.title as pelicula, c.name as categoria
from film f 
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on fc.category_id = c.category_id
where c.name = 'Animation' ;

--Ejercicio 59 Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
select f.title  as pelicula, f.length as duracion
from film f 
where f.length = (
select f2.length 
from film f2 
where f2.title like 'DANCING FEVER')
order by f.title ;

--Ejercicio 60 Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select concat(c.first_name , ' ', c.last_name ) as nombre_cliente, count(distinct f.title )
from customer c 
inner join rental r 
on c.customer_id = r.customer_id
inner join inventory i 
on r.inventory_id = i.inventory_id
inner  join film f 
on f.film_id  = i.film_id 
group by nombre_cliente , c.last_name 
having count(distinct f.title ) >= 7
order by c.last_name ;

--Ejercicio 61 Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select count(r.rental_id ) as total_alquilada, c.name as categoria
from rental r 
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
group by c.name ;

--Ejercicio 62  Encuentra el número de películas por categoría estrenadas en 2006.
select count(f.title ) as total_peliculas, f.release_year as estreno
from rental r 
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
where f.release_year = '2006'
group by f.release_year ;

--Ejercicio 63 Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select concat(s.first_name , ' ', s.last_name ) as nombre_trabajador, s2.store_id 
from staff s 
cross join store s2 ;

--Ejercicio 64 Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select concat(c.first_name , ' ', c.last_name )as nombre_cliente, c.customer_id, count(f.title ) as peliculas_alquiladas
from rental r 
inner join customer c 
on r.customer_id = c.customer_id
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
group by c.customer_id ;






