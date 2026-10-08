-- Manzi Fred | 26634
-- A3: show an illegal GOTO, explain the error, then show the fix

-- ILLEGAL VERSION (commented out - does not compile)
-- The GOTO tries to jump inside an IF block which is not allowed.
-- PL/SQL raises PLS-00375 because the label is inside a nested structure.
--
-- DECLARE
--     v_x NUMBER := 10;
-- BEGIN
--     GOTO inside_if;
--     IF v_x > 5 THEN
--         <<inside_if>>
--         DBMS_OUTPUT.PUT_LINE('inside IF');
--     END IF;
-- END;
-- /
-- ERROR: PLS-00375 illegal GOTO statement; cannot branch to label INSIDE_IF
-- The fix is to move the label outside the IF block to the same level as GOTO.

-- FIXED VERSION
SET SERVEROUTPUT ON;

DECLARE
    v_x NUMBER := 10;
BEGIN
    IF v_x > 100 THEN
        GOTO skip_processing;
    END IF;

    DBMS_OUTPUT.PUT_LINE('v_x = ' || v_x || ', so normal processing runs.');
    GOTO end_label;

    <<skip_processing>>
    DBMS_OUTPUT.PUT_LINE('Skipped because v_x was greater than 100.');

    <<end_label>>
    DBMS_OUTPUT.PUT_LINE('Program ended.');
END;
/
