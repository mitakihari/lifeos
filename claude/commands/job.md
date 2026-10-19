---
description: Career. Track a job application, tailor the resume, prep for interviews, follow up.
argument-hint: "<job posting text/link | company name + update | 'pipeline'>"
---
Career request: $ARGUMENTS

- **New posting:**
  1. Run `python3 _system/bin/lifeos.py new application "<Company> - <Role>"`.
  2. Fill in the frontmatter: `company`, `role`, `pay`, `location`, `source`, `link`, `status`.
  3. Fill the "Requirements vs. me" table honestly from [[Resume - Master]], [[Work]], and [[School]].
  4. Give a fit verdict in one line: strong, stretch, or skip, with the reason.
- **Tailor resume:** create `20 Areas/Career/Resume/Resume - <Company>.md`. Use only true facts from the master resume, re-ordered and re-worded for this posting. Never invent experience, titles, dates, or numbers. Flag any gap instead. If the user wants a file to submit, offer a .docx or PDF.
- **Applied, heard back, or interviewed:** update `status`, `applied`, `next_step`, and `next_step_date`, and add a Timeline line. After applying, set a follow-up task 7 days out.
- **Interview prep:** write likely questions plus answers built only from real experience in the vault (CAR/STAR format) into the note's "Interview prep" section.
- **"Pipeline":** summarize open applications. Flag stale ones (no movement in 10+ days) and next steps due this week.
