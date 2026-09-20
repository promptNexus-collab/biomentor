# BioMentor — Tasks

## Sprint 1 — Foundation (DB + browse, no login)
Goal: app renders with seed data; subjects/topics/lessons browsable.
- [ ] Migration: subjects, topics, lessons, quiz_questions, quiz_attempts, study_steps + RLS + seeds
- [ ] Build `lib/data` access layer for all tables
- [ ] Subjects list + Topic list pages
- [ ] Lesson detail page renders seeded content + visual summary
- [ ] Responsive sidebar shell (desktop sidebar / mobile hamburger)
DoD: anonymous visitor sees seeded Biology/Botany topics and a full seeded lesson with quiz questions, no login.

## Sprint 2 — Core engine (v1 functional milestone)
Goal: full one-workflow loop works end-to-end.
- [ ] `lib/ai`: generate_lesson tool (content + visual_summary)
- [ ] Save generated lesson + auto-generated quiz to DB
- [ ] Quiz-taking UI → grade_quiz server action → save quiz_attempt
- [ ] recommend_steps (rule-based) → save study_steps → display
- [ ] "Generate lesson" button wired to real DB writes
DoD: student picks Photosynthesis → gets AI lesson → takes 3-question quiz → sees score + explanations + next steps; persists; refresh keeps state. ← **v1 functional**

## Sprint 3 — Polish & resilience
Goal: production-feel UX.
- [ ] Five states on every screen (loading/empty/partial/error/ready)
- [ ] AI failure → error card + Retry + seeded fallback lesson
- [ ] My Progress page (recent quiz_attempts + scores)
- [ ] Delete lesson/quiz via confirmed UI (human-only)
- [ ] Write audit rows for lesson_generated, quiz_submitted, step_generated
DoD: every screen handles empty + error; AI outage shows fallback; progress page lists real attempts.

## Sprint 4 — Lock it down
Goal: per-user data + accounts.
- [ ] Supabase auth (signup/login)
- [ ] Replace v1 permissive RLS with owner-scoped (auth.uid() = user_id)
- [ ] Keep seed rows public/shared
- [ ] Logged-in user sees only own attempts & steps
- [ ] Verify RLS with a human; stop if unsure
DoD: logged-out user sees demo only; logged-in attempts private; RLS confirmed.

## Gantt
```
S1 ████████ DB + browse (no login)
S2 ████████ Core engine → v1 functional
S3 ████████ Polish & resilience
S4 ████████ Auth + RLS lock-down
```