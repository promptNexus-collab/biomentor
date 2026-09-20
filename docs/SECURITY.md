# BioMentor — Security

## Secret handling
AI API keys live in server env vars only (Vercel/Supabase); never imported client-side; all AI calls through server actions. No keys in repo or client bundle.

## Permission model
v1: open read/write (demo-first, anonymous). Lock-down sprint: RLS owner-scoped — users see only rows where `auth.uid() = user_id`; shared seed rows flagged public. Agent inherits the caller's permissions; cannot write as another user.

## Approved-tools rule
Agent may only call named tools (`generate_lesson`, `grade_quiz`, `recommend_steps`). No raw `run_any`/`send_any`; no arbitrary SQL execution from AI output — all DB writes go through the data-access layer.

## Audit principle
Every meaningful action (lesson generated, quiz submitted, steps generated) writes an audit row with who/what/when. Scores are never silently mutated; corrections create a new attempt, never overwrite.

## Honest note
Per-user RLS and account security are NOT done in v1 — the app is openly demoable. Before real student data is stored, complete the lock-down sprint. If unsure about RLS correctness, stop and get a human to verify the policies.