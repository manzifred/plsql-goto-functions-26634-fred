-- run_all.sql
-- Runs all assignment scripts in the correct order.
-- Use this only if you want everything to run at once.
-- For screenshots, run each file individually instead.
-- Student: Manzi Fred | ID: 26634
--
-- HOW TO USE in SQL Developer worksheet:
-- @"C:\Users\fredm\OneDrive\Desktop\projects\PL&SQL\assignment 3\plsql-goto-functions-26634-fred\run_all.sql"

DEFINE base = "C:\Users\fredm\OneDrive\Desktop\projects\PL&SQL\assignment 3\plsql-goto-functions-26634-fred"

PROMPT -- Step 1: Create tables
@"&base\00_setup\create_tables.sql"

PROMPT -- Step 2: Create functions
@"&base\02_functions\B1_fn_annual_salary.sql"
@"&base\02_functions\B2_fn_years_of_service.sql"
@"&base\02_functions\B3_fn_calculate_tax.sql"
@"&base\02_functions\B4_fn_dept_name.sql"
@"&base\02_functions\C1_fn_validate_payroll.sql"

PROMPT -- Step 3: GOTO programs (A1 and A4 skipped - they need user input, run them separately)
@"&base\01_goto\A2_salary_review.sql"
@"&base\01_goto\A3_illegal_goto.sql"

PROMPT -- Step 4: Tests
@"&base\03_tests\B5_functions_in_select.sql"
@"&base\03_tests\test_functions.sql"
@"&base\03_tests\test_validate_payroll.sql"

PROMPT -- Done. Run A1 and A4 separately when ready.
