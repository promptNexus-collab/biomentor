create table if not exists subjects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  name text not null,
  description text
);
alter table subjects enable row level security;
drop policy if exists "subjects_v1_read" on subjects;
create policy "subjects_v1_read" on subjects for select using (true);
drop policy if exists "subjects_v1_write" on subjects;
create policy "subjects_v1_write" on subjects for all using (true) with check (true);
insert into subjects (id, name, description) values
  ('a1111111-1111-1111-1111-111111111111', 'Biology', 'Living organisms: structure, function, growth'),
  ('a2222222-2222-2222-2222-222222222222', 'Botany', 'Plant biology and plant sciences'),
  ('a3333333-3333-3333-3333-333333333333', 'Microbiology', 'Microorganisms and their effects')
on conflict (id) do nothing;

create table if not exists topics (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  subject_id uuid references subjects(id),
  name text not null,
  description text,
  difficulty text default 'beginner'
);
alter table topics enable row level security;
drop policy if exists "topics_v1_read" on topics;
create policy "topics_v1_read" on topics for select using (true);
drop policy if exists "topics_v1_write" on topics;
create policy "topics_v1_write" on topics for all using (true) with check (true);
insert into topics (id, subject_id, name, description, difficulty) values
  ('b1111111-1111-1111-1111-111111111111', 'a2222222-2222-2222-2222-222222222222', 'Photosynthesis', 'How plants convert light into energy', 'beginner'),
  ('b2222222-2222-2222-2222-222222222222', 'a1111111-1111-1111-1111-111111111111', 'Cell Structure', 'Parts and functions of cells', 'beginner'),
  ('b3333333-3333-3333-3333-333333333333', 'a2222222-2222-2222-2222-222222222222', 'Plant Reproduction', 'How plants reproduce and spread', 'intermediate'),
  ('b4444444-4444-4444-4444-444444444444', 'a2222222-2222-2222-2222-222222222222', 'Plant Transport', 'Water and nutrient movement in plants', 'intermediate')
on conflict (id) do nothing;

create table if not exists lessons (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  topic_id uuid references topics(id),
  title text not null,
  content text,
  visual_summary text,
  source text,
  confidence numeric,
  review_status text default 'unreviewed'
);
alter table lessons enable row level security;
drop policy if exists "lessons_v1_read" on lessons;
create policy "lessons_v1_read" on lessons for select using (true);
drop policy if exists "lessons_v1_write" on lessons;
create policy "lessons_v1_write" on lessons for all using (true) with check (true);
insert into lessons (id, topic_id, title, content, visual_summary, source, confidence, review_status) values
  ('c1111111-1111-1111-1111-111111111111', 'b1111111-1111-1111-1111-111111111111', 'Photosynthesis: Light into Life', 'Plants use sunlight, water, and CO2 to make glucose and oxygen in chloroplasts. Light reactions split water; the Calvin cycle fixes CO2.', 'Sunlight enters leaf -> chloroplast splits H2O -> makes glucose + O2', 'seed', 1.0, 'approved'),
  ('c2222222-2222-2222-2222-222222222222', 'b2222222-2222-2222-2222-222222222222', 'Inside a Cell', 'Cells have a membrane, cytoplasm, nucleus, and organelles. Plant cells add a wall and chloroplasts.', 'Cell = membrane + nucleus + organelles; plant cells add wall + chloroplasts', 'seed', 1.0, 'approved'),
  ('c3333333-3333-3333-3333-333333333333', 'b3333333-3333-3333-3333-333333333333', 'How Plants Reproduce', 'Plants reproduce via seeds and vegetative parts; flowers enable pollination and fertilization.', 'Flower -> pollination -> seed -> new plant', 'seed', 1.0, 'approved')
on conflict (id) do nothing;

create table if not exists quiz_questions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  lesson_id uuid references lessons(id),
  question text not null,
  options jsonb,
  correct_answer text,
  explanation text,
  source text,
  confidence numeric,
  review_status text default 'unreviewed'
);
alter table quiz_questions enable row level security;
drop policy if exists "quiz_questions_v1_read" on quiz_questions;
create policy "quiz_questions_v1_read" on quiz_questions for select using (true);
drop policy if exists "quiz_questions_v1_write" on quiz_questions;
create policy "quiz_questions_v1_write" on quiz_questions for all using (true) with check (true);
insert into quiz_questions (id, lesson_id, question, options, correct_answer, explanation, source, confidence, review_status) values
  ('d1111111-1111-1111-1111-111111111111', 'c1111111-1111-1111-1111-111111111111', 'Where does photosynthesis occur?', '["Nucleus","Chloroplast","Mitochondria","Vacuole"]', 'Chloroplast', 'Chloroplasts contain chlorophyll that captures light.', 'seed', 1.0, 'approved'),
  ('d2222222-2222-2222-2222-222222222222', 'c1111111-1111-1111-1111-111111111111', 'What gas do plants release during photosynthesis?', '["Carbon dioxide","Oxygen","Nitrogen","Methane"]', 'Oxygen', 'O2 is released when water is split in the light reactions.', 'seed', 1.0, 'approved'),
  ('d3333333-3333-3333-3333-333333333333', 'c1111111-1111-1111-1111-111111111111', 'What do plants make for food?', '["Protein","Glucose","Fat","Salt"]', 'Glucose', 'The Calvin cycle fixes CO2 into glucose.', 'seed', 1.0, 'approved'),
  ('d4444444-4444-4444-4444-444444444444', 'c2222222-2222-2222-2222-222222222222', 'Which organelle is only in plant cells?', '["Nucleus","Chloroplast","Ribosome","Membrane"]', 'Chloroplast', 'Chloroplasts for photosynthesis are in plant cells, not animal cells.', 'seed', 1.0, 'approved')
on conflict (id) do nothing;

create table if not exists quiz_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  lesson_id uuid references lessons(id),
  score numeric,
  total numeric,
  answers jsonb
);
alter table quiz_attempts enable row level security;
drop policy if exists "quiz_attempts_v1_read" on quiz_attempts;
create policy "quiz_attempts_v1_read" on quiz_attempts for select using (true);
drop policy if exists "quiz_attempts_v1_write" on quiz_attempts;
create policy "quiz_attempts_v1_write" on quiz_attempts for all using (true) with check (true);
insert into quiz_attempts (id, lesson_id, score, total, answers) values
  ('e1111111-1111-1111-1111-111111111111', 'c1111111-1111-1111-1111-111111111111', 2, 3, '{"d1111111-1111-1111-1111-111111111111":"Chloroplast","d2222222-2222-2222-2222-222222222222":"Oxygen","d3333333-3333-3333-3333-333333333333":"Protein"}'),
  ('e2222222-2222-2222-2222-222222222222', 'c1111111-1111-1111-1111-111111111111', 3, 3, '{"d1111111-1111-1111-1111-111111111111":"Chloroplast","d2222222-2222-2222-2222-222222222222":"Oxygen","d3333333-3333-3333-3333-333333333333":"Glucose"}'),
  ('e3333333-3333-3333-3333-333333333333', 'c2222222-2222-2222-2222-222222222222', 1, 1, '{"d4444444-4444-4444-4444-444444444444":"Nucleus"}')
on conflict (id) do nothing;

create table if not exists study_steps (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  lesson_id uuid references lessons(id),
  title text not null,
  description text,
  rationale text,
  order_index int default 0,
  source text,
  confidence numeric,
  review_status text default 'unreviewed'
);
alter table study_steps enable row level security;
drop policy if exists "study_steps_v1_read" on study_steps;
create policy "study_steps_v1_read" on study_steps for select using (true);
drop policy if exists "study_steps_v1_write" on study_steps;
create policy "study_steps_v1_write" on study_steps for all using (true) with check (true);
insert into study_steps (id, lesson_id, title, description, rationale, order_index, source, confidence, review_status) values
  ('f1111111-1111-1111-1111-111111111111', 'c1111111-1111-1111-1111-111111111111', 'Review the light reactions', 'Revisit how water is split and ATP/NADPH form.', 'Score below 80% suggests gaps in light reactions.', 1, 'seed', 1.0, 'approved'),
  ('f2222222-2222-2222-2222-222222222222', 'c1111111-1111-1111-1111-111111111111', 'Try Plant Transport next', 'Move nutrients made by photosynthesis around the plant.', 'Strong score; advance to a related intermediate topic.', 2, 'seed', 1.0, 'approved'),
  ('f3333333-3333-3333-3333-333333333333', 'c2222222-2222-2222-2222-222222222222', 'Compare plant vs animal cells', 'Make a table of shared and unique organelles.', 'Reinforce the plant-only organelle concept.', 1, 'seed', 1.0, 'approved')
on conflict (id) do nothing;