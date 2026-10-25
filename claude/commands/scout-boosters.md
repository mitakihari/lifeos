---
description: Resume booster scout. Find cheap, fast certifications, courses and volunteer roles that strengthen the resume for the job goals.
---
LifeOS booster scout. It finds and files; it never applies, contacts, signs up, or pays.

## 0. Read the criteria first
- [[Career]]: the "Right now" section and the target roles table.
- [[Land an accounting job]]: urgency and the two tracks (bridge job + finance/business).
- [[Housing]]: who's moving, budget, must-haves, location rules.
- [[Work]], [[School]], and the course notes: when the user is free to work. Class times rule out some shifts.
- [[Resume - Master]] and `30 Resources/Resume Boosters.md` (if it exists): what's already there.
- Existing notes in `20 Areas/Career/Applications/` and `20 Areas/Housing/Listings/`. **Never file a duplicate.** Match on link, or company + role, or address.

## Search
Keep `30 Resources/Resume Boosters.md` (type: resource) as one table:

| Booster | What it is | Cost | Time | Why it helps *my* goals | Status | Link |

Look for certifications, licenses, free courses, and volunteer roles that an entry-level finance/accounting candidate in the user's state can get cheaply and quickly. Examples to check: notary public (state requirements and fee), IRS VITA volunteer tax preparer, Microsoft Office Specialist (Excel), QuickBooks/Intuit certifications, tax-prep company training courses, free bank-teller or customer-service certificates, and typing/data-entry tests. Also check anything school-based (CMCC tutoring, clubs, work-study).

- Verify cost, requirements, and dates from official sources. Don't guess. Write TBD if you can't confirm.
- Rank by value to the job goals divided by cost and time.
- Add at most the top 1–2 *new* ones as tasks in [[Land an accounting job]].
- Mark existing rows `stale` if their info changed.
- Status values: `idea`, `doing`, `done`, `skip`.

## Wrap up
1. Append to `00 Inbox/Scout <YYYY-MM-DD>.md` (type: note; create it if missing) a `## Booster` section with the best new or changed booster and why, plus counts (new / duplicate / skipped).
2. Run `python3 _system/bin/lifeos.py lint` and fix dead links or missing types you caused.
3. Add a line to `_system/Changelog.md`.
4. `git pull --rebase`, commit "scout-boosters: <date>", and push.
5. Reply in under 8 lines.

## Never
- invent pay, rent, requirements, costs or dates;
- file anything you couldn't open and confirm is current;
- apply, message, sign up, pay, or contact anyone (the user does all of that);
- put the user's personal details anywhere outside the vault.
