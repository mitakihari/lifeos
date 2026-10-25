---
description: Housing scout. Find rentals that match the Housing must-haves, check for scams, and file each as a listing note.
---
LifeOS housing scout. It finds and files; it never applies, contacts, signs up, or pays.

## 0. Read the criteria first
- [[Career]]: the "Right now" section and the target roles table.
- [[Land an accounting job]]: urgency and the two tracks (bridge job + finance/business).
- [[Housing]]: who's moving, budget, must-haves, location rules.
- [[Work]], [[School]], and the course notes: when the user is free to work. Class times rule out some shifts.
- [[Resume - Master]] and `30 Resources/Resume Boosters.md` (if it exists): what's already there.
- Existing notes in `20 Areas/Career/Applications/` and `20 Areas/Housing/Listings/`. **Never file a duplicate.** Match on link, or company + role, or address.

## Search
Use the Zillow tools if available (search, then rent details), plus the web (Zillow, Apartments.com, Craigslist, Facebook Marketplace listings visible without login, local property managers).
- **Match** the [[Housing]] must-haves exactly. Right now that means **heat included**, near CMCC / work or on a bus line, and rent at or under the target (allow up to +10% if it's otherwise great, and flag it).
- **Bedrooms:** check the Housing plan for who's moving in.
- **File each keeper** with `python3 _system/bin/lifeos.py new listing "<street address or short name>"`.
  - Frontmatter: `address`, `town`, `rent`, `utilities_included` (say exactly what's included), `beds`, `baths`, `deposit` (if posted), `available`, `pets`, `laundry`, `parking`, `link`, `contact`, `status: watching`.
  - Under "Quick read," note distance/travel to CMCC and whether a bus route serves it. If you can't confirm, write TBD.
  - Add a task: `- [ ] Contact to schedule a showing 📅 <within 2 days>`.
- **Scam check:** skip and note any listing that asks for a deposit or payment before a showing, won't show the unit, pushes wire transfers or gift cards, or prices far below the area. Never contact anyone yourself.
- **Limit:** 6 new listings per run.

## Wrap up
1. Append to `00 Inbox/Scout <YYYY-MM-DD>.md` (type: note; create it if missing) a `## Housing` section with the top 3 new listings as [[links]] with a one-line why, and any scam warnings, plus counts (new / duplicate / skipped).
2. Run `python3 _system/bin/lifeos.py lint` and fix dead links or missing types you caused.
3. Add a line to `_system/Changelog.md`.
4. `git pull --rebase`, commit "scout-housing: <date>", and push.
5. Reply in under 8 lines.

## Never
- invent pay, rent, requirements, costs or dates;
- file anything you couldn't open and confirm is current;
- apply, message, sign up, pay, or contact anyone (the user does all of that);
- put the user's personal details anywhere outside the vault.
