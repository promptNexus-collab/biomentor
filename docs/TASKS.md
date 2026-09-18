# BioMentor — Tasks & Sprints

## Sprint 1 — Database + Topic Browser
**Goal:** DB schema live, topics seeded, topic grid renders without login.
- [ ] Create Supabase tables + RLS (permissive) + seed data (migration SQL)
- [ ] Build `lib/data/topics.ts` — fetch topics from DB
- [ ] Build topic grid page (`/topics`) — cards with name, subject, difficulty, icon
- [ ] Loading / empty / error states on topic grid
- [ ] Responsive sidebar shell (desktop sidebar, mobile hamburger)
- **DoD:** Open app → see 5+ seeded biology/botany topics as cards. No login.

## Sprint 2 — Lesson Generation (core engine)
**Goal:** Student selects topic → AI generates and saves lesson.
- [ ] Build `lib/ai/lessonGen.ts` — call OpenAI, return markdown + visual summary
- [ ] Build `lib/data/lessons.ts` — insert/fetch lessons
- [ ] Build server action `generateLesson(topicId)`
- [ ] Build topic detail page with "Generate Lesson" button → lesson renders
- [ ] Loading / error / partial states during generation
- [ ] Seed at least one pre-generated demo lesson so page works without AI
- **DoD:** Click topic → see AI-generated lesson with visual explanation, persisted to DB.

## Sprint 3 — Quiz Generation + Taking + Scoring
**Goal:** Student takes a quiz on the lesson and gets an instant score.
- [ ] Build `lib/ai/quizGen.ts` — generate 3-5 questions as structured JSON
- [ ] Build `lib/data/quizzes.ts` + `lib/data/attempts.ts`
- [ ] Build server action `generateQuiz(lessonId)` and `submitQuiz(quizId, answers)`
- [ ] Build quiz-taking UI — question cards, option selection, submit
- [ ] Score computed (rule-based), saved to `quiz_attempts`
- [ ] Show score + per-question correctness
- [ ] Loading / empty / error states
- **DoD:** After lesson, click "Take Quiz" → answer 3-5 questions → see instant score with correct/incorrect breakdown.

## Sprint 4 — Study Plan Recommendations + End-to-End Flow (v1 FUNCTIONAL)
**Goal:** Complete the one workflow: topic → lesson → quiz → score → next steps.
- [ ] Build `lib/ai/nextSteps.ts` — generate recommendations from score + topic
- [ ] Build `lib/data/plans.ts` — save study plans
- [ ] Build server action `generateStudyPlan(attemptId)`
- [ ] Display recommendations on quiz result page
- [ ] Add "My Progress" page — list of lessons + attempts + scores
- [ ] Full end-to-end test of success scenario
- **DoD (v1 milestone):** Student opens app → picks "Photosynthesis" → sees lesson → takes quiz → scores 2/3 → sees "Review light-dependent reactions" recommendation. All data in DB. No login.

## Sprint 5 — Lock It Down (auth + RLS)
**Goal:** Per-user data isolation.
- [ ] Add Supabase Auth (signup / login)
- [ ] Replace permissive RLS with `auth.uid() = user_id` policies on lessons, quizzes, quiz_attempts, study_plans
- [ ] Topics remain public read
- [ ] Redirect unauthenticated users from lesson/quiz/progress pages to login
- [ ] Seed demo user + data for testing
- **DoD:** Logged-in user sees only their lessons/attempts. Anonymous sees topics only.

## Sprint 6+ — Later
- Teacher lesson builder + worksheet export
- Parent dashboard (read-only progress)
- Student-teacher messaging
- Attendance tracking
- Adaptive difficulty + spaced repetition

## Gantt
```
Sprint 1: DB + Topics          ████
Sprint 2: Lesson Generation    ████
Sprint 3: Quiz + Scoring      ████
Sprint 4: Study Plan + E2E    ████  ← v1 functional milestone
Sprint 5: Lock Down (Auth)     ████
Sprint 6+: Later features     ████
```