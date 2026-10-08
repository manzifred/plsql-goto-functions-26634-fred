-- Manzi Fred | 26634
-- B5: use all four functions inside a SQL SELECT query

SET LINESIZE 130
COLUMN "Employee"          FORMAT A22
COLUMN "Department"        FORMAT A25
COLUMN "Monthly Salary"    FORMAT 999,999,999
COLUMN "Annual Salary"     FORMAT 999,999,999
COLUMN "Monthly Tax"       FORMAT 999,999,999
COLUMN "Years of Service"  FORMAT 99

SELECT
    e.first_name || ' ' || e.last_name  AS "Employee",
    fn_dept_name(e.dept_id)             AS "Department",
    e.monthly_salary                    AS "Monthly Salary",
    fn_annual_salary(e.monthly_salary)  AS "Annual Salary",
    fn_calculate_tax(e.monthly_salary)  AS "Monthly Tax",
    fn_years_of_service(e.hire_date)    AS "Years of Service"
FROM employees e
ORDER BY e.emp_id;
