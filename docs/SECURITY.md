# BioMentor — Security

## Secret Handling
- OpenAI API key stored in Supabase Edge Function env vars / Vercel env vars only — never in client code, never in `NEXT_PUBLIC_*`.
- All AI calls happen server-side (server actions or route handlers). Client never sees the API key.

## Permission Model (v1 → target)
**v1 (demo):** All tables permissive — anonymous users can browse topics, generate lessons, take quizzes. No login required.
**Target (lock-down sprint):**
- `lessons`, `quizzes`, `quiz_attempts`, `study_plans` scoped by `auth.uid() = user_id`.
- `topics` remain readable by all (shared catalog).
- Students see only their own lessons/attempts/plans.
- Teachers (future role) can read class-related data.
- Parents (future role) can read their child's progress (read-only).

## Approved-Tools Rule
Only named tools are callable by the AI: `generate_lesson`, `generate_quiz`, `score_quiz`, `generate_study_plan`. No generic SQL execution, no raw API calls, no file system access.

## Audit Principle
Every AI generation and quiz submission is logged to `audit_logs` with action name, actor, target, tool, status, and timestamp. This survives refresh and provides a traceable history of what the AI produced and when.