-- Manzi Fred | 26634
-- unit tests for B1 to B4

SET SERVEROUTPUT ON;

DECLARE
    v_result NUMBER;
    v_pass   NUMBER := 0;
    v_fail   NUMBER := 0;

    PROCEDURE check_num(p_label VARCHAR2, p_expected NUMBER, p_actual NUMBER) IS
    BEGIN
        IF p_expected = p_actual THEN
            DBMS_OUTPUT.PUT_LINE('PASS: ' || p_label);
            v_pass := v_pass + 1;
        ELSE
            DBMS_OUTPUT.PUT_LINE('FAIL: ' || p_label || ' expected ' || p_expected || ' got ' || p_actual);
            v_fail := v_fail + 1;
        END IF;
    END;

    PROCEDURE check_str(p_label VARCHAR2, p_expected VARCHAR2, p_actual VARCHAR2) IS
    BEGIN
        IF p_expected = p_actual THEN
            DBMS_OUTPUT.PUT_LINE('PASS: ' || p_label);
            v_pass := v_pass + 1;
        ELSE
            DBMS_OUTPUT.PUT_LINE('FAIL: ' || p_label || ' expected [' || p_expected || '] got [' || p_actual || ']');
            v_fail := v_fail + 1;
        END IF;
    END;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- fn_annual_salary ---');
    check_num('500000 x 12', 6000000,  fn_annual_salary(500000));
    check_num('0 x 12',      0,         fn_annual_salary(0));
    check_num('1200000 x 12',14400000,  fn_annual_salary(1200000));

    BEGIN
        v_result := fn_annual_salary(NULL);
        DBMS_OUTPUT.PUT_LINE('FAIL: NULL should raise error'); v_fail := v_fail + 1;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('PASS: NULL raises error'); v_pass := v_pass + 1;
    END;

    DBMS_OUTPUT.PUT_LINE('--- fn_years_of_service ---');
    check_num('8 years', 8, fn_years_of_service(ADD_MONTHS(SYSDATE, -96)));
    check_num('2 years', 2, fn_years_of_service(ADD_MONTHS(SYSDATE, -24)));

    BEGIN
        v_result := fn_years_of_service(SYSDATE + 10);
        DBMS_OUTPUT.PUT_LINE('FAIL: future date should raise error'); v_fail := v_fail + 1;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('PASS: future date raises error'); v_pass := v_pass + 1;
    END;

    DBMS_OUTPUT.PUT_LINE('--- fn_calculate_tax ---');
    check_num('tax on 30000',  0,      fn_calculate_tax(30000));
    check_num('tax on 80000',  10000,  fn_calculate_tax(80000));
    check_num('tax on 100000', 14000,  fn_calculate_tax(100000));
    check_num('tax on 420000', 110000, fn_calculate_tax(420000));

    DBMS_OUTPUT.PUT_LINE('--- fn_dept_name ---');
    check_str('dept 10', 'Human Resources',        fn_dept_name(10));
    check_str('dept 20', 'Information Technology', fn_dept_name(20));
    check_str('dept 30', 'Finance',                fn_dept_name(30));
    check_str('dept 99', 'Unknown Department',      fn_dept_name(99));

    DBMS_OUTPUT.PUT_LINE('Results: ' || v_pass || ' passed, ' || v_fail || ' failed.');
END;
/
