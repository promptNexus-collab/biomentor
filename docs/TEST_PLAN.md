# BioMentor — Test Plan

## v1 success scenario (manual)
1. Open app (logged out) → Subjects shows Biology, Botany, Microbiology.
2. Click Botany → Topics shows Photosynthesis, Plant Reproduction, Plant Transport.
3. Click Photosynthesis → click "Generate lesson".
4. Lesson appears with title, content, visual summary (AI, flagged unreviewed).
5. Quiz shows 3 questions with options.
6. Answer questions → Submit.
7. Score shown (e.g. 2/3) with per-question correct answer + explanation.
8. Recommended next steps list appears (2-3 items).
9. Refresh page → score, answers, steps persist.

## Empty states
- New topic with no lesson → "No lesson yet. Generate one." button; no blank cards.
- Subject page with 0 topics → "Topics coming soon."

## Error states
- AI generation fails → error card + "Retry" + offer to view seeded fallback lesson.
- Submit quiz with no answers → block + message "Answer all questions."
- DB read fails → error state, not blank screen.

## Permission / basic
- No API keys visible in browser network/client bundle.
- Delete a lesson → confirms → row gone from DB + UI.