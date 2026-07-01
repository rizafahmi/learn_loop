---
id: ll-pl9c
status: open
deps: [ll-q327, ll-fe0v]
links: []
created: 2026-07-01T12:41:16Z
type: task
priority: 2
assignee: Riza Fahmi
---
# Cover MVP behavior with automated tests

Add or complete automated test coverage for the PRD and BDD_SPEC core behavior so the MVP can be verified with the project test suite. This is the final proof slice after the feature slices are implemented.

## Acceptance Criteria

- [ ] First public sign-up creates Learner and Admin access.
- [ ] Later public sign-ups create Learner access but not Admin access.
- [ ] Non-Admins cannot access Admin screens.
- [ ] Admins can assign Admin access to another User from the User page.
- [ ] Admins can create, edit, publish, and archive content according to lifecycle rules, with content shown in creation-time order.
- [ ] Invalid Draft Courses cannot be Published.
- [ ] Draft and Archived Courses are hidden from Learners who are not enrolled.
- [ ] Published Courses appear in Explore Courses.
- [ ] Starting a Course creates exactly one Enrollment per Learner and Course.
- [ ] Learners cannot start Draft or Archived Courses that are unavailable to them.
- [ ] Lesson bodies are hidden before Enrollment and visible after Enrollment.
- [ ] Learners cannot view another Learner's enrolled Lesson body.
- [ ] Learners cannot update another Learner's Lesson Progress.
- [ ] Learners can mark Lessons complete and incomplete.
- [ ] Progress percentage, Chapter completion, and Course completion derive from Lesson completion.
- [ ] Resume Point uses the first incomplete Lesson in creation-time Course Order.
- [ ] Adding later Lessons updates Resume Point and previous/next navigation without losing completed Lesson Progress when applicable.
- [ ] Archived Courses remain available to Learners who already have an Enrollment.
- [ ] Published Chapters and Lessons cannot be deleted in the MVP.
- [ ] mix test passes.
