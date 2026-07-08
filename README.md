# 🚀 Proyecto SQL: Auditoría y Análisis de la BBDD Sakila

Este README contiene el desarrollo completo, la metodología, el informe ejecutivo y los ejercicios resueltos de la BBDD de **Sakila** en **PostgreSQL**.

--- 

## 📊 Tecnologías Utilizadas
* **Motor de Base de Datos:** PostgreSQL 
* **Lenguaje:** SQL
* **Aplicación:** DBeaver

---

## 📋 INFORME EXPLICATIVO DE LA BASE DE DATOS

El ecosistema de esta base de datos simula el modelo de negocio de una **cadena de videoclubs (alquiler de películas)**, estructurado sobre tres pilares fundamentales: el catálogo (producto), la logística (inventario y rentas) y las finanzas (clientes y pagos).

### 📈 1. Impacto Financiero y Facturación
* **La recaudación total:** La factura total registrada por la empresa es de **$67,416.51**, calculado con la función `SUM(amount)` dentro de la tabla `payment`.
* **El ticket medio:** El costo promedio o **ticket medio** por cada alquiler es de **$4.20**. El promedio obtenido a través de `AVG(amount)` se basa en las tarifas de diferentes tipos de cliente.
* **Matemáticas de fondo:** Mediante la aplicación de funciones estadísticas como `variance` e `stddev`, se analizaron los costes de reposición y las tasas de pago para determinar cuán predecible es el flujo de ingresos.
* **Los clientes VIP:** Se ha identificado a los 5 clientes de alto valor que gastaron la cantidad más grande (los líderes en la cima de los gastos son Karl Seal y Eleanor Hunt).

### 🎬 2. Rendimiento del Catálogo e Inventario
* **Películas más solicitadas:** El sistema crea tablas temporales para las películas que han tenido más de 10 alquileres, permitiéndolo en optimizar la disponibilidad en locales físicos.
* **Géneros clasificados:** Películas con clasificación 'NC-17' y 'PG-13' ocupan el mayor porcentaje en ambos inventarios fiscales y duración promedio de las películas por título.
* **Control sobre Activos: (Mantenimiento de pagos):** Se ha puesto en marcha un sistema de control de devoluciones pendientes (analizar clientes con alquileres activos tales como Tammy Sanders donde `return_date IS NULL` para combatir los desgastes de inventario).
* **Rotación de Productos:** Con `LEFT JOIN` entre `film` y `inventory`, se puede auditorizar qué copias reales hay en tienda de cada título del catálogo; identificar así posibles escaseces de stock.

---

## 🛠️ Decisiones de Arquitectura y Herramientas SQL
Para garantizar la escalabilidad, modularidad y eficiencia del análisis en PostgreSQL, se implementaron las siguientes soluciones técnicas:

* **Vistas Persistentes (`CREATE VIEW`):** Estos se aplicaron para facilitar el acceso continuo a la magnitud de participación en el volumen de películas del actor (`actor_num_peliculas`), minimizando la necesidad del servidor de calcular consultas pesadas con varias operaciones conjuntas una vez repetidas.
* **Tablas Temporales (`CREATE TEMPORARY TABLE`):** Fueron utilizadas en la segmentación de los clientes (`cliente_rentas_temporal`) y las películas de mayor interés para aislar los datos poco estables en la memoria de sesión y acelerar la generación de informes.
* **Operaciones Críticas y Buenas Prácticas:** * La redundancia fue evaluada mediante la medición del producto cartesiano (`CROSS JOIN`). Se observó que una intersección extensa entre películas y categorías crea combinaciones inútiles.

---

## 🗺️ Esquema de la Base de Datos
El proyecto se modela bajo una arquitectura relacional clásica que contempla las siguientes entidades (correspondiente al **Ejercicio 1: Creación del esquema de la BBDD**):

* **Inventario y Catálogo:** `film`, `category`, `film_category`, `inventory`.
* **Actores y Producción:** `actor`, `film_actor`.
* **Operaciones y Clientes:** `rental`, `payment`, `customer`, `staff`, `store`.
