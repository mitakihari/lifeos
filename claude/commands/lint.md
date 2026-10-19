---
description: Vault health check. Fix dead links, missing properties, orphans; surface overdue items.
---
Run `python3 _system/bin/lifeos.py lint` and `python3 _system/bin/lifeos.py finance check`, then fix what's safe to fix:

- **Dead links:** if the note was renamed, fix the link. If the target should exist, create it from the right template. Otherwise ask.
- **Missing `type:`:** add the right frontmatter.
- **Orphans:** link each one from its area hub or project. If it's junk, move it to `40 Archive/`. Never delete.
- **Overdue items:** don't change dates silently. List them and ask whether each one is done, moved, or dropped.
- **Ledger errors:** fix syntax and unopened accounts. Ask about anything involving real amounts.

Re-run lint. Reply with the before and after counts, plus anything that needs a decision.
