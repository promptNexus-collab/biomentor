# BioMentor — Data Model

All tables: `id uuid pk`, `created_at`, nullable `user_id` (owner-scoping added at lock-down), RLS enabled (v1 permissive).

## subjects
- id, name, description. Has many topics. RLS: v1 open.

## topics
- id, subject_id (fk→subjects), name, description, difficulty. Belongs to subject; has many lessons.

## lessons
- id, user_id, topic_id (fk→topics), title, content (AI), visual_summary (AI)
- AI meta: `source`, `confidence`, `review_status` (default 'unreviewed')
- Has many quiz_questions, quiz_attempts, study_steps.

## quiz_questions
- id, user_id, lesson_id (fk→lessons), question, options (jsonb array), correct_answer, explanation (AI)
- AI meta: `source`, `confidence`, `review_status`

## quiz_attempts
- id, user_id, lesson_id (fk→lessons), score (numeric), total (numeric), answers (jsonb: question_id→answer). Scores never overwritten.

## study_steps
- id, user_id, lesson_id (fk→lessons), title, description, rationale, order_index (int)
- AI meta: `source`, `confidence`, `review_status`

## AI fields convention
Every AI-generated value carries `source` (e.g. 'seed', 'openai'), `confidence` (0-1), `review_status` ('unreviewed'/'approved'/'rejected').

## Later (not in migration)
students/teachers profiles, courses, assignments, attendance, parent_feedback, messages.