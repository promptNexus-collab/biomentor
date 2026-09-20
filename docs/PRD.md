# BioMentor — PRD

## Problem
Students struggle to find personalised, visual biology/botany explanations; teachers and parents lack one place to guide and monitor learning. Generic resources aren't tailored to each learner's level or next gap.

## Target user
Primary (v1): students learning Biology & Botany. Later: teachers (build lessons/worksheets/assessments), parents (monitor progress, give feedback).

## Core objects (v1)
- **Subject** — Biology, Botany, Microbiology
- **Topic** — e.g. Photosynthesis, Cell Structure (difficulty: beginner/intermediate)
- **Lesson** — AI-generated title, content, visual_summary
- **QuizQuestion** — question, options, correct_answer, explanation
- **QuizAttempt** — score, total, answers
- **StudyStep** — recommended next study step per lesson

Secondary (later, not built now): student/teacher profiles, courses, assignments, attendance, parent feedback, messaging.

## MVP (v1) — must-haves
- [ ] Browse subjects + topics
- [ ] Generate a personalised lesson for a chosen topic (content + visual summary)
- [ ] Auto-generate a short quiz (3-5 questions)
- [ ] Student takes quiz → instant score + per-question explanation
- [ ] Show recommended next study steps based on score
- [ ] All screens viewable without login (seed demo data); create/edit/delete works
- [ ] Empty / loading / error states handled on every screen

## Non-goals (v1)
- Login/signup & per-user data isolation (later sprint)
- Teacher lesson-builder, worksheets, assessments
- Parent dashboard & progress monitoring
- Attendance, messaging, billing

## Success criteria (one concrete end-to-end scenario)
A student opens the app with no login, selects Botany → Photosynthesis, receives a generated lesson with a visual explanation, completes a 3-question quiz, sees their score (e.g. 2/3) with explanations, and receives 2-3 recommended next steps. Every action persists to the database and the UI reflects it.