USE movielens;

#1. List the titles and release dates of movies released between 1983-1993 in reverse chronological order.

SELECT title, release_date FROM movies
WHERE YEAR(release_date) BETWEEN 1983 AND 1993
ORDER BY release_date DESC;

#2. Without using LIMIT, list the titles of the movies with the lowest average rating.

SELECT m.title FROM movies AS m
JOIN ratings AS r
ON m.id = r.movie_id
WHERE rating = (SELECT MIN(rating) FROM ratings);

#3. List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.

SELECT DISTINCT m.title FROM movies AS m
JOIN genres_movies AS gm 
ON m.id = gm.movie_id
JOIN genres AS g 
ON gm.genre_id = g.id
JOIN ratings AS r 
ON m.id = r.movie_id
JOIN users AS u 
ON r.user_id = u.id
JOIN occupations AS o 
ON u.occupation_id = o.id
WHERE g.name = "Sci-Fi" AND r.rating = "5" AND u.age = "24" AND u.gender = "m" AND o.name = "student";

#4. List the unique titles of each of the movies released on the most popular release day.

CREATE VIEW most_popular_release_date
AS
SELECT release_date
FROM movies 
GROUP BY release_date
ORDER BY COUNT(release_date) 
DESC LIMIT 1;

SELECT DISTINCT title FROM movies
WHERE release_date = (SELECT * FROM most_popular_release_date); 

#5. Find the total number of movies in each genre; list the results in ascending numeric order.

SELECT g.name, COUNT(m.id) FROM genres AS g
JOIN genres_movies AS gm
	ON g.id = gm.genre_id
JOIN movies AS m
	ON gm.movie_id = m.id
GROUP BY gm.genre_id
ORDER BY COUNT(m.id) ASC;
