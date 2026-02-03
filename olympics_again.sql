----Find Athletes from Summer or Winter Games. Write a query to list all athlete names who participated in the Summer or Winter Olympics. Ensure no duplicates appear in the final table using a set theory clause.
(Select name, athlete_id
from athletes
inner join summer_games
on athletes.id = summer_games.athlete_id
)
UNION
(Select name, athlete_id
from athletes
inner join winter_games
on athletes.id = winter_games.athlete_id);

----Find Countries Participating in Both Games. Write a query to retrieve country_id and country_name for countries in the Summer Olympics. Add a JOIN to include the country’s 2016 population and exclude the country_id from the SELECT statement. Repeat the process for the Winter Olympics. Use a set theory clause to combine the results.
SELECT countries.country,
       country_stats.pop_in_millions
FROM countries
JOIN country_stats
  ON countries.id = country_stats.country_id
JOIN summer_games
  ON countries.id = summer_games.country_id
WHERE country_stats.year = '2016-01-01'
INTERSECT
SELECT countries.country,
       country_stats.pop_in_millions
FROM countries
JOIN country_stats
  ON countries.id = country_stats.country_id
JOIN winter_games
  ON countries.id = winter_games.country_id
WHERE country_stats.year = '2016-01-01';

----Identify Countries Exclusive to the Summer Olympics. Return the country_name and region for countries present in the countries table but not in the winter_games table.(Hint: Use a set theory clause where the top query doesn’t involve a JOIN, but the bottom query does.)
SELECT country,
       region
FROM countries
EXCEPT
SELECT countries.country,
       countries.region
FROM countries
JOIN winter_games
  ON countries.id = winter_games.country_id;