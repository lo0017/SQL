----Find which county had the most months with unemployment rates above the state average: 
SELECT * FROM ecd;
SELECT * FROM population;
SELECT * FROM unemployment;--------------------------

----Write a query to calculate the state average unemployment rate. 
SELECT AVG(value) FROM unemployment;

----Use Select to count the number of months each county was above the average. Which country had the most?
SELECT 
    county,
    COUNT(period) AS total_months
FROM unemployment
WHERE value > (SELECT AVG(value) FROM unemployment)
GROUP BY county
ORDER BY total_months DESC;

----Find the average number AVG() of jobs (ecd) created for each county (GROUP BY count maybe) based on projects involving the (ONLY) largest capital investment by each company: 

----Write a query to find each company’s largest capital investment, returning the company name along with the relevant capital investment amount for each.
SELECT 
    company,
    MAX(capital_investment) AS max_capital_investment
FROM ecd
GROUP BY company;

----Use this query in the FROM clause of an outer query, alias it, and join it with the original table.
SELECT
	*
FROM (SELECT
 company,
 MAX(capital_investment) AS max_capital_investment
 FROM ecd
 GROUP BY company) AS max_capital_investment
INNER JOIN ecd ON (max_capital_investment.company = ecd.company) AND (max_capital_investment.company_max_invest = ecd.capital_investment);

----Use Select * in the outer query to make sure your join worked properly.
SELECT
    *
FROM (
    SELECT
        company,
        MAX(capital_investment) AS max_capital_investment
    FROM ecd
    GROUP BY company
) AS max_capital_investment
INNER JOIN ecd
  ON max_capital_investment.company = ecd.company
 AND max_capital_investment.max_capital_investment = ecd.capital_investment;

   
----Adjust the SELECT clause to calculate the average number of jobs created by county.
SELECT 
    county,
    AVG(new_jobs) AS avg_jobs_created
FROM ecd
JOIN (
    SELECT 
        company,
        MAX(capital_investment) AS max_capital_investment
    FROM ecd
    GROUP BY company
) AS largest_investment
ON ecd.company = largest_investment.company
   AND ecd.capital_investment = largest_investment.max_capital_investment
GROUP BY county
ORDER BY avg_jobs_created DESC;