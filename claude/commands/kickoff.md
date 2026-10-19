---
description: First session. Interview the user and fill the vault with their real goals, numbers, and deadlines.
---
Run the LifeOS kickoff interview. The goal is to replace every `TBD` in the vault with real information, so the system can hold the user accountable.

Rules:
- Ask in rounds of 3–5 questions at a time, grouped by area. Don't dump 40 questions at once.
- After each round, write the answers into the notes right away, then move to the next round.
- Accept "skip" and leave TBD. Never invent an answer.
- Money: ask for balances and amounts only. Never ask for account numbers.

Rounds:
1. **Snapshot:** What's going well, what's stressing them out most right now, and what "on track" looks like 6 and 12 months from now.
2. **Work:** Employer, role, schedule, pay rate, tips, and pay frequency. Write it to [[Work]].
3. **Money:**
   - Accounts they have (bank, savings, cards), by name only. Open matching accounts in `finance/accounts.beancount`.
   - Current balances. These go into `finance/opening.beancount` as of today.
   - Recurring bills and amounts, including subscriptions.
   - Credit situation.
   - Savings targets.
   - Write everything to [[Money]] and set starting numbers in `finance/budget.toml`. Base the budget on what they say they spend, then propose adjustments.
4. **School:** Current term courses, credits, and instructors. Run `new course` for each. Then the degree and transfer plan, key deadlines, and any syllabi they can paste.
5. **Career:** Target roles (now and long-term), resume content for [[Resume - Master]], and any applications already in flight.
6. **Housing:** Target move date, towns, must-haves, max rent they'd feel OK with, and move-in fund so far. Fill in [[Housing]] and calculate the affordability table.
7. **Life:** Habits they want, health or admin things they keep forgetting, important dates.
8. **Projects:**
   - Turn the big goals into project notes with `new project`. Each needs a "done looks like", a due date, and 2–3 next actions.
   - Typical ones: graduate, transfer, get an apartment, land a job, build credit, build an emergency fund.

Finish:
1. Run `finance check`, `finance report`, and `lint`.
2. Show a one-screen summary: the projects with due dates, this month's budget, and the top 3 for this week.
3. Add a line to `_system/Changelog.md`.
