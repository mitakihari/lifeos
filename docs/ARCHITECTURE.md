# Architecture

## Two repos

- **`lifeos` (public): the toolkit.** It holds the vault template, the CLI, the Claude commands and skills, the git hook, the tests, and the docs. Nothing personal goes in it, which means it can be shared and shown to employers.
- **`lifeos-vault` (private): the data.** It holds notes, plans, and the ledger. It's created once from the template with `init`, then updated with `sync`.

`sync` copies only *managed* files into the vault: `.claude/commands`, `.claude/skills`, `_system/bin/lifeos.py`, and `_system/hooks`. Notes, the ledger, and settings are never overwritten. Because the vault carries its own copy of the CLI, it works on its own (on another computer, on GitHub, in the Claude app) without the toolkit present.

## Why these choices

| Decision | Chosen | Over | Because |
|---|---|---|---|
| Notes | Obsidian, plain Markdown | Notion, Google Docs | Local files Claude can read and write directly, git-friendly, works offline |
| Organization | PARA-style numbered folders (Inbox, Projects, Areas, Resources, Archive, Journal) | Zettelkasten | Life admin is goal- and area-shaped, not idea-shaped |
| Tables and dashboards | Obsidian **Bases** (core plugin) + Tasks plugin | Dataview | Bases is built in and maintained by Obsidian; fewer plugins means fewer breakages |
| Books | **Beancount v3** double-entry | Spreadsheet-only, hledger | Real accounting (good practice for an accounting student), strict validation and balance assertions, Python API for reports and imports, Fava UI |
| Spreadsheets | Generated `.xlsx` with live formulas | Hand-maintained sheet | One source of truth (the ledger), so the sheet can't drift; formulas stay auditable |
| Bank data | Manual CSV import + regex rules | Plaid/bank API | No credentials stored anywhere; works with any bank |
| Claude | `CLAUDE.md` + slash commands + skills | One giant prompt | The commands are small, readable, and editable; they work in Claude Code and can be followed in the Claude app |
| Sync | Obsidian Git → private GitHub repo | Paid sync | Free, versioned history, undo anything |

## Safety layers

1. **Policy.** `CLAUDE.md` and the finance skill forbid account numbers, invented numbers, and deletions.
2. **`.gitignore`.** `finance/imports/raw/` (bank downloads) is never tracked.
3. **Pre-commit hook.** `lifeos.py scan --staged` blocks commits containing Luhn-valid card numbers, SSN patterns, labeled account/routing numbers, or password/API-key assignments.
4. **Private repo.** Even if something slips through all of the above, it's still not public.
5. **No deletes.** Notes are archived rather than deleted, and git history keeps everything recoverable.

## The CLI

`scripts/lifeos.py` is a single file. The core uses only the Python standard library. `beancount` and `openpyxl` are imported only by the finance commands. It's tested on Linux, macOS, and Windows with Python 3.11 and 3.13 (see `.github/workflows/ci.yml`).
