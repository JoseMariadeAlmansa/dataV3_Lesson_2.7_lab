-- --------1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.---------------
USE sakila;
SELECT name AS 'category_name', COUNT(fc.film_id) as films_per_category
FROM sakila.category c
JOIN sakila.film_category fc
ON  fc.category_id=c.category_id
JOIN sakila.film f
ON fc.film_id=f.film_id
GROUP BY name
ORDER BY COUNT(film_id) DESC;
-- ---------------2. Display the total amount rung up by each staff member in August of 2005. How many has each member collect-------------------
SELECT sum(p.amount) as "Total", s.staff_id
FROM sakila.payment p -- table 1
JOIN sakila.staff s -- table 2
ON p.staff_id = s.staff_id
Where month(p.payment_date) = 8 and year(p.payment_date) = 2005
Group by staff_id;
-- --------------------------------------3. Which actor has appeared in the most films?-------------------------------------------------------
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS 'Name', COUNT(f.film_id) 
FROM sakila.film f
JOIN sakila.film_actor fa
ON  fa.film_id=f.film_id
JOIN sakila.actor a
ON fa.actor_id=a.actor_id
GROUP BY actor_id
ORDER BY COUNT(f.film_id) DESC
LIMIT 1;
 -- --------------------------4. Most active customer (the customer that has rented the most number of films)--------------------
 SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS 'Name' , COUNT(f.film_id) 
FROM sakila.film f
JOIN sakila.film_actor fa
ON  fa.film_id=f.film_id
JOIN sakila.actor a
ON fa.actor_id=a.actor_id
GROUP BY customer_id
ORDER BY COUNT(c.customer_id) DESC
LIMIT 1;
-- -------------------------5. Display the first and last names, as well as the address, of each staff member.-------------------------------
#5 Display the first and last names, as well as the address, of each staff member.
SELECT T1.first_name, T1.last_name, T2.address, T2.postal_code, T3.city, T4.country FROM sakila.staff AS T1
INNER JOIN sakila.address AS T2 on T1.address_id = T2.address_id
LEFT JOIN sakila.city AS T3 on T2.city_id = T3.city_id
LEFT JOIN sakila.country AS T4 ON T3.country_id = T4.country_id;
-- --------------------------6. List each film and the number of actors who are listed for that film.-----------------------------------------
SELECT film.title AS Film_title, count(film_actor.actor_id) AS Actors FROM sakila.film
INNER JOIN sakila.film_actor ON sakila.film.film_id = sakila.film_actor.film_id
GROUP BY title
ORDER BY Actors DESC;
-- 7. Using the tables `payment` and `customer` and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT sakila.customer.First_Name, sakila.customer.Last_Name, SUM(sakila.payment.amount) AS Total_Amount
FROM sakila.customer
JOIN sakila.payment ON sakila.customer.customer_id = sakila.payment.customer_id
GROUP BY First_Name, Last_Name
ORDER BY Last_Name;
-- -------------------------------------------------8. List number of films per `category`.----------------------------------------------------
SELECT c.name AS Category, COUNT(DISTINCT f.title) AS Films
FROM sakila.film AS f
INNER JOIN sakila.film_category AS fc ON fc.film_id = f.film_id
INNER JOIN sakila.category AS c ON c.category_id = fc.category_id
GROUP BY c.name;