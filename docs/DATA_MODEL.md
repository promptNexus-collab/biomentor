# BioMentor — Data Model

## topics
| Field | Type |
|---|---|
| id | uuid PK |
| name | text |
| subject | text (Biology / Botany) |
| description | text |
| icon | text (emoji or image key) |
| difficulty | text (Beginner/Intermediate/Advanced) |
| created_at | timestamptz |

## lessons
| Field | Type |
|---|---|
| id | uuid PK |
| topic_id | uuid → topics |
| user_id | uuid (nullable, for future owner-scoping) |
| content | text (markdown lesson body) |
| visual_summary | text (simple diagram/explanation description) |
| source | text (AI model or "seed") |
| confidence | numeric |
| review_status | text default 'unreviewed' |
| created_at | timestamptz |

## quizzes
| Field | Type |
|---|---|
| id | uuid PK |
| lesson_id | uuid → lessons |
| topic_id | uuid → topics |
| questions | jsonb (array of {question, options[], correct_index, explanation}) |
| source | text |
| confidence | numeric |
| review_status | text default 'unreviewed' |
| created_at | timestamptz |

## quiz_attempts
| Field | Type |
|---|---|
| id | uuid PK |
| quiz_id | uuid → quizzes |
| user_id | uuid (nullable) |
| answers | jsonb (array of selected indices) |
| score | numeric (e.g. 0.67) |
| total_questions | int |
| created_at | timestamptz |

## study_plans
| Field | Type |
|---|---|
| id | uuid PK |
| quiz_attempt_id | uuid → quiz_attempts |
| topic_id | uuid → topics |
| recommendations | jsonb (array of {step, reason}) |
| source | text |
| confidence | numeric |
| review_status | text default 'unreviewed' |
| created_at | timestamptz |

## Relationships
```
topics 1—* lessons 1—* quizzes 1—* quiz_attempts 1—1 study_plans
```

## RLS / Permissions (v1 — demo-open)
All tables: permissive select/insert/update for anonymous demo. Lock-down sprint adds `auth.uid() = user_id` scoping on lesson/quiz/attempt/plan tables.

## AI Fields
`lessons.content`, `lessons.visual_summary`, `quizzes.questions`, `study_plans.recommendations` are AI-generated → each table carries `source`, `confidence`, `review_status`.