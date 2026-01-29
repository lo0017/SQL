SELECT 
    county, 
    population,
    CASE 
        WHEN population >= 500000 THEN 'high population'
        WHEN population > 100000  THEN 'medium population'
        ELSE 'low population'
    END AS pop_category
FROM population
WHERE year = 2017;

SELECT
    company,
    landed,
    new_jobs,
    CASE
        WHEN new_jobs < 50
            THEN 'Small Startup'
        WHEN new_jobs BETWEEN 50 AND 100
            THEN 'Midsize Startup'
        WHEN new_jobs > 100
            THEN 'Large Startup'
        ELSE NULL
    END AS startup_size
FROM ecd;

SELECT 
    SUM(CASE WHEN year = 2010 THEN population ELSE 0 END) AS Total_Pop_2010,
    SUM(CASE WHEN year = 2017 THEN population ELSE 0 END) AS Total_Pop_2017
FROM population;