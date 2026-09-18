# BioMentor — Architecture

## Stack
Next.js (App Router) + Supabase (Postgres + RLS) + Vercel. AI via OpenAI API (server-side only).

## Build Now vs Later
**Now:** Topic browser → AI lesson generation → AI quiz generation → quiz-taking → scoring → next steps.
**Later:** Auth + per-user data, teacher tools, parent dashboard, messaging, attendance, adaptive study plans.

## Key User Flow (one action, step-by-step)
1. Student opens app, sees topic grid (seeded topics from DB).
2. Student clicks a topic → app calls server action to generate lesson via AI.
3. Lesson (markdown + visual diagram description) is saved to `lessons` table and displayed.
4. Student clicks "Take Quiz" → AI generates 3-5 questions, saved to `quizzes` table.
5. Student answers questions, submits → answers saved to `quiz_attempts`, score computed.
6. AI generates recommended next steps based on score + topic, saved to `study_plans`.
7. Student sees score + recommendations on one page.

## Responsive Nav Shell
Persistent left sidebar (desktop): Topics, My Lessons, My Progress. Collapses to hamburger menu on mobile. Current section highlighted.

## Layer Plan
1. **Data layer** — Supabase tables, RLS policies (permissive for demo), data-access module (`lib/data/`).
2. **App logic** — Server actions for lesson/quiz generation, scoring, next-steps. UI components read/write only through `lib/data/`.
3. **Smart features** — AI module (`lib/ai/`) handles lesson generation, quiz generation, next-step recommendations. Called by server actions; never in client code.

## Why Core Runs Without AI
Topics, lessons (seeded), quizzes (seeded), and scoring are DB-backed. If AI is unavailable, seeded demo lessons and quizzes still render; the user can browse topics and take pre-seeded quizzes. AI enriches — it is not the only path.

## Repo Structure
```
app/
  topics/         # topic list + detail
  lessons/[id]/   # lesson view
  quizzes/[id]/   # quiz-taking view
  progress/       # progress summary
components/
lib/
  data/           # all DB reads/writes (topics.ts, lessons.ts, quizzes.ts, attempts.ts, plans.ts)
  ai/             # AI generation (lessonGen.ts, quizGen.ts, nextSteps.ts)
  actions/        # server actions
__tests__/        # tests beside code
```

## Module Map
| Module | Responsibility | Owns | Build Order |
|---|---|---|---|
| `topics` | Browse + select topics | topics table | 1st |
| `lessons` | Generate + display lessons | lessons table | 2nd |
| `quizzes` | Generate + take quizzes | quizzes + quiz_questions table | 3rd |
| `attempts` | Submit answers, score, persist | quiz_attempts table | 4th |
| `plans` | Recommend next steps | study_plans table | 5th |
| `ai` | All AI generation calls | none (stateless) | parallel to 2-5 |