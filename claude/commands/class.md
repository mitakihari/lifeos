---
description: School. Set up a course, enter a syllabus, add assignments, log grades, check standing.
argument-hint: "<course code or name> [syllabus text / assignment / grade / 'where do I stand']"
---
School request: $ARGUMENTS

- **New course:** run `python3 _system/bin/lifeos.py new course "<CODE> <Name>"`. Fill in the frontmatter: `code`, `term`, `credits`, `status`, and `transfers_to` if known. Link it from the degree plan in [[School]].
- **Syllabus pasted or attached:** fill in Basics and the grading breakdown. Turn every dated assignment, quiz, exam, and project into a task, `- [ ] <item> 📅 YYYY-MM-DD`. Put exams in the daily note 3 days before as study reminders.
- **Grade:** add it to the Grades table and update `grade` in the frontmatter if it's a final grade.
- **"Where do I stand":** compute the current weighted grade from the Grades table and the grading breakdown. Say what score is needed on the remaining work to hit the target letter grade.
- **Assignment help:** keep the vault for tracking. Help with the actual work in chat, following the user's schoolwork preferences (ask whether they want a draft or a finished answer, ask for the citation style, respect word counts).

Reply briefly with what changed and the next due item for that course.
