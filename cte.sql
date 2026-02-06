----Utilizing the Olympic database: Winter Olympics Gold Medals
----Write a CTE called top_gold_winter to find the top 5 gold-medal-winning countries for Winter Olympics. 
WITH top_gold_winter AS (
    SELECT countries.country,
           COUNT(*) AS gold_medals
    FROM countries
    JOIN winter_games
      ON countries.id = winter_games.country_id
    WHERE winter_games.gold > 0
    GROUP BY countries.country
    ORDER BY gold_medals DESC
    LIMIT 5
)
SELECT *
FROM top_gold_winter;
----Query the CTE to select countries and their medal counts where gold medals won are ≥ 5.
WITH top_gold_winter AS (
    SELECT countries.country,
           SUM(winter_games.gold) AS gold_medals
    FROM countries
    JOIN winter_games
      ON countries.id = winter_games.country_id
    GROUP BY countries.country
)
SELECT country,
       gold_medals
FROM top_gold_winter
WHERE gold_medals >= 5;

----Tall Athletes
----Write a CTE called tall_athletes to find athletes taller than the average height for athletes in the database.
WITH tall_athletes AS (
    SELECT athletes.name,
           athletes.height
    FROM athletes
    WHERE athletes.height >
          (SELECT AVG(height) FROM athletes)
)
SELECT *
FROM tall_athletes;

----Query the CTE to return only female athletes over age 30 who meet the criteria.
WITH tall_athletes AS (
    SELECT athletes.name,
           athletes.height,
           athletes.age,
           athletes.gender
    FROM athletes
    WHERE athletes.height >
          (SELECT AVG(height) FROM athletes)
)
SELECT name,
       height,
       age
FROM tall_athletes
WHERE gender = 'F'
  AND age > 30;
----Average Weight of Female Athletes. 
----Write a CTE called tall_over30_female_athletes for the results of Exercise
WITH tall_over30_female_athletes AS (
    SELECT athletes.name,
           athletes.height,
           athletes.weight,
           athletes.age,
           athletes.gender
    FROM athletes
    WHERE athletes.height >
          (SELECT AVG(height) FROM athletes)
      AND athletes.gender = 'F'
      AND athletes.age > 30
)
SELECT *
FROM tall_over30_female_athletes;

----2.Query the CTE to find the average weight of these athletes.
WITH tall_over30_female_athletes AS (
    SELECT athletes.weight
    FROM athletes
    WHERE athletes.height >
          (SELECT AVG(height) FROM athletes)
      AND athletes.gender = 'F'
      AND athletes.age > 30
)
SELECT AVG(weight) AS average_weight
FROM tall_over30_female_athletes;