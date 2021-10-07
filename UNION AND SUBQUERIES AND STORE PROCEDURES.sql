USE employees;
DROP TABLE IF EXISTS emp_Manager;
CREATE TABLE emp_Manager (emp_no INT(11) NOT NULL, dept_no CHAR(4) NULL, Manager_no INT(11) NOT NULL);


INSERT INTO emp_Manager SELECT U.* FROM (SELECT A.* FROM (SELECT 
    e.emp_no AS employee_ID,
    MIN(de.dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110022) AS manager_ID
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no <= 10020
GROUP BY e.emp_no
ORDER BY e.emp_no) AS A
UNION SELECT B.* FROM
(SELECT 
    e.emp_no AS employee_ID,
    MIN(de.dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110039) AS manager_ID
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no > 10020
GROUP BY e.emp_no
ORDER BY e.emp_no LIMIT 20) AS B
UNION SELECT C.* FROM
(SELECT 
    e.emp_no AS employee_ID,
    MIN(de.dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110039) AS manager_ID
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no = 110022
GROUP BY e.emp_no
ORDER BY e.emp_no LIMIT 20) AS C
UNION SELECT D.* FROM
(SELECT 
    e.emp_no AS employee_ID,
    MIN(de.dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110022) AS manager_ID
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no = 110039
GROUP BY e.emp_no
ORDER BY e.emp_no) AS D) AS U;

SELECT 
    *
FROM
    emp_manager
ORDER BY emp_manager.emp_no;

SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no; 
    
SELECT 
    *
FROM
    emp_manager
ORDER BY emp_manager.emp_no;

SELECT 
    e1.emp_no, e1.dept_no, e2.manager_no
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no; 
    
SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no; 
    
SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);
            
SELECT manager_no FROM emp_manager;

SELECT * FROM dept_emp;
SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS num
FROM
    dept_emp
GROUP BY emp_no
HAVING Num > 1;

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
SELECT 
    emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
    dept_emp
GROUP BY emp_no;

USE employees;
CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;
        
SELECT * FROM v_manager_avg_salary;



        
