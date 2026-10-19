---
description: Turn a source (article, PDF, notes, lecture, link) into a linked Resource note.
argument-hint: "<file path, link, or pasted text>"
---
Ingest into LifeOS: $ARGUMENTS

Follow the `lifeos-ingest` skill:
1. Read the whole source. For a link, fetch the page. For a local file, read it.
2. Create the note with `python3 _system/bin/lifeos.py new resource "<clear title>"`. Then:
   - write a summary in plain words,
   - list the key points,
   - say how it applies to the user, linking to the relevant area, project, or course,
   - add the source link or path.
3. Keep quotes short and few. Paraphrase.
4. Link it into the vault: add a line under the relevant course, project, or area note pointing to the new resource.
5. Reply with the note title and the two most useful takeaways.
