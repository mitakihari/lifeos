---
description: Scout for jobs, apartments, and resume boosters that match the vault's goals, and file what's found.
argument-hint: "[jobs | housing | boosters | all (default)]"
---
Run the LifeOS scout for: ${ARGUMENTS:-all}

The scout **finds and files**. It never applies, contacts anyone, signs up, or pays for anything. The user does those.

## 0. Read the criteria first
- [[Career]]: the "Right now" section and the target roles table.
- [[Land an accounting job]]: urgency and the two tracks (bridge job + finance/business).
- [[Housing]]: who's moving, budget, must-haves, location rules.
- [[Work]], [[School]], and the course notes: when the user is free to work. Class times rule out some shifts.
- [[Resume - Master]] and `30 Resources/Resume Boosters.md` (if it exists): what's already there.
- Existing notes in `20 Areas/Career/Applications/` and `20 Areas/Housing/Listings/`. **Never file a duplicate.** Match on link, or company + role, or address.

## 1. Jobs
Search the web (Indeed, LinkedIn, ZipRecruiter, Glassdoor, Craigslist, Maine JobLink, and the careers pages of local banks, credit unions, tax prep offices, CPA firms, insurance agencies, and big local employers) for jobs within about 15 miles of the user's town in [[Housing]] / [[Work]].

- **Finance/business track:** teller, member service rep, tax preparer (seasonal), office/admin assistant at accounting or financial firms, data entry, AP/AR clerk, payroll assistant, insurance or bank customer service, and anything else entry-level that's in or next to finance.
- **Bridge track** (only while [[Land an accounting job]] says income is urgent): non-food-service jobs that hire fast, such as retail, grocery, warehouse, delivery, and front desk. Food service goes last, and only if little else exists.
- **Keep** a job only if it's posted within the last 30 days (or still says it's open), and it's entry-level or "will train." Skip anything that requires a degree the user doesn't have, unless it says "or equivalent experience/coursework."
- **File each keeper** with `python3 _system/bin/lifeos.py new application "<Company> - <Role>"`.
  - Frontmatter: `status: interested`, `company`, `role`, `pay` (only if posted), `location`, `source` (site name), `link`.
  - Under "Why this one," write one line: which track, and the fit verdict (strong / stretch / skip-worthy), with the reason.
  - Fill "Requirements vs. me" from the vault only.
  - Add a task: `- [ ] Apply 📅 <date within 3 days for strong fits, 7 for others>`.
- **Limit:** 8 new jobs per run, best first.

## 2. Housing
Use the Zillow tools if available (search, then rent details), plus the web (Zillow, Apartments.com, Craigslist, Facebook Marketplace listings visible without login, local property managers).
- **Match** the [[Housing]] must-haves exactly. Right now that means **heat included**, near CMCC / work or on a bus line, and rent at or under the target (allow up to +10% if it's otherwise great, and flag it).
- **Bedrooms:** check the Housing plan for who's moving in.
- **File each keeper** with `python3 _system/bin/lifeos.py new listing "<street address or short name>"`.
  - Frontmatter: `address`, `town`, `rent`, `utilities_included` (say exactly what's included), `beds`, `baths`, `deposit` (if posted), `available`, `pets`, `laundry`, `parking`, `link`, `contact`, `status: watching`.
  - Under "Quick read," note distance/travel to CMCC and whether a bus route serves it. If you can't confirm, write TBD.
  - Add a task: `- [ ] Contact to schedule a showing 📅 <within 2 days>`.
- **Scam check:** skip and note any listing that asks for a deposit or payment before a showing, won't show the unit, pushes wire transfers or gift cards, or prices far below the area. Never contact anyone yourself.
- **Limit:** 6 new listings per run.

## 3. Resume boosters
Keep `30 Resources/Resume Boosters.md` (type: resource) as one table:

| Booster | What it is | Cost | Time | Why it helps *my* goals | Status | Link |

Look for certifications, licenses, free courses, and volunteer roles that an entry-level finance/accounting candidate in the user's state can get cheaply and quickly. Examples to check: notary public (state requirements and fee), IRS VITA volunteer tax preparer, Microsoft Office Specialist (Excel), QuickBooks/Intuit certifications, tax-prep company training courses, free bank-teller or customer-service certificates, and typing/data-entry tests. Also check anything school-based (CMCC tutoring, clubs, work-study).

- Verify cost, requirements, and dates from official sources. Don't guess. Write TBD if you can't confirm.
- Rank by value to the job goals divided by cost and time.
- Add at most the top 1–2 *new* ones as tasks in [[Land an accounting job]].
- Mark existing rows `stale` if their info changed.
- Status values: `idea`, `doing`, `done`, `skip`.

## 4. Digest and wrap-up
1. Write `00 Inbox/Scout <YYYY-MM-DD>.md` (type: note) with:
   - the top 3 jobs, top 3 apartments, and the top booster, each as a [[link]] with a one-line why;
   - counts (new / skipped as duplicates / skipped as scams);
   - anything that needs the user's decision.
2. Run `python3 _system/bin/lifeos.py lint` and fix dead links and missing types.
3. Add a line to `_system/Changelog.md`.
4. `git pull --rebase`, then commit with the message "scout: <date>" and push.
5. Reply with the digest in under 12 lines.

**Never:**
- invent pay, rent, or requirements;
- file a listing you couldn't open;
- put the user's personal details anywhere outside the vault;
- apply, message, or sign up for anything.
