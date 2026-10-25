---
description: Run all three scouts (jobs, housing, resume boosters) back to back.
argument-hint: "[jobs | housing | boosters | all (default)]"
---
Run the LifeOS scouts for: ${ARGUMENTS:-all}

Each scout is its own command, so it can be run or scheduled separately:
- `/scout-jobs`: entry-level finance/business jobs plus bridge jobs
- `/scout-housing`: rentals that match [[Housing]]
- `/scout-boosters`: certifications, courses and volunteer roles for the resume

For "all," run them in this order: jobs, housing, boosters, following each command file in `.claude/commands/` exactly. They share one digest note, `00 Inbox/Scout <YYYY-MM-DD>.md`. Commit once at the end instead of three times.
