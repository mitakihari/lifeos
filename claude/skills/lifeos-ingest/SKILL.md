---
name: lifeos-ingest
description: Turn source material (articles, PDFs, lecture notes, syllabi, links, transcripts) into linked Resource notes in the LifeOS vault, and answer questions from those notes with citations. Use for /ingest and /ask, or whenever the user hands over something to keep and learn from.
---

# LifeOS ingest

This is adapted from the source-first loop in [claude-obsidian](https://github.com/AgriciDaniel/claude-obsidian) (MIT) and Karpathy's "LLM wiki" pattern, scaled down for a personal vault. In short: **keep the source, ground the claims, connect the knowledge, reuse it.**

## Ingest

1. **Read the whole source first.** Don't summarize what you skimmed.
2. **Keep a pointer to the original.** Put the URL, or the vault path of the file (attachments go in `_attachments/`), in the note's `source:` property and under `## Source`.
3. **Use one Resource note per source,** in `30 Resources/` (or a subfolder like `30 Resources/Accounting/`). Create it with `lifeos.py new resource "<Title>"`.
4. **Write it in the user's own terms:** a 3–5 sentence summary, key points, and "How I'll use this", which ties it to a specific course, project, or decision.
5. **Ground the claims:**
   - Paraphrase. Keep any direct quote short, and use at most one per source.
   - If the source contradicts something already in the vault, add a `> [!warning] Conflicts with [[Other Note]]` callout. Don't silently overwrite.
6. **Connect it:**
   - Link the resource from the relevant course note, project, or area hub, under a "Resources" line.
   - Link concept notes like `[[Accrual accounting]]` when they exist. If a concept comes up in several sources, create its own short note.

## Query

1. Find the notes with grep, the area hubs, and backlinks. Read the relevant ones.
2. Answer from them and cite them as `[[wikilinks]]`.
3. Separate what the vault says from general knowledge, and label the general knowledge.
4. If the vault is missing something important, say so and offer to ingest a source for it.

## School notes specifically

- **Lecture or reading notes** go in `30 Resources/<Course code>/`. Link them from the course note.
- **A syllabus** isn't a resource. Use it to fill the course note, following the `/class` flow.
- **For exam prep,** gather the course's resources and build a Q&A review list at the bottom of the course note.
