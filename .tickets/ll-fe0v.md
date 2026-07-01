---
id: ll-fe0v
status: open
deps: [ll-21un]
links: []
created: 2026-07-01T12:41:16Z
type: feature
priority: 2
assignee: Riza Fahmi
---
# Implement resume point and derived completion state

Implement the Progress calculations that turn individual Lesson completion into Chapter completion, Course completion, dashboard progress, and Resume Point behavior.

Decisions baked in from the PRD:
- Resume Point is the first incomplete Lesson in current Course Order.
- Course completion means all Lessons in all Chapters are complete.
- Chapter completion means all Lessons in the Chapter are complete.
- Progress percentage is completed Lessons divided by total Lessons, rounded down to a whole percent.
- Adding later Lessons preserves completed Lesson Progress and recalculates Resume Point/navigation using creation-time Course Order.

## Acceptance Criteria

- [ ] Chapter completion derives from all Lessons in the Chapter being complete.
- [ ] Course completion derives from all Chapters/Lessons being complete.
- [ ] Progress percentage is rounded down to a whole percent.
- [ ] Resume Course sends the Learner to the first incomplete Lesson in creation-time Course Order.
- [ ] Review Course is used when all Lessons are complete.
- [ ] Adding a Lesson to a Published Course gives enrolled Learners one more incomplete Lesson.
- [ ] Adding later Lessons changes Resume Point and previous/next navigation without losing completed Progress when applicable.
- [ ] Automated tests cover derived completion, progress percentage, resume point, added lessons, and creation-time ordering behavior.

