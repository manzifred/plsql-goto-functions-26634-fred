-- Manzi Fred | 26634
-- B2: function that returns full years worked from hire date to today

CREATE OR REPLACE FUNCTION fn_years_of_service (
    p_hire_date IN DATE
)
RETURN NUMBER
IS
    v_years NUMBER;
BEGIN
    IF p_hire_date IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010, 'Hire date cannot be NULL.');
    END IF;
    IF p_hire_date > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20011, 'Hire date cannot be in the future.');
    END IF;

    v_years := FLOOR(MONTHS_BETWEEN(SYSDATE, p_hire_date) / 12);
    RETURN v_years;
EXCEPTION
    WHEN OTHERS THEN RAISE;
END fn_years_of_service;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Years (hired 2018-03-15): ' || fn_years_of_service(DATE '2018-03-15'));
    DBMS_OUTPUT.PUT_LINE('Years (hired 2023-01-10): ' || fn_years_of_service(DATE '2023-01-10'));
END;
/
