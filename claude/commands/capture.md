---
description: Dump anything into the vault and file it in the right place.
argument-hint: "<what to capture: a thought, task, receipt, link, deadline...>"
---
Capture this into LifeOS: $ARGUMENTS

Decide what it is and file it where it belongs. Don't leave it in the inbox if the destination is clear.

- **Task with a deadline:** add it to the note it belongs to (course, project, application, area hub) as `- [ ] ... 📅 YYYY-MM-DD`. Ask for the date only if it truly matters and is missing.
- **Cash purchase or tip:** add a transaction to `finance/transactions/YYYY-MM.beancount`, following the `lifeos-finance` skill.
- **Job posting:** run the `/job` flow.
- **Apartment listing:** run the `/apartment` flow.
- **Class info** (syllabus, exam date, grade): update the course note.
- **Idea or new goal:** if it has an end state, make it a project with `lifeos.py new project`. Otherwise add it to the relevant area hub.
- **Article, link, or document to keep:** use the `/ingest` flow.
- **Anything unclear:** write `00 Inbox/<short title>.md` with the raw text.

Reply with one line per item: what it was → where it went.
