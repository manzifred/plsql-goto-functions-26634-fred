# Reflection
**Student:** Manzi Fred | **ID:** 26634  
**Course:** INSY 8311 — Database Development with PL/SQL  
**Date:** October 8, 2026

---

## Part A — GOTO

I started with A1 where I had to classify a number as positive, negative or zero using GOTO. The logic was straightforward but I noticed that even with just three branches the code already looked harder to follow than a normal IF statement. Execution jumps around instead of flowing from top to bottom.

A2 was more challenging because I used GOTO inside a cursor loop. I had to place a `NULL;` statement after the `<<next_employee>>` label because PL/SQL requires at least one executable statement after every label. Without it the code would not compile.

A3 was the most educational. I wrote an illegal GOTO that tried to jump into an IF block and got error PLS-00375. The rule I learned is that a GOTO can only jump to a label that is at the same level in the block, never into a nested structure like an IF, a loop, or a sub-block. After understanding that I moved the label outside the IF and it worked.

A4 showed me why GOTO is rarely used. Writing the same A1 logic with IF-ELSIF-ELSE was cleaner, shorter, and easier to read. The result was identical but the code was much better.

---

## Part B — Functions

Writing stored functions was new to me. The key things I learned are that a function must declare a return type, must use RETURN to send back a value, and can be called directly from a SQL SELECT statement unlike anonymous blocks.

The tax function in B3 took the most thought. Rwanda PAYE uses progressive brackets so I had to make sure I only taxed each portion of salary at the correct rate. For example, a salary of 420,000 gets 0% on the first 30,000, 20% on the next 70,000, and 30% only on the remaining 320,000.

B4 taught me to handle NO_DATA_FOUND gracefully. Instead of letting the function crash when a department ID does not exist, I catch the exception and return a default message. That is much better for real use.

B5 was satisfying because it showed that all four functions I wrote could be used together in a single SQL query to produce a full payroll report.

---

## Part C — Combined Task

The payroll validator brought everything together. It applies three validation rules in sequence, calls another function internally to calculate tax, then performs an UPDATE on the database. Building this made me realise that functions can do more than just return values — they can also contain business logic and update data.

The test results confirmed that valid records got their tax and net salary calculated correctly, and invalid records like the negative salary (-500) and the NULL salary were correctly rejected and marked as invalid.

---

## What I would do differently

I would test each function immediately after writing it rather than writing them all first. Finding a bug is easier when the code is fresh.

---

## AI Usage

I used Kiro as an AI assistant to help write and organise the SQL files in this assignment. I went through every file, ran each one myself in Oracle SQL Developer, checked the output, and made sure I understand the logic. I am able to explain any part of this code.
