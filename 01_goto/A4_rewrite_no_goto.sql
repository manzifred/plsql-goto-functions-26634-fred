-- Manzi Fred | 26634
-- A4: same logic as A1 but rewritten without GOTO using IF-ELSIF-ELSE

SET SERVEROUTPUT ON;

DECLARE
    v_number   NUMBER := &enter_a_number;
    v_category VARCHAR2(10);
    v_message  VARCHAR2(100);
BEGIN
    IF v_number > 0 THEN
        v_category := 'POSITIVE';
        v_message  := 'The number ' || v_number || ' is POSITIVE.';
    ELSIF v_number < 0 THEN
        v_category := 'NEGATIVE';
        v_message  := 'The number ' || v_number || ' is NEGATIVE.';
    ELSE
        v_category := 'ZERO';
        v_message  := 'The number is ZERO.';
    END IF;

    DBMS_OUTPUT.PUT_LINE(v_message);
    DBMS_OUTPUT.PUT_LINE('Category: ' || v_category);
    DBMS_OUTPUT.PUT_LINE('Done.');
END;
/
