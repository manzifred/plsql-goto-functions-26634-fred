-- Manzi Fred | 26634
-- B4: function that returns the department name for a given dept_id
-- returns 'Unknown Department' if the id does not exist

CREATE OR REPLACE FUNCTION fn_dept_name (
    p_dept_id IN departments.dept_id%TYPE
)
RETURN VARCHAR2
IS
    v_dept_name departments.dept_name%TYPE;
BEGIN
    IF p_dept_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20030, 'Department ID cannot be NULL.');
    END IF;

    SELECT dept_name INTO v_dept_name
    FROM   departments
    WHERE  dept_id = p_dept_id;

    RETURN v_dept_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 'Unknown Department';
    WHEN OTHERS THEN RAISE;
END fn_dept_name;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Dept 10 : ' || fn_dept_name(10));
    DBMS_OUTPUT.PUT_LINE('Dept 20 : ' || fn_dept_name(20));
    DBMS_OUTPUT.PUT_LINE('Dept 99 : ' || fn_dept_name(99));
END;
/
