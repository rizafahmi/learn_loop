---
id: ll-f93y
status: open
deps: [ll-jpqf]
links: []
created: 2026-07-01T12:41:15Z
type: feature
priority: 2
assignee: Riza Fahmi
---
# Build learner dashboard with Continue Learning and Explore Courses

Build the Learner Dashboard with Continue Learning and Explore Courses sections so Learners can discover available Courses and resume Courses they have already started.

Decisions baked in from the PRD:
- Empty-state copy can be simple implementation copy for MVP.
- Draft Courses are hidden from Learners.
- Archived Courses are hidden from new Learners but remain available to already-enrolled Learners.
- Progress percentage is rounded down to a whole percent.
- Unavailable Course access redirects with a flash.

## Acceptance Criteria

- [ ] Learners can view a dashboard after sign-up/sign-in.
- [ ] Continue Learning shows enrolled Courses.
- [ ] Continue Learning shows progress percentage rounded down to a whole percent.
- [ ] Completed Courses are shown with completed state or lower visual priority.
- [ ] Explore Courses shows Published Courses the Learner has not started.
- [ ] Draft Courses are hidden from Explore Courses.
- [ ] Archived Courses are hidden from Explore Courses for not-enrolled Learners.
- [ ] Started Courses are not duplicated in Explore Courses.
- [ ] Course discovery does not expose category, tag, difficulty, duration, or search filters in the MVP.
- [ ] Empty states are shown when there are no Enrollments or no available Published Courses.
- [ ] Automated tests cover dashboard visibility and empty states.
