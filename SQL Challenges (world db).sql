USE world;

SHOW TABLES FROM world;

#1. Using COUNT, get the number of cities in the USA.

SELECT COUNT(Name) FROM city
WHERE CountryCode = "USA";

#2. Find out the population and life expectancy for people in Argentina.

SELECT SUM(Population) FROM city
WHERE CountryCode = "ARG";

#3. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?

SELECT Name, MAX(LifeExpectancy) FROM country
WHERE LifeExpectancy IS NOT NULL
GROUP BY Name
ORDER BY LifeExpectancy DESC
LIMIT 1;

#4. Using JOIN ... ON, find the capital city of Spain.

SELECT ci.Name FROM city AS ci
JOIN country as co
ON ci.CountryCode = co.Code
WHERE co.Name = "Spain";

#5. Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.

SELECT DISTINCT cl.Language FROM countrylanguage AS cl
JOIN country AS c
ON cl.CountryCode = c.Code
WHERE Region = "Southeast Asia";

#6. Using a single query, list 25 cities around the world that start with the letter F.

SELECT Name FROM city
WHERE Name LIKE "F%"
LIMIT 25;

#7. Using COUNT and JOIN ... ON, get the number of cities in China.

SELECT COUNT(ci.Name) FROM city AS ci
JOIN country AS co
ON ci.CountryCode = co.Code
WHERE co.Name = "China";

#8. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.

SELECT Name, MIN(Population) FROM country
WHERE Population != "0"
GROUP BY Name
ORDER BY Population ASC
LIMIT 1;

#9. Using aggregate functions, return the number of countries the database contains.

SELECT DISTINCT COUNT(Code) from country;

#10. What are the top ten largest countries by area?

SELECT Name, MAX(SurfaceArea) FROM country
GROUP BY Name
ORDER BY MAX(SurfaceArea) DESC
LIMIT 10;

#11. List the five largest cities by population in Japan.

SELECT ci.Name, ci.Population FROM city AS ci
JOIN country AS co
ON ci.CountryCode = co.Code
WHERE co.Name = "Japan"
GROUP BY ci.Name
ORDER BY ci.Population DESC
LIMIT 5;

#12. List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!

SELECT Code, Name, HeadOfState FROM country;

UPDATE country
SET HeadOfState = "Elizabeth II"
WHERE HeadOfState = "Elisabeth II";

SELECT Code, Name FROM country
WHERE HeadOfState = "Elizabeth II";

#13. List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.

SELECT Name, Population/SurfaceArea FROM country
WHERE Population/SurfaceArea != "0"
ORDER BY Population/SurfaceArea ASC
LIMIT 10;

#14. List every unique world language.

SELECT DISTINCT Language FROM countrylanguage;

#15. List the names and GNP of the world's top 10 richest countries.

SELECT Name, GNP FROM country
ORDER BY GNP DESC
LIMIT 10;

#16. List the names of, and number of languages spoken by, the top ten most multilingual countries.

SELECT c.Name, COUNT(cl.Language) FROM country AS c
JOIN countrylanguage AS cl
ON c.Code = cl.CountryCode
GROUP BY c.Name
ORDER BY COUNT(cl.Language) DESC
LIMIT 10;

#17. List every country where over 50% of its population can speak German.

SELECT c.Name FROM country AS c
JOIN countrylanguage AS cl
ON c.Code = cl.CountryCode
WHERE cl.Language = "German" AND cl.Percentage > 50;

#18. Which country has the worst life expectancy? Discard zero or null values.

SELECT Name, MIN(LifeExpectancy) FROM country
WHERE LifeExpectancy IS NOT NULL AND LifeExpectancy != "0"
GROUP BY Name
ORDER BY LifeExpectancy ASC
LIMIT 1;

#19. List the top three most common government forms.

SELECT GovernmentForm, COUNT(GovernmentForm) FROM country
GROUP BY GovernmentForm
ORDER BY COUNT(GovernmentForm) DESC
LIMIT 3;

#20. How many countries have gained independence since records began?

SELECT DISTINCT IndepYear FROM country;

SELECT COUNT(IndepYear) FROM country
WHERE IndepYear IS NOT NULL;