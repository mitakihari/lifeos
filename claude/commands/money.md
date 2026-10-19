---
description: Money check-in. Import statements, categorize, report, answer money questions.
argument-hint: "[import <file> <profile> | question about money]"
---
Money check-in. Read the `lifeos-finance` skill first. Request: $ARGUMENTS

**If there are CSVs in `finance/imports/raw/`, or the user asked to import:**
1. Pick the profile from `finance/import-rules.toml`. If the CSV's columns don't match any profile, open the file, read its header row, and add or adjust a profile. Show the user the change.
2. Run `finance import <file> --profile <name> --dry-run`, then the real import.
3. For each `!` uncategorized transaction:
   - If the merchant is obvious, set the category and flip `!` to `*`.
   - If a merchant will repeat, add a rule to `import-rules.toml` so it's automatic next time.
   - Ask about the rest in one compact list.
4. Run `finance check` and `finance report`.

**If it's a question** ("can I afford X", "how much did I spend on food", "when will I hit my savings goal"):
- Answer from the ledger and budget only. Run `finance report`, or read `finance/transactions/` and `20 Areas/Money/Money.md`.
- Show the numbers and the math. If the data needed isn't in the ledger, say what's missing instead of guessing.
- Laying out the facts and trade-offs is fine. Recommending specific investments, securities, or trades is not. For that, say they'd need a licensed advisor.

Always end with the current-month line: spent vs budget, and net saved so far.
