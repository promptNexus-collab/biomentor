# BioMentor — Test Plan

## v1 Success Scenario (manual)
1. Open app → confirm topic grid loads with 5+ topics, no login required.
2. Click "Photosynthesis" → see topic detail page with "Generate Lesson" button.
3. Click "Generate Lesson" → loading state shows → lesson markdown + visual summary renders.
4. Confirm lesson is saved (refresh page → lesson persists).
5. Click "Take Quiz" → quiz generates 3-5 questions with options.
6. Answer questions (answer at least one wrong on purpose).
7. Submit quiz → see instant score (e.g. 2/3) with per-question correct/incorrect.
8. See recommended next steps (e.g. "Review light-dependent reactions").
9. Navigate to "My Progress" → lesson, quiz attempt, and score are listed.

## Empty / Error Cases
- **No topics returned from DB:** Topic grid shows empty state: "No topics available yet. Check back soon."
- **AI lesson generation fails:** Show error message: "Couldn't generate the lesson. Try again." Retry button visible. Pre-seeded demo lesson still accessible.
- **AI quiz generation fails:** Show error: "Quiz generation failed. Please retry." Pre-seeded demo quiz available as fallback.
- **Quiz submission with no answers selected:** Disable submit button until all questions answered. Tooltip: "Please answer all questions."
- **Network timeout during generation:** Show spinner for max 30s, then error with retry.
- **DB write fails:** Show toast: "Something went wrong saving your progress. Please retry." No silent failure.

## State Coverage Checklist
- [ ] Loading state on topic grid, lesson gen, quiz gen, quiz submit
- [ ] Empty state on topic grid (no topics), progress page (no attempts)
- [ ] Error state on AI generation failure, DB failure
- [ ] Ready/ready state on all screens with seeded data
- [ ] Partial state: quiz answered some-but-not-all questions (submit disabled)