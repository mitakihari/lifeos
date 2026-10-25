---
description: Job scout. Find entry-level finance/business jobs and fast bridge jobs near home, and file each as an application note.
---
LifeOS job scout. It finds and files; it never applies, contacts, signs up, or pays.

## 0. Read the criteria first
- [[Career]]: the "Right now" section and the target roles table.
- [[Land an accounting job]]: urgency and the two tracks (bridge job + finance/business).
- [[Housing]]: who's moving, budget, must-haves, location rules.
- [[Work]], [[School]], and the course notes: when the user is free to work. Class times rule out some shifts.
- [[Resume - Master]] and `30 Resources/Resume Boosters.md` (if it exists): what's already there.
- Existing notes in `20 Areas/Career/Applications/` and `20 Areas/Housing/Listings/`. **Never file a duplicate.** Match on link, or company + role, or address.

## Search
**Use the Indeed and ZipRecruiter connector tools first if they're connected** (`search_jobs`, `get_job_details`). Then search the web (Indeed, LinkedIn Jobs, ZipRecruiter, Glassdoor, Craigslist, Maine JobLink, and the careers pages of local banks, credit unions, tax prep offices, CPA firms, insurance agencies, and big local employers) for jobs within about 15 miles of the user's town in [[Housing]] / [[Work]].

- **Finance/business track:** teller, member service rep, tax preparer (seasonal), office/admin assistant at accounting or financial firms, data entry, AP/AR clerk, payroll assistant, insurance or bank customer service, and anything else entry-level that's in or next to finance.
- **Bridge track** (only while [[Land an accounting job]] says income is urgent): non-food-service jobs that hire fast, such as retail, grocery, warehouse, delivery, and front desk. Food service goes last, and only if little else exists.
- **Keep** a job only if it's posted within the last 30 days (or still says it's open), and it's entry-level or "will train." Skip anything that requires a degree the user doesn't have, unless it says "or equivalent experience/coursework."
- **File each keeper** with `python3 _system/bin/lifeos.py new application "<Company> - <Role>"`.
  - Frontmatter: `status: interested`, `company`, `role`, `pay` (only if posted), `location`, `source` (site name), `link`.
  - Under "Why this one," write one line: which track, and the fit verdict (strong / stretch / skip-worthy), with the reason.
  - Fill "Requirements vs. me" from the vault only.
  - Add a task: `- [ ] Apply 📅 <date within 3 days for strong fits, 7 for others>`.
- **Limit:** 8 new jobs per run, best first.

## Wrap up
1. Append to `00 Inbox/Scout <YYYY-MM-DD>.md` (type: note; create it if missing) a `## Job` section with the top 3 new jobs as [[links]] with a one-line why, plus counts (new / duplicate / skipped).
2. Run `python3 _system/bin/lifeos.py lint` and fix dead links or missing types you caused.
3. Add a line to `_system/Changelog.md`.
4. `git pull --rebase`, commit "scout-jobs: <date>", and push.
5. Reply in under 8 lines.

## Never
- invent pay, rent, requirements, costs or dates;
- file anything you couldn't open and confirm is current;
- apply, message, sign up, pay, or contact anyone (the user does all of that);
- put the user's personal details anywhere outside the vault.
