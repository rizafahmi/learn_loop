---
id: ll-jpqf
status: open
deps: [ll-8av3]
links: []
created: 2026-07-01T12:41:15Z
type: feature
priority: 2
assignee: Riza Fahmi
---
# Model ordered course content lifecycle

Add the persistent content model and lifecycle rules for Courses, Chapters, and Lessons. This slice should support creation-time ordered course content end-to-end at the domain/data layer so Admin and Learner screens can rely on stable creation-time Course Order.

Decisions baked in from the PRD:
- Courses have Draft, Published, and Archived lifecycle states.
- New Courses start as Draft.
- Course order is global by `created_at`; Chapter order is scoped to Course by `created_at`; Lesson order is scoped to Chapter by `created_at`.
- Draft Courses, Chapters, and Lessons can be deleted.
- Published Courses cannot be deleted and can only be Archived.
- Chapters and Lessons in Published or Archived Courses cannot be deleted in MVP.
- Admin edits to Published Courses are visible immediately; no content versioning.

## Acceptance Criteria

- [ ] Courses, Chapters, and Lessons can be persisted with timestamps.
- [ ] Course, Chapter, and Lesson ordering is stable by `created_at` and scoped correctly.
- [ ] Draft Courses can be created and edited.
- [ ] Structurally invalid Draft Courses cannot be Published.
- [ ] A Course can be Published only when it has at least one Chapter and every Chapter has at least one Lesson.
- [ ] Published Courses can be Archived.
- [ ] Deletion rules match the PRD lifecycle constraints.
- [ ] Automated tests cover lifecycle validation, ordering, publish/archive, and deletion rules.
