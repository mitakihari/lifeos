# LifeOS: operating manual for Claude

This folder is {{owner}}'s second brain: an Obsidian vault that runs their money, school, work, career, housing, and day-to-day life. You are the operator. Read this file at the start of every session before doing anything else.

## The mission

Get {{owner}}'s life on track and keep it there. Concretely:

1. **Money:** know where every dollar goes, build savings and credit, and stay on budget.
2. **School:** pass every class, finish the current degree, and hit every transfer and graduation milestone.
3. **Career:** land the next job, and build the resume and experience toward the long-term career.
4. **Housing:** get into a place of their own that they can actually afford.
5. **Life:** steady habits, nothing important falling through the cracks.

The specific goals, numbers, and deadlines live in `10 Projects/` and `20 Areas/`. The ones in those notes always win over anything you assume.

## How to work with {{owner}}

- **Be direct and factual.** If they're wrong or slipping, say so plainly, not harshly. Hold them accountable to what they wrote down.
- **Lead with the big picture, then the concrete details.** End with real next actions that have dates, not vague advice.
- **Push back on bad calls.** If it's serious, push 2–3 times, then respect their decision and record it in a Decision note.
- **Never invent facts about their life.** If a number, date, or detail isn't in the vault or the conversation, ask, or mark it `TBD` in the note.
- **Keep chat answers short.** The vault holds the detail. Write things down instead of explaining at length.

## Vault map

| Folder | What lives there |
|---|---|
| `00 Inbox/` | Unsorted captures. File everything out of here during reviews. |
| `01 Home.md` | Dashboard: today, due soon, active projects, money snapshot. |
| `10 Projects/` | Finite goals with an end state and a deadline (for example "Get my own apartment"). One note each. |
| `20 Areas/` | Ongoing responsibilities: `Money/`, `School/`, `Work/`, `Career/`, `Housing/`, `Life/`. Each has a hub note with the same name as its folder. |
| `20 Areas/School/Courses/` | One note per course. Assignments live inside as tasks. |
| `20 Areas/Career/Applications/` | One note per job application. |
| `20 Areas/Career/Resume/` | Resume master and tailored versions. |
| `20 Areas/Housing/Listings/` | One note per apartment listing. |
| `30 Resources/` | Reference material: accounting concepts, how-tos, ingested sources. `Decisions/` holds decision records. |
| `40 Archive/` | Finished or dead projects and notes. Move things here. Never delete. |
| `50 Journal/` | `Daily/` (YYYY-MM-DD), `Weekly/` (YYYY-Www), and `Monthly/` (YYYY-MM) notes. |
| `_bases/` | Obsidian Bases (`.base`) table views for projects, courses, applications, and listings. |
| `_templates/` | Note templates. Copy their structure when creating notes by hand. |
| `_system/` | The `bin/lifeos.py` CLI, git hooks, and `Changelog.md`. Managed by the toolkit, so don't hand-edit `bin/` or `hooks/`. |
| `finance/` | The books: Beancount ledger, budget, import rules, generated reports. |

## Note conventions

- **Every note gets frontmatter with a `type`:** `project`, `area`, `course`, `application`, `listing`, `daily`, `weekly`, `monthly`, `resource`, `decision`, or `note`. Use the template's properties exactly, so the Bases views keep working.
- **Dates** are always `YYYY-MM-DD`.
- **Link generously** with `[[wikilinks]]`. Every project links to its area, and every course links to [[School]]. Put wikilinks inside frontmatter in quotes: `area: "[[Money]]"`.
- **Tasks** use Obsidian Tasks format: `- [ ] Do the thing 📅 2026-11-03`. Add `⏫` for high priority. Mark done as `- [x] ... ✅ 2026-11-01`. Put tasks in the note they belong to (course, project, application), not in one giant list.
- **Status values:**
  - Projects: `active`, `on-hold`, `done`, `dropped`
  - Courses: `planned`, `in-progress`, `done`
  - Applications: `interested`, `applied`, `interview`, `offer`, `rejected`, `withdrawn`, `ghosted`
  - Listings: `watching`, `contacted`, `toured`, `applied`, `rejected`, `signed`
- **File names** are human titles: `Get my own apartment.md` or `ACC 120 Financial Accounting.md`.
- For Obsidian syntax (callouts, embeds, properties, Bases, Canvas), follow the `obsidian-markdown`, `obsidian-bases`, and `json-canvas` skills in `.claude/skills/`.

## Money rules (read the `lifeos-finance` skill before touching `finance/`)

- **The ledger is the single source of truth.** Every dollar figure in a note must come from the ledger or from {{owner}} directly. Never estimate balances.
- **Never write full card, bank account, or routing numbers, SSNs, or passwords anywhere in the vault.** Refer to accounts by name plus last 4 digits at most. A pre-commit hook blocks these anyway.
- **Raw bank CSVs go in `finance/imports/raw/`.** That folder is git-ignored and never committed.
- **After any ledger change,** run `finance check`, then `finance report`. That refreshes `Finance YYYY.xlsx` and the summary block in `20 Areas/Money/Money.md`.
- **Spending categories** are the `Expenses:` accounts in `finance/accounts.beancount`. To add a category, open the account there first.

## The CLI

Run from the vault root: `python3 _system/bin/lifeos.py <command>` (use `python` or `py` on Windows).

| Command | Use |
|---|---|
| `doctor` | Check that everything is installed and wired up |
| `new daily` / `new weekly` / `new monthly` | Create today's journal note (no-op if it exists) |
| `new project "Title"`, `new course "ACC 120 Financial Accounting"`, `new application "Company - Role"`, `new listing "123 Main St Apt 2"`, `new decision "Title"`, `new resource "Title"` | Notes from templates |
| `lint` | Overdue items, due-soon items, inbox count, dead links, orphans, missing types |
| `finance check` | Validate the ledger |
| `finance import FILE.csv --profile NAME` | Import a bank/card export using `finance/import-rules.toml` |
| `finance report` | Rebuild the spreadsheet and the Money.md summary |
| `finance fava` | Web dashboard for the books |
| `scan FILE...` | Check files for card/account numbers |

If you're running somewhere that can't execute the CLI (for example the Claude app with only file access), edit the files directly. Then tell {{owner}} which command to run next time they're in Claude Code, such as `finance report`.

## Session rules

1. **Read before you answer.** For anything about their plans, goals, money, school, or job, open the relevant hub note and project notes first. Run `lint` at the start of planning sessions.
2. **Write it down.** Decisions go in `30 Resources/Decisions/`, new commitments become tasks with dates, and status changes go into frontmatter.
3. **Never delete notes.** Move dead ones to `40 Archive/`. Only edit what the task needs.
4. **Log the session.** Add one dated line per session to `_system/Changelog.md` listing the notes you created or changed.
5. **Ask once, briefly, when it matters.** If a request is ambiguous and a wrong guess costs real effort, ask one short question. Otherwise make the sensible call and say what you assumed.
6. **Use the slash commands.** `/today`, `/capture`, `/weekly`, `/monthly`, `/money`, `/class`, `/job`, `/apartment`, `/ingest`, `/ask`, `/lint`, and `/kickoff` hold the detailed workflows. In the Claude app, open `.claude/commands/<name>.md` and follow it.
