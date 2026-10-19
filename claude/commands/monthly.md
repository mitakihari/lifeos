---
description: First-of-the-month review. Close the books, check budget and goals, adjust the plan.
argument-hint: "[YYYY-MM, default last month]"
---
Run the LifeOS monthly review for $ARGUMENTS (default: the month that just ended).

1. **Close the books.**
   1. Make sure last month's bank and card exports have been imported. If they haven't, ask for them, and tell the user to drop the CSVs in `finance/imports/raw/`.
   2. Clear every `!` (uncategorized) transaction.
   3. Run `finance check`, then `finance report`.
   4. If the user gives you real ending balances, add `balance` assertions (see the `lifeos-finance` skill).
2. Run `python3 _system/bin/lifeos.py new monthly --date <first day of that month>`, then fill it in from the ledger report, the course notes, applications, listings, and projects.
3. **Budget check:** for every category more than 10% over budget, say so plainly. Propose either a concrete fix or a budget change, and let the user decide. Record the decision.
4. **Goal check:** for each target in [[Money]] and [[Housing]], work out progress, the monthly pace needed, and whether they're on pace. Show the math in one line each.
5. **Project check:**
   - Archive projects that are done or dropped by moving them to `40 Archive/`.
   - Flag projects that haven't moved in 30 days.
6. Reply with a 5-line summary, then the decisions that need the user's input.
