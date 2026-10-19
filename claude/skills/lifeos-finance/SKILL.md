---
name: lifeos-finance
description: How to read and change the LifeOS books (Beancount ledger in finance/), import bank CSVs, categorize transactions, set budgets, and produce money reports. Use whenever a task touches money, spending, budgets, balances, bills, savings goals, or files in finance/.
---

# LifeOS finance

The books are plain-text double-entry accounting in [Beancount v3](https://beancount.github.io/docs/). Every transaction moves money between at least two accounts, and the postings sum to zero.

## Files

| File | Purpose |
|---|---|
| `finance/main.beancount` | Entry point. Includes everything else. |
| `finance/accounts.beancount` | Chart of accounts. An account must be opened here before it's used. |
| `finance/opening.beancount` | Starting balances, plus `balance` assertions. |
| `finance/transactions/YYYY-MM.beancount` | One file per month. Imports and hand entries go here, in date order. |
| `finance/budget.toml` | Monthly targets per expense account. |
| `finance/import-rules.toml` | CSV column mappings (profiles) and auto-categorization rules. |
| `finance/imports/raw/` | Raw bank downloads. Git-ignored. Read them, never commit them. |
| `finance/reports/Finance YYYY.xlsx` | Generated spreadsheet. Never edit by hand. |

## Signs (the part people get wrong)

| Account type | Positive means | Example |
|---|---|---|
| Assets | money you have went up | paycheck lands: `Assets:Bank:Checking 450.00 USD` |
| Liabilities | debt went down | (debts are negative numbers: owing $300 = `-300.00`) |
| Income | (always negative in a posting) | `Income:Job:Wages -450.00 USD` |
| Expenses | money spent | `Expenses:Food:Groceries 62.18 USD` |

You can leave one posting's amount blank, and Beancount fills it in.

## Writing transactions

```beancount
2026-10-17 * "Hannaford" "weekly groceries"
  Assets:Bank:Checking      -62.18 USD
  Expenses:Food:Groceries

2026-10-18 * "Margaritas" "cash tips, Wed shift"
  Assets:Cash                45.00 USD
  Income:Job:Tips

2026-10-20 * "Credit card payment"
  Assets:Bank:Checking     -120.00 USD
  Liabilities:CreditCard
```

- **Flags:** `*` means confirmed, `!` means needs review. Imports with no matching rule come in as `!` and post to `...:Uncategorized`.
- **Splits:** one receipt split across categories uses multiple expense postings.
- **Transfers** between your own accounts are not spending. They post Asset to Asset, or Asset to Liability.
- **`import-id`** is metadata used to skip duplicates. Keep it when you edit an imported transaction.
- **Placement:** put each transaction in the right month file, keeping dates in order.

## Categorizing

1. Look at the payee and description. If the right `Expenses:` or `Income:` account is clear, replace `Uncategorized` with it and change `!` to `*`.
2. If the merchant will recur, add a `[[rules]]` entry to `import-rules.toml`. Rules are case-insensitive regexes tested against the description, and the first match wins. Put specific rules above broad ones.
3. If no category fits, open a new account in `accounts.beancount` dated on or before its first use. Keep the category list short. Prefer the existing ones.
4. If you can't tell what a transaction is, ask. Don't guess.

## Balance assertions (how the books stay honest)

When the user reports a real balance from their bank app, add this line:

```beancount
2026-10-31 balance Assets:Bank:Checking  812.44 USD
```

It asserts the balance at the **start** of that date. If `finance check` fails on it, a transaction is missing or wrong. Find it rather than "fixing" the number.

## Commands

All run from the vault root:

- `python3 _system/bin/lifeos.py finance check`: validates the ledger. Run it after every edit.
- `python3 _system/bin/lifeos.py finance import <csv> --profile <name> [--dry-run]`
- `python3 _system/bin/lifeos.py finance report [--year YYYY]`: writes the spreadsheet and refreshes the snapshot block in `20 Areas/Money/Money.md`.
- `python3 _system/bin/lifeos.py finance fava`: web dashboard at http://localhost:5000.

## Hard rules

- **Never write full account, card, or routing numbers, SSNs, or logins** anywhere. Use names, or the last 4 digits at most.
- **Every number you state about the user's money comes from the ledger,** or from what they just told you. If you're estimating, say so.
- **Never edit `reports/` by hand,** and never edit the generated block in Money.md by hand. Regenerate them.
- **You give facts and trade-offs, not investment advice.** No recommending specific securities, trades, or crypto.
