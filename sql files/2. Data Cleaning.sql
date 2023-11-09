-- **DATA CLEANING**

-- AS seen after first check, ï»¿id column needs to rename
ALTER TABLE hr_data
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

-- to update table safely (0,1)
SET sql_safe_updates = 0; 
-- SET sql_safe_updates = 1;

-- birthdate column needs to convert in a same format
UPDATE hr_data
SET birthdate = (CASE 
    WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END);

-- Modify birthdate column text to date type
ALTER TABLE hr_data
MODIFY COLUMN birthdate DATE;

-- hire_date column needs to convert in a same format
UPDATE hr_data
SET hire_date = (CASE 
    WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END);

-- Modify hire_date column text to date type
ALTER TABLE hr_data
MODIFY COLUMN hire_date DATE;

-- Rename termdate to term_date
ALTER TABLE hr_data
CHANGE COLUMN hire_date hiredate VARCHAR(20) NULL;

-- Missing value amounts: termdate=18.285, 
SELECT COUNT(*) 
FROM hr_data 
WHERE 
	termdate IS NULL OR
	termdate = ' ' OR 
    termdate = '';
    
-- Missing values filled as 0000-00-00
-- Convert type of termdate text to date
-- Modify termdate column text to date type

-- Add new column to replace with current
ALTER TABLE hr_data
ADD COLUMN new_termdate DATE;

-- Update the new column with the converted date values
UPDATE hr_data
SET new_termdate = STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')
WHERE termdate IS NOT NULL AND termdate <> '';

-- Remove former column
ALTER TABLE hr_data
DROP COLUMN termdate;

-- Replace new to former
ALTER TABLE hr_data
CHANGE COLUMN new_termdate termdate DATE;

-- AGE COLUMN
-- Add an column which is age
ALTER TABLE hr_data
ADD COLUMN age INT;

-- Set age values
UPDATE hr_data
SET age = timestampdiff(YEAR, birthdate, CURDATE());

-- Remove rows where less than zero and over 100 years
DELETE FROM hr_data
WHERE age < 0 OR age > 100;