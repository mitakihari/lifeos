---
description: Sunday weekly review. Score every area, clear the inbox, plan next week.
---
Run the LifeOS weekly review.

1. Run these commands:
   - `python3 _system/bin/lifeos.py new weekly`
   - `python3 _system/bin/lifeos.py lint`
   - `python3 _system/bin/lifeos.py finance check`
   - `python3 _system/bin/lifeos.py finance report`
2. Read this week's daily notes, every area hub, all `status: active` projects, open applications, and live listings.
3. **Inbox:** file every note in `00 Inbox/` (see `/capture` for where things go). Ask only about items you truly can't place.
4. **Money:** list uncategorized transactions with your suggested category and fix the obvious ones. Compare spend to budget for the month so far.
5. **Fill in the weekly note:**
   - Scorecard: on track / at risk / off track, each with a one-line reason grounded in the notes.
   - Wins.
   - What slipped. Be honest; this is where accountability happens.
   - "Must happen" next week, with dates.
6. **Apply these checks:**
   - Any project with no next action gets one, or is flagged.
   - Any application with `applied` older than 7 days and no reply gets a follow-up task.
   - Any course whose syllabus isn't entered gets flagged.
7. Reply with the scorecard table plus the top 3 for next week. Call out anything that's been slipping two weeks in a row.
8. Add a line to `_system/Changelog.md`.
