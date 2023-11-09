-- **DATA ANALYSIS**
/*
1. What is the gender distribution of employees?
2. What is the race/ethnicity distribution of employees?
3. What is the age distribution of employees?
4. What is the department distribution of employees?
5. What is the distribution of job titles across the company?
6. What is the distribution of employees across locations by city?
7. How many employees work at headquarters versus remote locations?
8. What is the average year of employment for employees based on their department?
*/

-- 1
SELECT 
	gender,
    COUNT(*) AS number
FROM hr_data
GROUP BY gender
ORDER BY number DESC;

-- 2
SELECT
	race,
    COUNT(*) AS number
FROM hr_data
GROUP BY race
ORDER BY number DESC;

-- 3
SELECT
	CASE
		WHEN age >= 18 AND age <= 25 THEN '18-25'
        WHEN age >= 26 AND age <= 35 THEN '26-35'
        WHEN age >= 36 AND age <= 45 THEN '36-45'
        WHEN age >= 46 AND age <= 55 THEN '46-55'
        ELSE '55+'
	END AS distribution,
    COUNT(*)
FROM hr_data
GROUP BY distribution
ORDER BY distribution;

-- 4
SELECT 
	department,
    COUNT(*) AS number
FROM hr_data
GROUP BY department
ORDER BY number DESC;

-- 5
SELECT
	jobtitle,
    COUNT(*) AS number
FROM hr_data
GROUP BY jobtitle
ORDER BY number DESC
LIMIT 20;

-- 6
SELECT 
	location_city,
    COUNT(*) AS number
FROM hr_data
GROUP BY location_city
ORDER BY number DESC;

-- 7
SELECT 
	location,
    COUNT(*) AS number
FROM hr_data
GROUP BY location
ORDER BY number DESC;

-- 8
SELECT
	jobtitle,
	ROUND(AVG(YEAR(termdate) - YEAR(hiredate)), 1) AS 'AvgYearWork'
FROM hr_data
GROUP BY jobtitle
ORDER BY AvgYearWork DESC
LIMIT 10;   
