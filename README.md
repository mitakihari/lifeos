# LifeOS

**An Obsidian + Claude second brain for running your actual life: money, school, work, career, and housing.**

LifeOS is a vault template, a small Python CLI, and a set of Claude commands. It turns an [Obsidian](https://obsidian.md) vault into a system that tracks your goals, keeps real double-entry books, generates budget spreadsheets, and lets Claude hold you accountable.

Everything is plain files you own: Markdown notes, a text ledger, and spreadsheets generated from it. Nothing is locked in a cloud database.

## What it does

| Area | What you get |
|---|---|
| **Money** | [Beancount](https://beancount.github.io/) double-entry ledger, a bank CSV importer with auto-categorization rules, a budget, a generated **Excel workbook** (summary, monthly-vs-budget, transactions), a live snapshot in your Money note, and the [Fava](https://beancount.github.io/fava/) web dashboard |
| **School** | Course notes with assignments as dated tasks, grade tracking, degree/transfer plan, "what do I need on the final" math |
| **Career** | Job application pipeline (Obsidian Bases table), master + tailored resumes, interview prep, follow-up reminders |
| **Housing** | Listing tracker with all-in cost, affordability check against real income, move-in savings plan |
| **Life** | Daily / weekly / monthly reviews, habits, admin checklists |
| **Safety** | Pre-commit hook that blocks card numbers, SSNs, account/routing numbers, and passwords; raw bank exports never get committed |

## How it fits together

```
lifeos/ (this repo, public)              your-vault/ (separate, PRIVATE repo)
├── template/   vault skeleton  ── init ─▶ ├── CLAUDE.md        Claude's operating manual
├── claude/     commands + skills ─ sync ▶ ├── .claude/          /today /weekly /money ...
├── scripts/lifeos.py  the CLI  ── sync ─▶ ├── _system/bin/lifeos.py
├── hooks/      secret scanner  ── sync ─▶ ├── _system/hooks/
├── vendor/obsidian-skills                 ├── 01 Home.md, 10 Projects/, 20 Areas/ ...
└── tests/, docs/                          └── finance/  ledger, budget, rules, reports
```

The tools live here and your data lives in your own private repo. `sync` pushes tool updates into the vault without touching your notes.

## Claude commands

Use these in Claude Code from the vault. In the Claude app, add the vault folder to the chat and ask for one by name.

| Command | Does |
|---|---|
| `/kickoff` | First session: an interview that fills the vault with your real goals, numbers, and deadlines |
| `/today` | Creates today's note, surfaces what's due, sets your top 3 |
| `/capture` | Dumps anything in, and it gets filed in the right place |
| `/weekly` | Sunday review: scores each area, clears the inbox, plans next week |
| `/monthly` | Closes the books, checks budget and goals, adjusts the plan |
| `/money` | Imports statements, categorizes, reports, answers "can I afford it" |
| `/class` | Course setup, syllabus to tasks, grades, standing |
| `/job` | Tracks an application, tailors your resume, interview prep |
| `/apartment` | Tracks a listing, checks affordability, builds a move plan |
| `/ingest` / `/ask` | Turns sources into linked notes, and answers from the vault with citations |
| `/lint` | Vault health check and cleanup |

## CLI

```
python3 scripts/lifeos.py init ~/LifeOS-vault --name Fox      # new vault
python3 scripts/lifeos.py sync --vault ~/LifeOS-vault         # update tools in a vault
# inside a vault:
python3 _system/bin/lifeos.py doctor | lint | new daily | finance import x.csv --profile checking | finance report | finance fava | plugins install
```

## Get started

See **[docs/SETUP.md](docs/SETUP.md)**. It's written for people who have never used Git.

- [docs/USE-CASES.md](docs/USE-CASES.md): what this is for, with concrete scenarios
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md): design decisions and how the pieces connect
- [docs/CLAUDE-APP-PROJECT.md](docs/CLAUDE-APP-PROJECT.md): instructions to paste into a Claude Project

## Credits

- [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) (MIT): vendored Obsidian Markdown, Bases, and JSON Canvas skills
- [AgriciDaniel/claude-obsidian](https://github.com/AgriciDaniel/claude-obsidian) (MIT) and Karpathy's LLM Wiki pattern: the ideas behind `/ingest`, `/ask`, and `/lint`
- [Beancount](https://github.com/beancount/beancount) and [Fava](https://github.com/beancount/fava): the books
- Obsidian plugins: [Tasks](https://github.com/obsidian-tasks-group/obsidian-tasks), [Obsidian Git](https://github.com/Vinzent03/obsidian-git), [Calendar](https://github.com/liamcain/obsidian-calendar-plugin)

MIT licensed.
