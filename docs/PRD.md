# BioMentor — AI Biology & Botany Learning Platform

## Problem
Students struggle with biology and botany concepts; teachers lack tools to create personalized learning materials quickly.

## Target User
Students (primary), teachers, and parents. v1 focuses on students only; teacher/parent features are later.

## Core Objects
- **Topic**: Biology/Botany subject area (e.g. Cell Structure, Photosynthesis)
- **Lesson**: AI-generated personalized lesson for a topic
- **Quiz**: AI-generated quiz with questions tied to a lesson
- **QuizAttempt**: Student's answers + score for a quiz
- **StudyPlan**: Recommended next steps based on quiz results

## MVP (v1) — Checklist
- [ ] Browse and select a Biology/Botany topic from seeded list
- [ ] Generate an AI lesson with visual explanation for selected topic
- [ ] Generate a short quiz (3-5 questions) for that lesson
- [ ] Take the quiz, submit answers, get instant score
- [ ] Receive recommended next study steps based on score
- [ ] All persists to database; works without login

## Non-goals (v1)
- Login / signup / auth
- Teacher lesson builder / worksheets
- Parent monitoring dashboard
- Attendance tracking
- Student-teacher messaging
- Payment / billing
- Spaced repetition / adaptive scheduling

## Success Criteria
A student opens the app (no login), picks "Photosynthesis," sees a personalized lesson with a simple visual diagram explanation, completes a 3-question quiz, gets an instant score (e.g. 2/3), and sees recommended next steps like "Review light-dependent reactions." The entire flow works in one session and all data is saved.