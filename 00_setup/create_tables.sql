-- Manzi Fred | 26634
-- Create and populate tables for the assignment

BEGIN EXECUTE IMMEDIATE 'DROP TABLE emp_payroll CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE departments (
    dept_id     NUMBER(4)    PRIMARY KEY,
    dept_name   VARCHAR2(50) NOT NULL
);

CREATE TABLE employees (
    emp_id         NUMBER(6)    PRIMARY KEY,
    first_name     VARCHAR2(30) NOT NULL,
    last_name      VARCHAR2(30) NOT NULL,
    hire_date      DATE         NOT NULL,
    monthly_salary NUMBER(10,2) NOT NULL,
    dept_id        NUMBER(4)    REFERENCES departments(dept_id)
);

CREATE TABLE emp_payroll (
    payroll_id   NUMBER(8)    PRIMARY KEY,
    emp_id       NUMBER(6)    REFERENCES employees(emp_id),
    pay_month    VARCHAR2(7),
    gross_salary NUMBER(10,2),
    tax_amount   NUMBER(10,2),
    net_salary   NUMBER(10,2),
    is_valid     CHAR(1) DEFAULT 'N'
);

INSERT INTO departments VALUES (10, 'Human Resources');
INSERT INTO departments VALUES (20, 'Information Technology');
INSERT INTO departments VALUES (30, 'Finance');
INSERT INTO departments VALUES (40, 'Marketing');
INSERT INTO departments VALUES (50, 'Operations');

INSERT INTO employees VALUES (1001, 'Alice',  'Uwimana',    DATE '2018-03-15', 850000,  20);
INSERT INTO employees VALUES (1002, 'Bob',    'Nkurunziza', DATE '2021-07-01', 420000,  10);
INSERT INTO employees VALUES (1003, 'Clara',  'Ingabire',   DATE '2015-11-20', 1200000, 30);
INSERT INTO employees VALUES (1004, 'David',  'Habimana',   DATE '2023-01-10', 300000,  40);
INSERT INTO employees VALUES (1005, 'Eve',    'Mukamana',   DATE '2019-06-05', 650000,  50);
INSERT INTO employees VALUES (1006, 'Frank',  'Bizimana',   DATE '2020-09-22', 950000,  20);
INSERT INTO employees VALUES (1007, 'Grace',  'Nyiransaba', DATE '2022-04-18', 380000,  10);

INSERT INTO emp_payroll VALUES (1, 1001, '2026-09', 850000,  NULL, NULL, 'N');
INSERT INTO emp_payroll VALUES (2, 1002, '2026-09', 420000,  NULL, NULL, 'N');
INSERT INTO emp_payroll VALUES (3, 1003, '2026-09', 1200000, NULL, NULL, 'N');
INSERT INTO emp_payroll VALUES (4, 1004, '2026-09', 300000,  NULL, NULL, 'N');
INSERT INTO emp_payroll VALUES (5, 1005, '2026-09', 650000,  NULL, NULL, 'N');
INSERT INTO emp_payroll VALUES (6, 1006, '2026-09', -500,    NULL, NULL, 'N');
INSERT INTO emp_payroll VALUES (7, 1007, '2026-09', NULL,    NULL, NULL, 'N');

COMMIT;
PROMPT Done.
