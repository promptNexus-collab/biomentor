# BioMentor — Agentic Layer

## Draftable Actions (low risk — auto)
- **Generate lesson** — AI drafts lesson content + visual summary; saved to DB with `review_status = 'unreviewed'`.
- **Generate quiz** — AI drafts quiz questions; saved with `review_status = 'unreviewed'`.
- **Generate study plan** — AI drafts recommendations; saved with `review_status = 'unreviewed'`.
- **Score quiz** — rule-based computation, no approval needed.

## Executable-After-Approval Actions (medium risk)
- **Re-generate lesson** — student/teacher requests a rewrite; requires click confirmation.
- **Publish lesson as shared resource** — (later) teacher approves AI lesson for class use.

## Human-Only Actions (high risk)
- **Delete a lesson or quiz** — permanent; human-only.
- **Edit quiz correct answers** — human must override AI; no auto-edit.

## Named Tools
- `generate_lesson(topic_id)` → lesson draft
- `generate_quiz(lesson_id)` → quiz draft
- `score_quiz(attempt_id)` → score
- `generate_study_plan(attempt_id)` → recommendations draft

No raw `run_any` or `send_any` — only these named tools.

## Audit Log Fields
| Field | Type |
|---|---|
| id | uuid PK |
| action | text (e.g. "generate_lesson") |
| actor | text (user_id or "anonymous") |
| target_id | uuid |
| tool_name | text |
| status | text (success / error) |
| metadata | jsonb |
| created_at | timestamptz |

## v1 vs Later
**v1:** All low-risk draftable actions (auto) + rule-based scoring. No approval queues.
**Later:** Medium-risk re-generation with confirmation UI, teacher approval workflow for publishing, human-only delete/edit controls.