USE sakila;

#1. List all actors.

DESCRIBE actor;
SELECT * FROM actor;

#2. Find the surname of the actor with the forename 'John'.

SELECT last_name FROM actor
WHERE first_name = "John";

#3. Find all actors with surname 'Neeson'.

SELECT * FROM actor
WHERE last_name = "Neeson";

#4. Find all actors with ID numbers divisible by 10.

SELECT * FROM actor
WHERE actor_id %10 = 0;

#5. What is the description of the movie with an ID of 100?

DESCRIBE film;
SELECT description FROM film
WHERE film_id = 100;

#6. Find every R-rated movie.

SELECT * FROM film
WHERE rating = "R";

#7. Find every non-R-rated movie.

SELECT * FROM film
WHERE rating != "R";

#8. Find the ten shortest movies.

SELECT * FROM film 
ORDER BY length ASC
LIMIT 10;

#9. Find the movies with the longest runtime, without using LIMIT.

CREATE VIEW longest_runtime
AS
SELECT MAX(length) FROM film;

SELECT * FROM film
WHERE length = (SELECT * FROM longest_runtime); #probably an inefficient use of a view but practice makes perfect!

#10. Find all movies that have deleted scenes.

SELECT * FROM film
WHERE special_features = "Deleted Scenes";

#11. Using HAVING, reverse-alphabetically list the last names that are not repeated.

SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1
ORDER BY last_name DESC;

#12. Using HAVING, list the last names that appear more than once, from highest to lowest frequency.

SELECT last_name, COUNT(last_name) AS Frequency FROM actor
GROUP BY last_name
HAVING COUNT(last_name) != 1
ORDER BY COUNT(last_name) DESC;

#13. Which actor has appeared in the most films?

DESCRIBE actor;
DESCRIBE film_actor;

CREATE VIEW max_actor
AS
SELECT actor_id FROM film_actor
GROUP BY actor_id
HAVING COUNT(actor_id) != 1
ORDER BY COUNT(actor_id) DESC
LIMIT 1;

SELECT CONCAT(first_name, " ", last_name) AS Full_Name FROM actor
WHERE actor_id = (SELECT * from max_actor);

#14. When is 'Academy Dinosaur' due?

DESCRIBE inventory;
DESCRIBE film;
DESCRIBE rental;

SELECT r.return_date FROM rental AS r
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
JOIN film AS f
ON i.film_id = f.film_id
WHERE f.title = "Academy Dinosaur"
ORDER BY r.return_date DESC
LIMIT 1;

#15. What is the average runtime of all films?

SELECT AVG(length) FROM film;

#16. List the average runtime for every film category.

DESCRIBE film;
DESCRIBE film_category;

SELECT fc.category_id, AVG(f.length) FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
GROUP BY fc.category_id;

#17. List all movies featuring a robot.

DESCRIBE film;

SELECT * FROM film
WHERE description LIKE "%robot%";

#18. How many movies were released in 2010?

SELECT COUNT(title) FROM film
WHERE release_year = "2010";

#19. Find the titles of all the horror movies.

SELECT f.title FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
WHERE c.name = "Horror";

#20. List the full name of the staff member with the ID of 2.

SELECT CONCAT(first_name, " ", last_name) AS FullName FROM staff
WHERE staff_id = 2;

#21. List all the movies that Fred Costner has appeared in.

SELECT f.title FROM film AS f
JOIN film_actor AS fa
ON f.film_id = fa.film_id
JOIN actor AS a
ON fa.actor_id = a.actor_id
WHERE a.first_name = "Fred" AND a.last_name = "Costner";

#22. How many distinct countries are there?

SELECT DISTINCT COUNT(country) FROM country;

#23. List the name of every language in reverse-alphabetical order.

SELECT DISTINCT name FROM language
ORDER BY name DESC;

#24. List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.

SELECT CONCAT(first_name, " ", last_name) AS FullName FROM actor
WHERE last_name LIKE "%son"
ORDER BY first_name ASC;

#25. Which category contains the most films?

SELECT c.name FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
GROUP BY fc.category_id
HAVING COUNT(fc.category_id) != 1
ORDER BY COUNT(fc.category_id) DESC
LIMIT 1;
