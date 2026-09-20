# BioMentor — Intelligence Layer

## Messy inputs
Topic name (free text), optional difficulty + student's last score. No structured profile yet.

## Auto-structure schema (lesson generation response)
```json
{
  "title": "Photosynthesis: Light into Life",
  "content": "...structured lesson markdown...",
  "visual_summary": "Chloroplast captures sunlight; splits H2O; makes glucose + O2",
  "quiz": [
    {"question": "...", "options": ["a","b","c","d"], "correct_answer": "b", "explanation": "..."}
  ],
  "next_steps": [
    {"title": "...", "description": "...", "rationale": "score < 60%"}
  ]
}
```

## Events to track
- lesson_generated (topic_id, source, confidence)
- quiz_started, quiz_submitted (score, total)
- study_step_viewed, study_step_completed (later)

## Scoring rules (v1, rule-based)
- quiz score = correct / total × 100
- next-step ranking: score ≥ 80% → advanced topic (difficulty up one level); 50-79% → revisit subtopics; <50% → foundational review + same-topic retry.

## What gets ranked
Next steps ordered by: relevance to weak quiz questions first, then difficulty progression.

## v1 vs later
v1: rule-based scoring + AI generation. Later: per-student mastery model, spaced repetition, adaptive difficulty from history.