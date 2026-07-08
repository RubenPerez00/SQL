# 🚀 Proyecto SQL

Este readme contiene el desarrollo completo, la metodología y los ejercicios resueltos de la BBDD de **Sakila** en **PostgreSQL**.

--- 

## 📊 Tecnologías Utilizadas
* **Motor de Base de Datos:** PostgreSQL 
* **Lenguaje:** SQL
* **Aplicación**: DBeaver

---

## 🗂️ Contenido del Proyecto
El script principal resuelve los ejercicios prácticos utilizando las siguientes técnicas:

1. **Operaciones Básicas de Filtrado y Selección:** Uso de `WHERE`, `LIKE`, `IN`, `BETWEEN`, `LIMIT` y `OFFSET`.
2. **Funciones de Agregación y Variabilidad:** Cálculo de métricas de negocio con `SUM()`, `AVG()`, `COUNT()`, `MIN()`, `MAX()`, `STDDEV()` y `VARIANCE()`.
3. **Agrupamientos Avanzados:** Segmentación de datos mediante `GROUP BY` y filtrado analítico con `HAVING`.
4. **Relaciones Complejas (JOINs):** Implementación de `INNER JOIN`, `LEFT JOIN` (para detectar nulos/faltantes) y análisis crítico de `CROSS JOIN`.
5. **Estructuras Avanzadas y Subconsultas:** Creación de subconsultas dinámicas en el `WHERE`, vistas persistentes (`CREATE VIEW`) y tablas temporales (`CREATE TEMPORARY TABLE`).
---

## 🗺️ Esquema de la Base de Datos
El proyecto se basa en el modelo real de una tienda que contempla las siguientes categorías, a su vez corresponde con el Ejercicio 1 : Crea el esquema de la BBDD.

* **Inventario y Catálogo:** `film`, `category`, `film_category`, `inventory`.
* **Actores y Producción:** `actor`, `film_actor`.
* **Operaciones y Clientes:** `rental`, `payment`, `customer`, `staff`, `store`.

---

## 🛠️ Ejercicios Resueltos

<details>
<summary><b>Ejercicio 1:</b>  Crea el esquema de la BBDD.</summary>
````
<img width="1444" height="1292" alt="Diagrama Proyecto" src="https://github.com/user-attachments/assets/056a0655-28b1-4a77-8d2c-0ca56e13498f" />
```
</details>

<details>
<summary><b>Ejercicio 2:</b> Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.</summary>

```sql
select f.title  as Nombre_pelicula, f.rating as clasificacion
from film f 
where f.rating = 'R';
```

</details>

<details>
<summary><b>Ejercicio 3:</b> Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.</summary>

```sql
select a.actor_id , concat(a.first_name , ' ', a.last_name ) as Nombre_completo_actor
from actor a 
order by a.actor_id 
limit 11 offset 29 ;
```

</details>

<details>
<summary><b>Ejercicio 4:</b> Obtén las películas cuyo idioma coincide con el idioma original.</summary>

```sql
select f.title as titulo
from film f 
where f.language_id  = f.original_language_id ;
```

</details>

<details>
<summary><b>Ejercicio 5:</b> Ordena las películas por duración de forma ascendente.</summary>

```sql
select f.title as titulo  , f.length  as duracion
from film f 
order by f.length  ;
```

</details>

<details>
<summary><b>Ejercicio 6:</b> Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.</summary>

```sql
select concat(a.first_name , ' ', a.last_name ) as Nombre_completo_actor
from actor a 
where a.last_name  like '%ALLEN%' ;
```

</details>

<details>
<summary><b>Ejercicio 7:</b> Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.</summary>

```sql
select count(f.title ) as total_peliculas , RATING as clasificacion
from film f 
group by f.rating ;
```

</details>

<details>
<summary><b>Ejercicio 8:</b> Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.</summary>

```sql
select f.title , f.rating as clasificacion , f.length  as duracion
from film f 
where f.rating  = 'PG-13'
or f.length  > 180 ;
```

</details>

<details>
<summary><b>Ejercicio 9:</b> Encuentra la variabilidad de lo que costaría reemplazar las películas.</summary>

```sql
select variance(f.replacement_cost ) as variabilidad_coste
from film f ;
```

</details>

<details>
<summary><b>Ejercicio 10:</b> Encuentra la mayor y menor duración de una película de nuestra BBDD.</summary>

```sql
select  MIN(f.length  ) as duracion_minima , MAX(f.length  ) as duracion_maxima
from film f ;
```

</details>

<details>
<summary><b>Ejercicio 11:</b> Encuentra lo que costó el antepenúltimo alquiler ordenado por día</summary>

```sql
select p.payment_date as dia_pago , p.amount as coste
from payment p 
order by p.payment_date desc 
limit 1 offset 2 ;
```

</details>

<details>
<summary><b>Ejercicio 12:</b> Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.</summary>

```sql
select f.title, f.rating as clasificacion
from film f 
where f.rating not in  ('NC-17' , 'G') ;
```

</details>

<details>
<summary><b>Ejercicio 13:</b> Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.</summary>

```sql
select f.rating as clasificacion, AVG(f.length  ) as duracion_media
from film f 
group by f.rating ;
```

</details>

<details>
<summary><b>Ejercicio 14:</b> Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos</summary>

```sql
select f.title as titulo, f.length  as duracion
from film f 
where f.length  > 180 ;
```

</details>

<details>
<summary><b>Ejercicio 15:</b> ¿Cuánto dinero ha generado en total la empresa?</summary>

```sql
select SUM(p.amount )
from payment p ;
```

</details>

<details>
<summary><b>Ejercicio 16:</b> Muestra los 10 clientes con mayor valor de id.</summary>

```sql
select c.customer_id , concat(c.first_name ,  ' ', c.last_name ) as nombre_cliente
from customer c 
order by c.customer_id desc
limit 10 ;
```

</details>

<details>
<summary><b>Ejercicio 17:</b> Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.</summary>

```sql
select a.actor_id , concat(a.first_name , ' ', a.last_name ) as nombre_actor, f.title as pelicula
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f
on fa.film_id = f.film_id 
where f.title like '%EGG IGBY%' ;
```

</details>

<details>
<summary><b>Ejercicio 18:</b> Selecciona todos los nombres de las películas únicos.</summary>

```sql
select distinct f.title 
from film f ;
```

</details>

<details>
<summary><b>Ejercicio 19:</b> Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.</summary>

```sql
select f.title as pelicula, f.length as duracion, c."name" as categoria_pelicula
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on c.category_id = fc.category_id 
where f.length  > 180 
and c."name" like 'Comedy' ;
```

</details>

<details>
<summary><b>Ejercicio 20:</b> Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.</summary>

```sql
select c."name" as categoria, AVG(f.length ) as media_duracion
from film f 
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on c.category_id = fc.category_id 
group by c."name"  
having AVG(f.length  ) > 110 ;
```

</details>

<details>
<summary><b>Ejercicio 21:</b> ¿Cuál es la media de duración del alquiler de las películas?</summary>

```sql
select  AVG(r.return_date - r.rental_date) 
from rental r ;
```

</details>

<details>
<summary><b>Ejercicio 22:</b> Crea una columna con el nombre y apellidos de todos los actores y actrices.</summary>

```sql
select concat(a.first_name , ' ', a.last_name ) as nombre_actores
from actor a ;
```

</details>

<details>
<summary><b>Ejercicio 23:</b> Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.</summary>

```sql
select r.rental_date :: date as fecha, count(r.rental_date ::date)
from rental r 
group by r.rental_date :: date
order by fecha desc ;
```

</details>

<details>
<summary><b>Ejercicio 24:</b> Encuentra las películas con una duración superior al promedio.</summary>

```sql
select f.title as pelicula, f.length as duracion
from film f 
where f.length > (
select AVG(f.length )
from film f ) ;
```

</details>

<details>
<summary><b>Ejercicio 25:</b> Averigua el número de alquileres registrados por mes.</summary>

```sql
select to_char(r.rental_date , 'MM-YYYY' ) as month_year, count(r.inventory_id )
from rental r 
group by  to_char(r.rental_date , 'MM-YYYY' )
order by month_year ;
```

</details>

<details>
<summary><b>Ejercicio 26:</b> Encuentra el promedio, la desviación estándar y varianza del total pagado.</summary>

```sql
select SUM(p.amount ) as total, AVG(p.amount ) as promedio, stddev(p.amount ) as desviacion_estandar, variance(p.amount ) as varianza
from payment p ;
```

</details>

<details>
<summary><b>Ejercicio 27:</b> ¿Qué películas se alquilan por encima del precio medio?</summary>

```sql
select f.title as pelicula , f.rental_rate as precio_medio
from film f 
where f.rental_rate > (
select AVG(f2.rental_rate )
from film f2) ;
```

</details>

<details>
<summary><b>Ejercicio 28:</b> Muestra el id de los actores que hayan participado en más de 40 películas.</summary>

```sql
select a.actor_id ,  concat(a.first_name , ' ', a.last_name ) as actor, count(fa.film_id ) as total_peliculas
from actor a 
inner join film_actor fa 
on a.actor_id  = fa.actor_id 
group by a.actor_id 
having count(fa.film_id ) > 40 ;
```

</details>

<details>
<summary><b>Ejercicio 29:</b> Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible</summary>

```sql
select f.title as pelicula , count(f.title ) as disponibles
from film f 
left join inventory i 
on i.film_id = f.film_id
group by f.title ;
```

</details>

<details>
<summary><b>Ejercicio 30:</b> Obtener los actores y el número de películas en las que ha actuado.</summary>

```sql
select a.actor_id ,concat(a.first_name , ' ', a.last_name ) as nombre_actor, count(f.title ) as total_peliculas_rodadas
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id 
left join film f 
on fa.film_id = f.film_id
group by a.actor_id ;
```

</details>

<details>
<summary><b>Ejercicio 31:</b> Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.</summary>

```sql
select f.title as pelicula, concat(a.first_name , ' ', a.last_name ) as nombre_actor
from film f 
left join film_actor fa 
on f.film_id = fa.film_id
left join actor a 
on fa.actor_id = a.actor_id
order by nombre_actor ;
```

</details>

<details>
<summary><b>Ejercicio 32:</b> Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.</summary>

```sql
select  concat(a.first_name , ' ', a.last_name ) as nombre_actor , f.title as pelicula
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id 
left  join film f 
on f.film_id = fa.film_id 
order by nombre_actor ;
```

</details>

<details>
<summary><b>Ejercicio 33:</b> Obtener todas las películas que tenemos y todos los registros de alquiler</summary>

```sql
select f.title as pelicula, r.rental_id as id_alquiler
from film f 
left join inventory i 
on f.film_id = i.film_id
left join rental r 
on i.inventory_id = r.inventory_id ;
```

</details>

<details>
<summary><b>Ejercicio 34:</b> Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.</summary>

```sql
select concat(c.first_name , ' ', c.last_name ) as nombre_cliente , SUM(p.amount ) as total_gastado
from payment p 
inner join customer c 
on c.customer_id = p.customer_id 
group by nombre_cliente  
order by SUM(p.amount ) desc
limit 5 ;
```

</details>

<details>
<summary><b>Ejercicio 35:</b> Selecciona todos los actores cuyo primer nombre es 'Johnny'.</summary>

```sql
select a.actor_id  ,a.first_name as nombre_actor , a.last_name as apellido_actor
from actor a  
where a.first_name like 'JOHNNY' ;
```

</details>

<details>
<summary><b>Ejercicio 36:</b> Renombra la columna “first_name” como Nombre y “last_name” como Apellido.</summary>

```sql
select a.first_name as nombre , a.last_name as apellido
from actor a ;
```

</details>

<details>
<summary><b>Ejercicio 37:</b> Encuentra el ID del actor más bajo y más alto en la tabla actor</summary>

```sql
select MIN(a.actor_id ) as id_minimo ,MAX(a.actor_id )  as id_maximo
from actor a ;
```

</details>

<details>
<summary><b>Ejercicio 38:</b> Cuenta cuántos actores hay en la tabla “actor”.</summary>

```sql
select count(a.actor_id ) as total_actores
from actor a ;
```

</details>

<details>
<summary><b>Ejercicio 39:</b> Selecciona todos los actores y ordénalos por apellido en orden ascendente.</summary>

```sql
select *
from  actor a 
order by a.last_name ;
```

</details>

<details>
<summary><b>Ejercicio 40:</b> Selecciona las primeras 5 películas de la tabla “film”.</summary>

```sql
select f.film_id , f.title as nombre_pelicula
from film f 
limit 5 ;
```

</details>

<details>
<summary><b>Ejercicio 41:</b> Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre.</summary>

```sql
¿Cuál es el nombre más repetido?
select  count( a.first_name) as veces_reptido , a.first_name  as nombre
from actor a 
group by a.first_name 
order by veces_reptido desc ;
```

</details>

<details>
<summary><b>Ejercicio 42:</b> Encuentra todos los alquileres y los nombres de los clientes que los realizaron.</summary>

```sql
select r.rental_id ,concat(c.first_name , ' ', c.last_name ) as nombre_cliente 
from rental r 
inner join customer c 
on r.customer_id = c.customer_id ;
```

</details>

<details>
<summary><b>Ejercicio 43:</b> Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres</summary>

```sql
select r.rental_id , concat(c.first_name , ' ', c.last_name ) as nombre_cliente
from customer c 
left join rental r 
on c.customer_id = r.customer_id
group by r.rental_id , nombre_cliente ;
```

</details>

<details>
<summary><b>Ejercicio 44:</b> Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué?</summary>

```sql
select *
from film f 
cross join  category c ;
```
> 💡 **Análisis técnico:** No nos aporta nada, ya que nos está sacando cada pelicula dentro de una catergoría, por ejemplo, la película ACADEMY DINOSAUR, se nos está generando con todos los disitintos tipos de categoría que hay... Una fila con comedia, otra con drama, otra fila con family.
Por lo que para mi no tiene mucho sentido.

</details>

<details>
<summary><b>Ejercicio 45:</b> Encuentra los actores que han participado en películas de la categoría 'Action'</summary>

```sql
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
```

</details>

<details>
<summary><b>Ejercicio 46:</b> Encuentra todos los actores que no han participado en películas.</summary>

```sql
select *
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f 
on fa.film_id = f.film_id
where f.title is null ;
```

</details>

<details>
<summary><b>Ejercicio 47:</b> Selecciona el nombre de los actores y la cantidad de películas en las que han participado.</summary>

```sql
select concat(a.first_name , ' ', a.last_name ) as nombre_actor, count(fa.film_id ) as total_peliculas
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
group by nombre_actor ;
```

</details>

<details>
<summary><b>Ejercicio 48:</b> Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.</summary>

```sql
create view actor_num_peliculas as
select concat(a.first_name , ' ', a.last_name ) as nombre_actor, count(fa.film_id ) as total_peliculas
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
group by nombre_actor ;
select *
from actor_num_peliculas ;
```

</details>

<details>
<summary><b>Ejercicio 49:</b> Calcula el número total de alquileres realizados por cada cliente.</summary>

```sql
select c.customer_id, concat(c.first_name, ' ', c.last_name) as nombre_cliente, count(r.rental_id) as total_alquileres
from customer c
left join rental r 
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name ;
```

</details>

<details>
<summary><b>Ejercicio 50:</b> Calcula la duración total de las películas en la categoría 'Action'.</summary>

```sql
select sum (f.length ) as duracion, c."name" 
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c."name"  = 'Action' 
group by c."name"  ;
```

</details>

<details>
<summary><b>Ejercicio 51:</b> Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.</summary>

```sql
create temporary table cliente_rentas_temporal as
select c.customer_id, concat(c.first_name, ' ', c.last_name) as nombre_cliente, count(r.rental_id) as total_alquileres
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name;
```

</details>

<details>
<summary><b>Ejercicio 52:</b> Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.</summary>

```sql
create temporary table peliculas_alquiladas as
select f.title as pelicula, count(r.rental_id ) as veces_alquilada
from film f 
left join inventory i 
on f.film_id = i.film_id
left join rental r 
on i.inventory_id = r.inventory_id
group by f.title 
having count(r.rental_id ) > 10 ;
```

</details>

<details>
<summary><b>Ejercicio 53:</b> Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto.</summary>

```sql
Ordena los resultados alfabéticamente por título de película.
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
```

</details>

<details>
<summary><b>Ejercicio 54:</b> Encuentra los nombres de los actores que han actuado en al menos una película que belongs a la categoría ‘Sci-Fi’.</summary>

```sql
Ordena los resultados alfabéticamente por apellido.
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
```

</details>

<details>
<summary><b>Ejercicio 55:</b> Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez.</summary>

```sql
Ordena los resultados alfabéticamente por apellido.
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
```

</details>

<details>
<summary><b>Ejercicio 56:</b> Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music'</summary>

```sql
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
```

</details>

<details>
<summary><b>Ejercicio 57:</b> Encuentra el título de todas las películas que fueron alquiladas por más de 8 días</summary>

```sql
select f.title  as pelicula ,r.return_date::date  - r.rental_date:: date as dias_alquilado
from film f 
inner join film_actor fa 
on f.film_id = fa.film_id
inner join inventory i 
on f.film_id = i.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
where (r.return_date::date  - r.rental_date:: date) > 8 ;
```

</details>

<details>
<summary><b>Ejercicio 58:</b> Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.</summary>

```sql
select f.title as pelicula, c.name as categoria
from film f 
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on fc.category_id = c.category_id
where c.name = 'Animation' ;
```

</details>

<details>
<summary><b>Ejercicio 59:</b> Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’.</summary>

```sql
Ordena los resultados alfabéticamente por título de película.
select f.title  as pelicula, f.length as duracion
from film f 
where f.length = (
select f2.length 
from film f2 
where f2.title like 'DANCING FEVER')
order by f.title ;
```

</details>

<details>
<summary><b>Ejercicio 60:</b> Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas.</summary>

```sql
Ordena los resultados alfabéticamente por apellido.
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
```

</details>

<details>
<summary><b>Ejercicio 61:</b> Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.</summary>

```sql
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
```

</details>

<details>
<summary><b>Ejercicio 62:</b> Encuentra el número de películas por categoría estrenadas en 2006.</summary>

```sql
select count(f.title ) as total_peliculas, f.release_year as estreno
from rental r 
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
where f.release_year = '2006'
group by f.release_year ;
```

</details>

<details>
<summary><b>Ejercicio 63:</b> Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.</summary>

```sql
select concat(s.first_name , ' ', s.last_name ) as nombre_trabajador, s2.store_id 
from staff s 
cross join store s2 ;
```

</details>

<details>
<summary><b>Ejercicio 64:</b> Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.</summary>

```sql
select concat(c.first_name , ' ', c.last_name )as nombre_cliente, c.customer_id, count(f.title ) as peliculas_alquiladas
from rental r 
inner join customer c 
on r.customer_id = c.customer_id
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
group by c.customer_id ;
```

</details>
