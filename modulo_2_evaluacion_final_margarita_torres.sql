-- ==============================================================
-- EVALUACION FINAL. MODULO_2.
-- ==============================================================

/* Para este ejerccio utilizaremos la BBDD Sakila que hemos estado utilizando durante el repaso de SQL. Es 
una base de datos de ejemplo que simula una tienda de alquiler de películas. Contiene tablas como film
(películas), actor (actores), customer (clientes), rental (alquileres), category (categorías), entre otras. 
Estas tablas contienen información sobre películas, actores, clientes, alquileres y más, y se utilizan para 
realizar consultas y análisis de datos en el contexto de una tienda de alquiler de películas.*/

USE sakila; -- seleccionamos la bbdd que vamos a usar durante el ejercicio:

/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/

SELECT DISTINCT title -- Utilizamos el operador DISTINCT que nos da los registros únicos.
FROM film;

-- ================================================================
/* 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/

SELECT title, rating
FROM film
WHERE rating = "PG-13";  -- Usamos el condicional WHERE 

-- ================================================================

/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en 
su descripción.*/

SELECT title, description
FROM film
WHERE description REGEXP "amazing";  --  Usamos la función REGEX para encontra el patrón en los textos de description.

-- ================================================================
/* 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/

SELECT title, length AS 'length(min)'
FROM film
WHERE length > 120;  

-- ================================================================
/* 5. Recupera los nombres de todos los actores.*/

SELECT first_name
FROM actor;

-- ================================================================
/* 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/

SELECT first_name, last_name
FROM actor
WHERE last_name IN ("Gibson");    -- Utilizamos el operador IN para buscar registros con la coincidencia indicada.alter

-- ================================================================
/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/

SELECT actor_id, first_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;   --  Utilizamos el operador BETWEEN para buscar registros comprendidos entre dos valores ESTOS INCLUSIVE.alter
                                    -- Podríamos usar dos cláusulas WHERE si quisieramos no incluir los valores.
 
 -- ================================================================
 /* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su 
clasificación.*/

SELECT title, rating
FROM film
WHERE rating NOT IN ("R", "PG-13");   -- Utilizamos el operador NOT IN ya que nos permite introducir varios valores.

 -- ================================================================
 /*9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la 
clasificación junto con el recuento.*/ 

-- buscamos la cantidad total de peliculas para las siguientes clasificaciones:
-- release_year, language_id, original_language_id, rental_duration, rental_rate,length, replacement_cost, rating,special_features, last_update

SELECT release_year, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY release_year ;

SELECT language_id, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY language_id;

SELECT original_language_id, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY original_language_id;

SELECT rental_duration, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY rental_duration;

SELECT rental_rate, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY rental_rate ;

SELECT length, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY length;

SELECT replacement_cost, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY replacement_cost;

SELECT rating, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY rating;

SELECT special_features, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY special_features;

SELECT last_update, COUNT(DISTINCT title) AS Total_movies
FROM film
GROUP BY last_update;

 -- ================================================================
 /*10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su 
nombre y apellido junto con la cantidad de películas alquiladas.*/

SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.customer_id) AS RENTED_MOVIES
FROM customer
CROSS JOIN rental
WHERE customer.customer_id = rental.customer_id
GROUP BY rental.customer_id;

/* SELECT COUNT(customer_id), customer_id
FROM rental
GROUP BY customer_id -- AGRUPAMOS Los alquileres realizador por cliente (id_customers). Esto nos da el numero de transacciones por cliente.

con la función CROSS JOIN  combinamos las tablas rental y customers para relacionar el id_customer con los datos cliente.*/
-- el CROSS JOIN combina todas las filas de una tabla con la otra 

 -- ================================================================
 /* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la 
categoría junto con el recuento de alquileres.*/

/*SELECT COUNT(film_id), film_id
FROM inventory
GROUP BY film_id;-- las veces que se ha inventariado cada peli */


SELECT COUNT(inventory.film_id) AS RENTED_MOVIES, category.name AS GENDER
FROM inventory
    INNER JOIN film_category ON film_category.film_id = inventory.film_id  -- Relacionamos la tabla inventory con film_category
         INNER JOIN category ON category.category_id = film_category.category_id -- Relacionamos la tabla film category con category donde se encuentra género
GROUP BY category.name; -- agrupamos por género 

  -- =====================================================================
  
/*12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y 
muestra la clasificación junto con el promedio de duración.*/

SELECT AVG(length);

SELECT release_year, AVG(length) 
FROM film
GROUP BY release_year ;

SELECT language_id, AVG(length) 
FROM film
GROUP BY language_id;

SELECT original_language_id, AVG(length) 
FROM film
GROUP BY original_language_id;

SELECT rental_duration, AVG(length) 
FROM film
GROUP BY rental_duration;

SELECT rental_rate, AVG(length) 
FROM film
GROUP BY rental_rate ;

SELECT length, AVG(length) 
FROM film
GROUP BY length;

SELECT replacement_cost, AVG(length) 
FROM film
GROUP BY replacement_cost;

SELECT rating, AVG(length) 
FROM film
GROUP BY rating;

SELECT special_features, AVG(length) 
FROM film
GROUP BY special_features;

SELECT last_update, AVG(length) 
FROM film
GROUP BY last_update;

 -- =====================================================================
/*13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/

SELECT a.first_name, a.last_name, f.title
FROM actor as a
    INNER JOIN film_actor as fa ON a.actor_id = fa.actor_id -- unimos las tablas film + actors + film_actor
       INNER JOIN  film as f ON fa.film_id = f.film_id
WHERE f.title = 'Indian Love';

 -- =====================================================================
/*14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/

SELECT title, description
FROM film
WHERE description REGEXP ('dog|cat'); -- Usamos regex para buscar patrón en un texto.

 -- =====================================================================
/*15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.*/

SELECT a.first_name, a.last_name, fa.film_id
FROM actor as a
RIGHT JOIN film_actor as fa ON a.actor_id = fa.actor_id -- Usamos RIGHT JOIN ya que nos dará la información coincidente en ambas tablas y aquellas que no coincidan nos dará un 'NULL'
WHERE fa.film_id ='NULL';                                -- si ejecutamos hasta el join vemos que no hay ningun NULL

 -- =====================================================================
 /*16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
 
 SELECT title, release_year
 FROM film
 WHERE release_year BETWEEN 2005 AND 2010;

 -- =====================================================================
 /*17. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/
 
SELECT f.title, c.name as gender
FROM category as c
    INNER JOIN film_category as fc ON c.category_id = fc.category_id -- Relacionamos la tabla inventory con film_category
         INNER JOIN film as f ON fc.film_id = f.film_id -- Relacionamos la tabla film category con category donde se encuentra género
WHERE c.name LIKE ("Family");

 -- =====================================================================
/*18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/
 
SELECT a.first_name, a.last_name, count(fa.film_id) as appears_in_movie
FROM actor as a
INNER JOIN fiLM_actor as fa ON a.actor_id=fa.actor_id
GROUP BY fa.actor_id
HAVING appears_in_movie > 10;

 -- =====================================================================
 /*19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la 
tabla film.*/
-- 2 horas= 180 min 

SELECT title, rating, length
FROM  film 
WHERE rating = 'R' AND length > 180;

-- =====================================================================
/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 
minutos y muestra el nombre de la categoría junto con el promedio de duración.*/

SELECT c.name as gender, AVG(f.length) as avg_length
FROM category as c
    INNER JOIN film_category as fc ON c.category_id = fc.category_id -- Relacionamos la tabla inventory con film_category
         INNER JOIN film as f ON fc.film_id = f.film_id 
GROUP BY gender
HAVING  avg_length > 120;

-- =====================================================================
/*21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor 
junto con la cantidad de películas en las que han actuado.*/

SELECT a.first_name, a.last_name, count(fa.film_id) as appears_in_movie
FROM actor as a
INNER JOIN fiLM_actor as fa ON a.actor_id=fa.actor_id
GROUP BY fa.actor_id
HAVING appears_in_movie >= 5;

-- =====================================================================
/*22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una 
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona 
las películas correspondientes.*/

SELECT DISTINCT f.title -- Le añadimos un DISTINCT  porque aparecen varios duplicados -- , DATEDIFF(r.return_date, r.rental_date)as rental_time (podemos añadirlo para comprobar resultados)
FROM film AS f
    INNER JOIN inventory AS i ON f.film_id=i.film_id
    INNER JOIN rental AS r ON r.inventory_id=i.inventory_id
GROUP BY r.rental_id
HAVING r.rental_id IN (
					   SELECT r.rental_id 
					   FROM rental as r
					   WHERE DATEDIFF(r.return_date, r.rental_date) > 5);
                      

-- si ejecutamos la consulta principal obtenemos los tiempos de renta de cada pelicula.
SELECT distinct f.title,f.rental_duration
FROM film AS f
    INNER JOIN inventory AS i ON f.film_id=i.film_id
    INNER JOIN rental AS r ON r.inventory_id=i.inventory_id
GROUP BY r.rental_id; 
-- Estos pasos son indispensables para poder relacionar el rental_id de la tabla rental
-- Si ejecutamos la subconsulta, obtenemos los rental_id con un tiempo de renta superior a 5:
SELECT rental_id, DATEDIFF(return_date, rental_date) as rental_time -- usamos la funcion DATEDIFF  que nos devuelve la diferencia  entre fechas en dias 
FROM rental
WHERE DATEDIFF(return_date, rental_date) > 5;

                      
-- =====================================================================
/*23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la 
categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en 
películas de la categoría "Horror" y luego exclúyelos de la lista de actores.*/

SELECT a1.first_name, a1.last_name, actor_id
FROM  actor as a1
WHERE a1.actor_id NOT IN (
      SELECT a.actor_id
	  FROM actor AS a
           INNER JOIN film_actor as fa ON a.actor_id = fa.actor_id
               INNER JOIN film_category as fc ON fa.film_id = fc.film_id
                   INNER JOIN category as c ON c.category_id = fc.category_id
	  GROUP BY fa.actor_id, c.name -- agrupamos film_is por actor_id (tabla film_actor) y film_id por categoría_id(name) (tabla film_category)
      HAVING c.name ='Horror');

-- actores que han actuado en pelis de 'horror':
SELECT a.actor_id
FROM actor AS a
INNER JOIN film_actor as fa ON a.actor_id = fa.actor_id
INNER JOIN film_category as fc ON fa.film_id = fc.film_id
INNER JOIN category as c ON c.category_id = fc.category_id
GROUP BY fa.actor_id, c.name -- agrupamos film_is por actor_id (tabla film_actor) y film_id por categoría_id (tabla film_category)
HAVING c.name ='Horror';             -- tenemos varias id film que coinciden en categoria y varios id film  que coinciden en actores_id


-- =====================================================================
-- =====================================================================

/*BONUS*/

/*24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 
minutos en la tabla film.*/

-- Utilizamos las querys realizadas anteriormente y aplicamos el operador UNION eliminadno duplicados:
SELECT f.title, c.name as gender
FROM category as c
    INNER JOIN film_category as fc ON c.category_id = fc.category_id -- Relacionamos la tabla inventory con film_category
         INNER JOIN film as f ON fc.film_id = f.film_id -- Relacionamos la tabla film category con category donde se encuentra género
WHERE c.name LIKE ("Comedy")
UNION
SELECT title, length AS 'length(min)'
FROM film
WHERE length > 120;

/*25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La 
consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que 
han actuado juntos.*/

 WITH FIN
 AS (

WITH pares_actores_mismo_id
AS ( WITH actor_film -- CREAMOS UNA CTE CON LAS TABLAS ACTOR Y FILM JUNTAS 
     AS ( 
         SELECT a.actor_id, a.first_name, a.last_name , fa.film_id
         FROM actor as a
         INNER JOIN fiLM_actor as fa ON a.actor_id=fa.actor_id
	      )
	 SELECT  -- HACEMOS UN SELF JOIN PARA SACRA LA PAREJA DE ACTORES DONDE FILM-ID SEA IGUAL
			z.first_name as nombre_a, 
            z.last_name as apellido_a,
            c.first_name as nombre_b, 
            c.last_name as apellido_b,
            c.film_id as film_id_fun

     FROM actor_film as z , actor_film as c
     WHERE z.actor_id <> c.actor_id
     AND z.film_id =c.film_id
	)-- mETIMOS LA TABLA OBTENIDA EN UNA TABLA 
SELECT f.title AS titulo,
       p.nombre_a, 
	   p.apellido_a,
	   p.nombre_b, 
	   p.apellido_b
FROM pares_actores_mismo_id as p
INNER JOIN film AS f ON f.film_id = p.film_id_fun-- JUNTAMOS LA TABLA CREADA CON FILM
)
 SELECT titulo
 FROM FIN 
 GROUP BY nombre_b ;



-- PRIMERO CREAMOS ESTA FUNCION--

WITH actor_film -- CREAMOS UNA CTE CON LAS TABLAS ACTOR Y FILM JUNTAS 
AS ( 
SELECT a.actor_id, a.first_name, a.last_name , fa.film_id
FROM actor as a
INNER JOIN fiLM_actor as fa ON a.actor_id=fa.actor_id
)
SELECT  -- HACEMOS UN SELF JOIN PARA SACRA LA PAREJA DE ACTORES DONDE FILM-ID SEA IGUAL
       z.first_name, 
       z.last_name,
       c.first_name, 
       c.last_name 
FROM actor_film as z , actor_film as c
WHERE z.actor_id <> c.actor_id
AND z.film_id =c.film_id;