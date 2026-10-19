# Use cases

LifeOS is for one person getting their life organized and keeping it organized. It's built around five areas, each with a hub note, a standard for "on track", and Claude workflows.

## Money: "know where every dollar goes"

| Scenario | How |
|---|---|
| Set up my finances from scratch | `/kickoff` opens your accounts (by name), records starting balances, and sets a budget from what you actually spend |
| I downloaded my bank statement | Drop the CSV in `finance/imports/raw/`, then `/money`. It gets imported, auto-categorized, deduplicated, and reported |
| Paid cash or got tips | `/capture got $45 cash tips tonight` adds a ledger entry |
| Where did my money go this month? | `/money` gives category vs budget, and `Finance <year>.xlsx` has the details |
| Can I afford X? | `/money can I afford a $300 desk this month` answers from the ledger and budget, with the math shown |
| See the books visually | `lifeos.py finance fava` opens a dashboard with charts, balance sheet, and income statement |
| Hand an accountant (or a class) a spreadsheet | `Finance <year>.xlsx` has live formulas and is regenerated anytime |

## School: "pass everything, graduate on time"

| Scenario | How |
|---|---|
| New semester | `/class ACC 120 ...` creates a note per course, then paste each syllabus to turn every due date into a task |
| What's due this week? | `/today`, or the Home dashboard, which lists due items across all courses |
| Got a grade back | `/class ACC 120 got 88/100 on exam 1` |
| What do I need on the final? | `/class ACC 120 where do I stand` computes your weighted grade and the score you need |
| Transfer planning | The degree plan table in School, with each course's `transfers_to` property |
| Lecture notes or readings | `/ingest` creates resource notes linked to the course |

## Career: "land the next job"

| Scenario | How |
|---|---|
| Found a posting | `/job <paste posting>` creates an application note, a requirements-vs-me table, and a fit verdict |
| Tailor my resume | `/job tailor resume for <company>` creates a true-facts-only version from your master resume |
| Applied, or heard back | `/job <company> applied today` updates the status and sets a 7-day follow-up |
| Interview coming up | `/job <company> interview prep` writes likely questions with answers built from your real experience |
| How's the search going? | `/job pipeline`, or the Applications table on Home |

## Housing: "get my own place, affordably"

| Scenario | How |
|---|---|
| Found a listing | `/apartment <paste listing>` creates a note with the all-in monthly cost, move-in cash needed, and a fits/tight/no verdict |
| How much rent can I afford? | `/apartment can I afford $1,100` checks against real income from the ledger and your budget |
| When can I move? | `/apartment move plan` works out the monthly savings needed and dated checklist tasks |

## Life: "nothing falls through the cracks"

| Scenario | How |
|---|---|
| Morning | `/today` gives your top 3 and anything overdue |
| Random thought, errand, or deadline | `/capture ...` files it in the right place with a date |
| Sunday | `/weekly` scores every area, clears the inbox, and plans next week |
| First of the month | `/monthly` closes the books and checks goals |
| Big decision | Claude writes a Decision note with the options, pros and cons, what you chose, and what would make you revisit it |

## What it's deliberately NOT

- **Not a bank connection.** No logins or account numbers are ever stored. You download CSVs yourself.
- **Not investment advice.** Claude gives facts and trade-offs about your own numbers.
- **Not a calendar replacement.** Dates live on tasks, and your phone calendar still handles appointments.
