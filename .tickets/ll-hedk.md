---
id: ll-hedk
status: open
deps: [ll-s77i, ll-f93y]
links: []
created: 2026-07-01T12:41:16Z
type: feature
priority: 2
assignee: Riza Fahmi
---
# Build course overview and enrollment flow

Build the Course Overview and Start Course flow so Learners can inspect a Course outline before enrollment, start Published Courses, and return to enrolled or completed Courses.

This slice should create exactly one Enrollment per Learner and Course, then route the Learner to the first Lesson in creation-time Course Order after starting.

Decisions baked in from the PRD:
- Course Order is by `created_at` for the MVP.
- Unavailable Draft or Archived Course access redirects with a flash.

## Acceptance Criteria

- [ ] A Learner can view Course title, short description, and ordered Chapter/Lesson outline before Enrollment.
- [ ] Lesson bodies are hidden before Enrollment.
- [ ] Learners cannot view Draft Course overviews.
- [ ] Learners without Enrollment cannot view Archived Course overviews.
- [ ] Enrolled Learners can view Archived Course overviews.
- [ ] Not-enrolled Learners see a Start Course action.
- [ ] Starting a Course creates exactly one Enrollment for that Learner and Course.
- [ ] Starting a Course is idempotent and does not create duplicate Enrollments.
- [ ] Learners cannot start Draft Courses.
- [ ] Learners cannot newly start Archived Courses.
- [ ] Unavailable Course access redirects with a flash.
- [ ] Starting a Course sends the Learner to the first Lesson in creation-time Course Order.
- [ ] Enrolled Learners see a Resume Course action.
- [ ] Completed Learners see a Review Course action.
- [ ] Automated tests cover overview visibility, Enrollment uniqueness, and start/resume/review actions.
