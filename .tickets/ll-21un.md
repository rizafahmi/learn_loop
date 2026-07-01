---
id: ll-21un
status: open
deps: [ll-hedk]
links: []
created: 2026-07-01T12:41:16Z
type: feature
priority: 2
assignee: Riza Fahmi
---
# Build enrolled lesson experience and progress tracking

Build the enrolled Lesson page so Learners can read Lesson content, navigate the Course outline, and manually track Lesson completion.

Decisions baked in from the PRD:
- Learners can open any Lesson in an enrolled Course.
- There is no enforced Lesson locking.
- Lesson Progress is created lazily when a Learner marks a Lesson complete.
- Absence of Lesson Progress means incomplete.
- Marking incomplete clears or removes the completed state.

## Acceptance Criteria

- [ ] Enrolled Learners can view any Lesson body in the Course.
- [ ] Not-enrolled Learners cannot view Lesson bodies.
- [ ] Lesson page shows Course sidebar with Chapters and Lessons in creation-time Course Order.
- [ ] Current Lesson is highlighted.
- [ ] Completion checkmarks are shown.
- [ ] Learners can mark Lessons complete.
- [ ] Learners can mark completed Lessons incomplete.
- [ ] Learners cannot update another Learner's Lesson Progress.
- [ ] Previous Lesson, Next Lesson, and back navigation work in creation-time Course Order.
- [ ] First Lesson has no Previous Lesson action.
- [ ] Last Lesson has no Next Lesson action.
- [ ] Automated tests cover access control, completion toggling, sidebar state, and navigation.
