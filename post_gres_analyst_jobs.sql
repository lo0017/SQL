SELECT COUNT(DISTINCT county) AS total_counties
FROM ecd;

SELECT COUNT(DISTINCT company) AS total_companies
FROM ecd;

SELECT COUNT(DISTINCT company)
FROM ecd
WHERE company NOT IN (
    SELECT company 
    FROM ecd 
    WHERE ed > '$0.00'  -- Use a money literal instead of an integer
);

SELECT SUM(capital_investment::numeric) / 1000000.0 AS fjtap_cap_invest_mil
FROM ecd
WHERE fjtap > '$0.00';
SELECT 
    county_tier, 
    AVG(new_jobs) AS avg_new_jobs
FROM ecd
GROUP BY county_tier;
SELECT COUNT(DISTINCT company) AS llc_companies
FROM ecd
WHERE company ILIKE '%LLC%';