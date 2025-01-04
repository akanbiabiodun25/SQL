USE tfl;

CREATE TABLE tfl_journeys_final (
    MONTH INT,
    YEAR INT,
    JOURNEY_TYPE VARCHAR(50),
    JOURNEYS_MILLIONS FLOAT,
    DAYS INT
);
-- Emirates Airline Popularity (Top 5 Results)
SELECT 
    MONTH,
    YEAR,
    ROUND(JOURNEYS_MILLIONS, 2) AS ROUNDED_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
WHERE 
    JOURNEY_TYPE = 'Emirates Airline' -- Filter for Emirates Airline
    AND JOURNEYS_MILLIONS IS NOT NULL -- Exclude NULL values
ORDER BY 
    ROUNDED_JOURNEYS_MILLIONS DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY; -- Fetch Top 5


-- Least Popular Years for Underground & DLR (Bottom 5 Results)
SELECT 
    YEAR,
    JOURNEY_TYPE,
    ROUND(SUM(JOURNEYS_MILLIONS), 2) AS TOTAL_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
WHERE 
    JOURNEY_TYPE = 'Underground & DLR' -- Filter for Underground & DLR
GROUP BY 
    YEAR, JOURNEY_TYPE
ORDER BY 
    TOTAL_JOURNEYS_MILLIONS ASC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY; -- Fetch Bottom 5

-- Monthly Trends in Transport Usage
SELECT 
    MONTH,
    ROUND(SUM(JOURNEYS_MILLIONS), 2) AS TOTAL_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
GROUP BY 
    MONTH
ORDER BY 
    TOTAL_JOURNEYS_MILLIONS DESC;

-- Monthly Trends in Transport Usage
	SELECT 
    MONTH,
    ROUND(SUM(JOURNEYS_MILLIONS), 2) AS TOTAL_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
GROUP BY 
    MONTH
ORDER BY 
    TOTAL_JOURNEYS_MILLIONS DESC;

-- Yearly Growth Trends in Total Journeys
	SELECT 
    YEAR,
    ROUND(SUM(JOURNEYS_MILLIONS), 2) AS TOTAL_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
GROUP BY 
    YEAR
ORDER BY 
    YEAR ASC;


	--Peak Transport Types by Year
	SELECT 
    YEAR,
    JOURNEY_TYPE,
    ROUND(SUM(JOURNEYS_MILLIONS), 2) AS TOTAL_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
GROUP BY 
    YEAR, JOURNEY_TYPE
ORDER BY 
    YEAR ASC, TOTAL_JOURNEYS_MILLIONS DESC;


-- Performance of Emirates Airline Over Time
	SELECT 
    YEAR,
    ROUND(SUM(JOURNEYS_MILLIONS), 2) AS TOTAL_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
WHERE 
    JOURNEY_TYPE = 'Emirates Airline'
GROUP BY 
    YEAR
ORDER BY 
    YEAR ASC;


-- Impact of Days in a Month on Journey Volume
	SELECT 
    DAYS,
    ROUND(SUM(JOURNEYS_MILLIONS), 2) AS TOTAL_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
GROUP BY 
    DAYS
ORDER BY 
    TOTAL_JOURNEYS_MILLIONS DESC;

-- Trend Analysis - Monthly Trends
SELECT 
    YEAR,
    MONTH,
    ROUND(SUM(JOURNEYS_MILLIONS), 2) AS TOTAL_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
GROUP BY 
    YEAR, MONTH
ORDER BY 
    YEAR ASC, MONTH ASC;

-- Annual Growth Rate
	SELECT 
    YEAR,
    ROUND(SUM(JOURNEYS_MILLIONS), 2) AS TOTAL_JOURNEYS_MILLIONS,
    LAG(ROUND(SUM(JOURNEYS_MILLIONS), 2), 1) OVER (ORDER BY YEAR) AS PREVIOUS_YEAR,
    ROUND((SUM(JOURNEYS_MILLIONS) - LAG(SUM(JOURNEYS_MILLIONS), 1) OVER (ORDER BY YEAR)) / 
          LAG(SUM(JOURNEYS_MILLIONS), 1) OVER (ORDER BY YEAR) * 100, 2) AS GROWTH_PERCENTAGE
FROM 
    tfl_journeys_final
GROUP BY 
    YEAR
ORDER BY 
    YEAR ASC;

	-- Average Monthly Journeys
	SELECT 
    JOURNEY_TYPE,
    ROUND(AVG(JOURNEYS_MILLIONS), 2) AS AVG_JOURNEYS_MILLIONS
FROM 
    tfl_journeys_final
GROUP BY 
    JOURNEY_TYPE
ORDER BY 
    AVG_JOURNEYS_MILLIONS DESC;

	-- Revenue Projection (Assuming $2 per journey)

	SELECT 
    YEAR,
    ROUND(SUM(JOURNEYS_MILLIONS) * 2, 2) AS PROJECTED_REVENUE_MILLIONS
FROM 
    tfl_journeys_final
GROUP BY 
    YEAR
ORDER BY 
    YEAR ASC;









