# BioMentor — Architecture

## Stack
Next.js (App Router) + Supabase (Postgres + RLS) + Vercel. AI via an OpenAI-style API called server-side only; results stored with `source` / `confidence` / `review_status`.

## Build now vs later
Now: subject/topic browse, AI lesson generation, quiz + scoring, next steps. Later: accounts, teacher tools, parent dashboard, messaging.

## Key action flow (one real loop)
1. Student picks a topic → server action generates lesson (content + visual summary).
2. Lesson saved to `lessons`; quiz questions generated & saved to `quiz_questions`.
3. Student answers → `grade_quiz` action grades and writes `quiz_attempts`.
4. Based on score, next steps generated & saved to `study_steps`; shown to student.
5. State read from DB (survives refresh; identical on any device).

## Responsive nav shell
Persistent left sidebar on desktop (Subjects, Lessons, My Progress); collapses to hamburger on mobile; current section highlighted; keyboard-accessible.

## Layer plan
Data model first (tables, RLS, seeds) → app logic (server actions, data-access layer) → smart features (AI generation) on top. Core runs with AI off: seeded lessons/quizzes display and grade from DB; AI generation is an enhancement, not a requirement to view existing content.

## Repo structure
Feature folders: `features/lessons`, `features/quizzes`, `features/study`; `lib/data` (all DB access, never inline in UI); `lib/actions` (server logic); `lib/ai` (generation); tests beside code.

## Module map (build order)
1. **data** — owns subjects/topics/lessons/quizzes/study_steps; all DB reads/writes. Built first.
2. **lessons** — topic browse + lesson generation/view.
3. **quizzes** — quiz generation, answering, scoring.
4. **study** — next-step recommendations.
5. **ai** — lesson/quiz/step generation; called by 2-4.