---
description: Start the day. Create today's note, surface what's due, set the top 3.
argument-hint: "[anything on your mind today]"
---
Run the daily kickoff for LifeOS.

1. Run `python3 _system/bin/lifeos.py new daily` and `python3 _system/bin/lifeos.py lint --json`.
2. Read `01 Home.md`, today's daily note, yesterday's daily note (if it exists), and the hub note for any area with overdue items.
3. In today's note, fill **Top 3 today** with the three things that matter most. Weigh them in this order:
   1. Overdue or due-today school work.
   2. Money tasks with deadlines (bills, payments).
   3. Job application next steps that are due.
   4. Project next actions.
   Carry over anything unfinished from yesterday's "What's carrying over".
4. If the user added context ($ARGUMENTS), work it in: log it, create tasks with 📅 dates, or adjust the top 3.
5. Reply in under 12 lines:
   - the top 3,
   - anything overdue, named plainly (don't soften it),
   - one money line: days until the next bill, or "nothing due".

   Don't recap the whole vault.
6. Add a line to `_system/Changelog.md`.
