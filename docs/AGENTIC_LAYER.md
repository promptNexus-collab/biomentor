# BioMentor — Agentic Layer

## Draftable (low risk — auto)
- Generate lesson content, visual summary, quiz questions, next-step recommendations. Stored with source/confidence/review_status; shown flagged `unreviewed` until teacher review (later).

## Executable-after-approval (medium)
- None in v1.

## Human-only (critical)
- Delete a lesson/quiz/attempts; modify a recorded score; any write attributed to a student. Only via explicit user action in the UI; no autonomous delete.

## Named tools
- `generate_lesson` (topic, difficulty) → lesson + quiz JSON
- `grade_quiz` (attempt_id, answers) → score (rule-based, deterministic)
- `recommend_steps` (lesson_id, score) → study_steps
No raw `run_any` / `send_any`; no arbitrary SQL from AI output.

## Audit-log fields
id, user_id, action, target_type, target_id, detail (jsonb), created_at. Logged on: lesson_generated, quiz_submitted, step_generated.

## v1 vs later
v1: tools run on demand (student triggers), deterministic grading, no approval. Later: teacher approves generated lessons before students see them (medium), auto-assign study plans (medium approval).