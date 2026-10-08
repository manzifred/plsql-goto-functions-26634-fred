-- Manzi Fred | 26634
-- C1: validates a payroll record, calculates tax and net salary, updates the table

CREATE OR REPLACE FUNCTION fn_validate_payroll (
    p_payroll_id IN emp_payroll.payroll_id%TYPE
)
RETURN VARCHAR2
IS
    v_record    emp_payroll%ROWTYPE;
    v_emp_count NUMBER;
    v_tax       NUMBER;
    v_net       NUMBER;
BEGIN
    BEGIN
        SELECT * INTO v_record FROM emp_payroll WHERE payroll_id = p_payroll_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR: Payroll ID ' || p_payroll_id || ' not found.';
    END;

    IF v_record.gross_salary IS NULL THEN
        UPDATE emp_payroll SET is_valid = 'N' WHERE payroll_id = p_payroll_id;
        COMMIT;
        RETURN 'INVALID: Payroll ID ' || p_payroll_id || ' has a NULL gross salary.';
    END IF;

    IF v_record.gross_salary <= 0 THEN
        UPDATE emp_payroll SET is_valid = 'N' WHERE payroll_id = p_payroll_id;
        COMMIT;
        RETURN 'INVALID: Payroll ID ' || p_payroll_id || ' salary must be greater than zero.';
    END IF;

    SELECT COUNT(*) INTO v_emp_count FROM employees WHERE emp_id = v_record.emp_id;
    IF v_emp_count = 0 THEN
        UPDATE emp_payroll SET is_valid = 'N' WHERE payroll_id = p_payroll_id;
        COMMIT;
        RETURN 'INVALID: Employee ID ' || v_record.emp_id || ' does not exist.';
    END IF;

    v_tax := fn_calculate_tax(v_record.gross_salary);
    v_net := v_record.gross_salary - v_tax;

    UPDATE emp_payroll
    SET tax_amount = v_tax, net_salary = v_net, is_valid = 'Y'
    WHERE payroll_id = p_payroll_id;
    COMMIT;

    RETURN 'VALID: ID ' || p_payroll_id ||
           ' | Gross: ' || TO_CHAR(v_record.gross_salary, '999,999,999') ||
           ' | Tax: '   || TO_CHAR(v_tax, '999,999,999') ||
           ' | Net: '   || TO_CHAR(v_net, '999,999,999');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RETURN 'ERROR: ' || SQLERRM;
END fn_validate_payroll;
/
PROMPT fn_validate_payroll created.
