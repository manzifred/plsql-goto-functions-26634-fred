-- Manzi Fred | 26634
-- test fn_validate_payroll with valid and invalid records

SET SERVEROUTPUT ON;

DECLARE
    v_result VARCHAR2(300);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 1 - valid record (Alice):');
    v_result := fn_validate_payroll(1);
    DBMS_OUTPUT.PUT_LINE(v_result);

    DBMS_OUTPUT.PUT_LINE('Test 2 - valid record (Clara):');
    v_result := fn_validate_payroll(3);
    DBMS_OUTPUT.PUT_LINE(v_result);

    DBMS_OUTPUT.PUT_LINE('Test 3 - negative salary:');
    v_result := fn_validate_payroll(6);
    DBMS_OUTPUT.PUT_LINE(v_result);

    DBMS_OUTPUT.PUT_LINE('Test 4 - NULL salary:');
    v_result := fn_validate_payroll(7);
    DBMS_OUTPUT.PUT_LINE(v_result);

    DBMS_OUTPUT.PUT_LINE('Test 5 - record does not exist:');
    v_result := fn_validate_payroll(999);
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

SELECT payroll_id, emp_id, gross_salary, tax_amount, net_salary, is_valid
FROM   emp_payroll
ORDER BY payroll_id;
