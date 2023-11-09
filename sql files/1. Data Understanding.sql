-- **DATA UNDERSTANDING**

-- Create a database which is called as hr_project
CREATE DATABASE hr_project;

-- Activate your database
USE hr_project;

-- First check to imported data
SELECT * FROM hr_data;

-- to check column size
SELECT COUNT(*) 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE table_schema = 'hr_project' -- the database 
AND table_name = 'hr_data';

-- to check row size
SELECT COUNT(*)
FROM hr_data;

-- to check type
DESCRIBE hr_data; 