# BioMentor — Intelligence Layer

## Messy Inputs
- Student selects a topic → AI must generate structured lesson from topic name + difficulty.
- Quiz answers → AI must evaluate and recommend next steps from raw score + topic.

## Auto-Structure Schema (quiz question JSON)
```json
{
  "questions": [
    {
      "question": "Where does the light-dependent reaction occur?",
      "options": ["Stroma", "Thylakoid membrane", "Nucleus", "Cytoplasm"],
      "correct_index": 1,
      "explanation": "Thylakoid membranes contain chlorophyll and host the light-dependent reactions."
    }
  ]
}
```

## Events to Track
- `lesson_generated` — topic_id, lesson_id, source, confidence
- `quiz_generated` — lesson_id, quiz_id, question_count
- `quiz_attempt_submitted` — quiz_id, attempt_id, score
- `study_plan_generated` — attempt_id, plan_id

## Scoring Rules (rule-based, v1)
- Quiz score = correct answers / total questions (0.0 – 1.0)
- Mastery threshold: score ≥ 0.8 → "Mastered"
- Review threshold: 0.5 ≤ score < 0.8 → "Review needed"
- Remediate threshold: score < 0.5 → "Remediate"

## What Gets Ranked
Recommended next steps ranked by: (1) relevance to weakest quiz question's topic sub-area, (2) difficulty step-down if score < 0.5, (3) prerequisite topics.

## v1 vs Later
**v1:** AI lesson generation, quiz generation, rule-based scoring, AI next-step recommendations.
**Later:** Adaptive difficulty based on attempt history, spaced repetition scheduling, teacher override of AI content, confidence-weighted question selection.