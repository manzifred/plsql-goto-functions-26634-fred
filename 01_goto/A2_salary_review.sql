-- Manzi Fred | 26634
-- A2: loop through employees and use GOTO to assign salary categories
-- LOW < 400,000 | MEDIUM 400,000-799,999 | HIGH >= 800,000

SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_employees IS
        SELECT emp_id, first_name, last_name, monthly_salary
        FROM   employees
        ORDER BY emp_id;

    v_emp      c_employees%ROWTYPE;
    v_category VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('===== SALARY REVIEW REPORT =====');
    DBMS_OUTPUT.PUT_LINE(RPAD('Employee', 22) || RPAD('Salary', 15) || 'Category / Action');
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 65, '-'));

    OPEN c_employees;
    LOOP
        FETCH c_employees INTO v_emp;
        EXIT WHEN c_employees%NOTFOUND;

        IF v_emp.monthly_salary < 400000 THEN
            GOTO low_salary;
        ELSIF v_emp.monthly_salary < 800000 THEN
            GOTO medium_salary;
        ELSE
            GOTO high_salary;
        END IF;

        <<low_salary>>
        v_category := 'LOW';
        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_emp.first_name || ' ' || v_emp.last_name, 22) ||
            RPAD(TO_CHAR(v_emp.monthly_salary, '999,999,999'), 15) ||
            v_category || ' - Recommend salary increment.');
        GOTO next_employee;

        <<medium_salary>>
        v_category := 'MEDIUM';
        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_emp.first_name || ' ' || v_emp.last_name, 22) ||
            RPAD(TO_CHAR(v_emp.monthly_salary, '999,999,999'), 15) ||
            v_category || ' - Salary is acceptable.');
        GOTO next_employee;

        <<high_salary>>
        v_category := 'HIGH';
        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_emp.first_name || ' ' || v_emp.last_name, 22) ||
            RPAD(TO_CHAR(v_emp.monthly_salary, '999,999,999'), 15) ||
            v_category || ' - Consider adding a bonus.');

        <<next_employee>>
        NULL;
    END LOOP;
    CLOSE c_employees;

    DBMS_OUTPUT.PUT_LINE(RPAD('-', 65, '-'));
    DBMS_OUTPUT.PUT_LINE('Salary review complete.');
END;
/
