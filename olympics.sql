----How many rows are in the athletes table? How many distinct athlete ids?
SELECT COUNT(*) 
FROM athletes;

SELECT COUNT(DISTINCT id) 
FROM athletes;

----Which years are represented in the summer_games, winter_games, and country_stats tables?
SELECT DISTINCT year
FROM summer_games;

SELECT DISTINCT year
FROM winter_games;

SELECT DISTINCT year
FROM country_stats;

----How many distinct countries are represented in the countries and country_stats table?
SELECT COUNT(DISTINCT country)
FROM countries;

SELECT COUNT(DISTINCT country_id)
FROM country_stats;

----How many distinct events are in the winter_games and summer_games table?
SELECT COUNT(DISTINCT event)
FROM winter_games;

SELECT COUNT(DISTINCT event)
FROM summer_games;

----Count the number of athletes who participated in the summer games for each country. Your output should have country name and number of athletes in their own columns. Did any country have no athletes?
SELECT *
FROM countries
LEFT JOIN summer_games
ON countries.id = summer_games.country_id;

SELECT country, COUNT (DISTINCT athlete_id) as total_athletes
FROM countries
LEFT JOIN summer_games
on countries.id = summer_games.country_id
GROUP BY country
ORDER BY total_athletes;

----Write a query to list countries by total bronze medals, with the highest totals at the top and nulls at the bottom. Adjust the query to only return the country with the most bronze medals.

SELECT country, SUM(bronze) AS total_bronze
FROM countries
LEFT JOIN summer_games
ON countries.id = summer_games.country_id
GROUP BY country
ORDER BY total_bronze DESC NULLS LAST
LIMIT 1;

----Calculate the average population in the country_stats table for countries in the winter_games. This will require 2 joins. First query gives you country names and the average population. Second query returns only countries that participated in the winter_games.
SELECT country, AVG (pop_in_millions::NUMERIC) AS avg_pop
FROM winter_games 
INNER JOIN countries
ON winter_games.country_id = countries.id
INNER JOIN country_stats
ON countries.id = country_stats.country_id
GROUP BY country
ORDER BY avg_pop DESC;

----Identify countries where the population decreased from 2000 to 2006.
SELECT country, a.year, a.pop_in_millions, b.year, b.pop_in_millions
FROM country_stats AS a
INNER JOIN country_stats AS b
ON a.country_id = b.country_id
INNER JOIN countries
ON a.country_id = countries.id
WHERE a.year = '2000-01-01' AND b.year = '2006-01-01'
AND a.pop_in_millions::NUMERIC > b.pop_in_millions::NUMERIC;