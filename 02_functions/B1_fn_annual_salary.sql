-- Manzi Fred | 26634
-- B1: function that returns annual salary from monthly salary

CREATE OR REPLACE FUNCTION fn_annual_salary (
    p_monthly_salary IN NUMBER
)
RETURN NUMBER
IS
    v_annual NUMBER;
BEGIN
    IF p_monthly_salary IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Monthly salary cannot be NULL.');
    END IF;
    IF p_monthly_salary < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Monthly salary cannot be negative.');
    END IF;

    v_annual := p_monthly_salary * 12;
    RETURN v_annual;
EXCEPTION
    WHEN OTHERS THEN RAISE;
END fn_annual_salary;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Annual for 500,000: '   || TO_CHAR(fn_annual_salary(500000),  '999,999,999'));
    DBMS_OUTPUT.PUT_LINE('Annual for 1,200,000: ' || TO_CHAR(fn_annual_salary(1200000), '999,999,999'));
END;
/
