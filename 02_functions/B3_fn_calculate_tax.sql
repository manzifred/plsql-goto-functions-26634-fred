-- Manzi Fred | 26634
-- B3: function that calculates monthly income tax using Rwanda PAYE brackets
-- 0 - 30,000 = 0% | 30,001 - 100,000 = 20% | above 100,000 = 30%

CREATE OR REPLACE FUNCTION fn_calculate_tax (
    p_monthly_salary IN NUMBER
)
RETURN NUMBER
IS
    v_tax NUMBER := 0;
BEGIN
    IF p_monthly_salary IS NULL THEN
        RAISE_APPLICATION_ERROR(-20020, 'Salary cannot be NULL.');
    END IF;
    IF p_monthly_salary < 0 THEN
        RAISE_APPLICATION_ERROR(-20021, 'Salary cannot be negative.');
    END IF;

    IF p_monthly_salary <= 30000 THEN
        v_tax := 0;
    ELSIF p_monthly_salary <= 100000 THEN
        v_tax := (p_monthly_salary - 30000) * 0.20;
    ELSE
        v_tax := (70000 * 0.20) + ((p_monthly_salary - 100000) * 0.30);
    END IF;

    RETURN ROUND(v_tax, 2);
EXCEPTION
    WHEN OTHERS THEN RAISE;
END fn_calculate_tax;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Tax on  30,000 : ' || fn_calculate_tax(30000));
    DBMS_OUTPUT.PUT_LINE('Tax on  80,000 : ' || fn_calculate_tax(80000));
    DBMS_OUTPUT.PUT_LINE('Tax on 420,000 : ' || fn_calculate_tax(420000));
    DBMS_OUTPUT.PUT_LINE('Tax on 850,000 : ' || fn_calculate_tax(850000));
END;
/
