---
description: Housing. Track a listing, check affordability, plan the move.
argument-hint: "<listing text/link | 'can I afford <rent>' | 'move plan'>"
---
Housing request: $ARGUMENTS

- **New listing:**
  1. Run `python3 _system/bin/lifeos.py new listing "<address or short name>"`.
  2. Fill in the frontmatter from the listing: `rent`, `utilities_est`, `beds`, `available`, `deposit`, `town`, `link`, and the rest.
  3. List pros and cons against the must-haves in [[Housing]].
  4. Compute the all-in monthly cost (rent + utilities + renters insurance) and the move-in cash needed (first month + deposit + any fees).
  5. Compare both to the affordability table in [[Housing]] and the current move-in fund in the ledger. Verdict: fits, tight, or no.
- **"Can I afford X":**
  1. Use income from the ledger (average of the last 3 months if available) and the 30%-of-gross rule. Also check whether the all-in cost leaves the current budget categories intact.
  2. Show the math.
  3. If the income history is too thin to say, state that.
- **Move plan:** set a target move date. Work backward to how much needs saving per month and the checklist dates. Put the tasks in [[Housing]] with 📅 dates, and check the savings pace against [[Money]].

Never guess numbers that aren't in the listing or the vault. Mark them TBD and list the questions to ask the landlord.
