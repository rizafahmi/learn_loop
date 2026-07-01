# Learn Loop PRD

## Summary

Learn Loop is a multi-course learning management web app where Learners follow Courses at their own pace. Admins manage course content through basic web screens, while Learners discover Published Courses, start them, resume from their next suggested Lesson, and manually track Lesson completion.

## Goals

- Let Learners browse available Courses and start learning quickly.
- Let Learners progress through Lessons at their own pace without enforced locks.
- Let Learners clearly see what they have started, completed, and should resume next.
- Let Admins create and maintain Course, Chapter, and Lesson content without developer involvement.
- Keep the MVP simple enough to ship with Phoenix LiveView and SQLite.

## Non-goals for MVP

- Paid enrollment, approvals, cohorts, deadlines, seats, or certificates.
- Instructor-owned Courses or team/organization permissions.
- Quizzes, assignments, comments, notes, bookmarks, videos, uploads, or embedded exercises.
- Course categories, tags, search, difficulty levels, estimated durations, or recommendations.
- Content versioning, review workflows, scheduled publishing, or learner-specific content snapshots.
- Enforced lesson unlocking or prerequisite logic.

## Users and roles

### Learner

A Learner follows Lessons and accumulates Progress.

Learners can:

- Sign up publicly.
- View the Learner Dashboard.
- Discover Published Courses.
- View a Course Overview before enrollment.
- Start a Course, creating an Enrollment.
- Resume enrolled Courses.
- View Lesson bodies for enrolled Courses.
- Mark Lessons complete or incomplete.
- Review completed Courses.

### Admin

An Admin manages course content.

Admins can:

- Create and edit Courses.
- Create and edit Chapters within Courses.
- Create and edit Lessons within Chapters.
- Manage Course, Chapter, and Lesson content shown in creation order.
- Publish valid Draft Courses.
- Archive Published Courses.
- Assign Admin access to Users.

The first registered User automatically receives Admin access. Admins can assign Admin access to other Users from the User page. A User can be a Learner, an Admin, or both.

## Core concepts

- **Course**: A complete learning experience with a title and short description, made of ordered Chapters.
- **Chapter**: A named section of a Course made of ordered Lessons.
- **Lesson**: The smallest learning unit whose completion is tracked for a Learner, consisting of a title and rich text body.
- **Enrollment**: The Learner-specific relationship created when a Learner starts a Course.
- **Progress**: Learner-specific completion state across Lessons in a Course.
- **Resume Point**: The first incomplete Lesson in Course Order.

## Product flows

### Public sign-up

1. Visitor signs up.
2. App creates a User with Learner access.
3. Learner lands on the Learner Dashboard.

### Learner dashboard

The Learner Dashboard has two sections:

1. **Continue Learning**
   - Shows enrolled Courses.
   - Shows Progress percentage.
   - Provides Resume Course action.
   - Shows completed Courses with a completed state or lower visual priority.

2. **Explore Courses**
   - Shows Published Courses the Learner has not started.
   - Shows Course title and short description.
   - Provides Start Course action.

### Course overview

A Course Overview shows:

- Course title.
- Short description.
- Ordered Chapter and Lesson outline.
- Progress if the Learner is already enrolled.
- Primary action:
  - Not enrolled: Start Course.
  - Enrolled: Resume Course.
  - Completed: Review Course.

Before Enrollment, a Learner can see the outline but cannot view Lesson bodies. After Enrollment, Lessons are clickable and freely navigable.

### Start course

1. Learner clicks Start Course from the dashboard or Course Overview.
2. App creates an Enrollment for that Learner and Course.
3. App sends the Learner to the first Lesson in Course Order.

### Resume course

1. Learner clicks Resume Course.
2. App calculates the Resume Point as the first incomplete Lesson in Course Order.
3. App sends the Learner to that Lesson.
4. If all Lessons are complete, the Course is considered complete and the action becomes Review Course.

### Lesson page

The Lesson page has three regions:

1. **Course sidebar**
   - Chapters and Lessons in Course Order.
   - Completion checkmarks.
   - Current Lesson highlighted.

2. **Lesson content**
   - Lesson title.
   - Rich text body with headings, paragraphs, lists, links, and code blocks.

3. **Lesson actions/navigation**
   - Mark complete / Mark incomplete.
   - Previous Lesson.
   - Next Lesson.
   - Back to dashboard or Course Overview.

Learners can open any Lesson in an enrolled Course. There is no enforced lesson locking.

## Admin content management

### Course management

Admins can create Courses with:

- Title.
- Short description.
- Lifecycle state: Draft, Published, or Archived.
- Manual Course Order.

Courses do not include categories, tags, difficulty levels, estimated durations, or search fields in the MVP.

### Chapter management

Admins can create ordered Chapters within a Course. A Chapter has:

- Title.
- Creation-time order within its Course.

### Lesson management

Admins can create ordered Lessons within a Chapter. A Lesson has:

- Title.
- Rich text body.
- Creation-time order within its Chapter.

### Publishing rules

- New Courses start as Draft.
- Learners cannot discover Draft Courses.
- A Course can be Published only when it has at least one Chapter and every Chapter has at least one Lesson.
- Published Courses are discoverable by Learners.
- Admin edits to Published Courses are visible to Learners immediately.

### Archiving and deletion rules

- Draft content can be deleted.
- Published Courses cannot be deleted; they can be Archived.
- Archived Courses are hidden from new Learners.
- Archived Courses remain available to Learners who already have an Enrollment.
- Published Courses, Chapters, and Lessons are not versioned in the MVP.

## Progress rules

- Progress is tracked per Learner per Lesson.
- Lesson completion is manual.
- Learners can mark a Lesson complete.
- Learners can mark a completed Lesson incomplete.
- A Chapter is complete for a Learner when all of its Lessons are complete.
- A Course is complete for a Learner when all of its Chapters are complete.
- If an Admin adds a Lesson to a Published Course, enrolled Learners now have one more incomplete Lesson.
- If an Admin reorders Lessons, completed Lessons remain complete and Resume Point recalculates from the new Course Order.

## Data model draft

Minimum persistent entities:

- users
  - email
  - authentication fields
  - learner/admin role flags or equivalent role model

- courses
  - title
  - short_description
  - lifecycle_state: draft, published, archived
  - position

- chapters
  - course_id
  - title
  - position

- lessons
  - chapter_id
  - title
  - body
  - position

- enrollments
  - user_id
  - course_id
  - timestamps

- lesson_progress
  - user_id
  - lesson_id
  - completed_at nullable timestamp

Useful constraints:

- One Enrollment per Learner per Course.
- One Lesson Progress record per Learner per Lesson.
- Ordered records have positions scoped to their parent:
  - Courses globally.
  - Chapters within Course.
  - Lessons within Chapter.

## Technology

- Elixir 1.18+
- Phoenix 1.8+
- Phoenix LiveView
- SQLite
- open-props for CSS tokens
- ExUnit and PhoenixTest for testing
- Credo and Dialyxir as later quality checks

## Resolved MVP implementation decisions

These decisions are fixed for the first release so implementation can proceed without inventing product behavior.

### Authentication and roles

- Use Phoenix's generated email/password authentication for public sign-up and sign-in.
- Public sign-up always creates a User with Learner access.
- The first registered User automatically receives Admin access.
- Admins can assign Admin access to other Users from the User page.
- Public sign-up after the first registered User creates Learner access without Admin access.
- A Learner can view and update only their own Enrollment and Progress records.
- Admin access allows content management but does not automatically create Enrollments or Learner Progress.

### Rich text Lessons

- Lesson bodies are authored as Markdown stored as text.
- Markdown rendering must support headings, paragraphs, lists, links, and fenced code blocks.
- Rendered Lesson body HTML must be sanitized before display.
- File uploads, embedded videos, custom components, and WYSIWYG editing are out of scope for the MVP.

### Content ordering

- Manual ordering controls are out of scope for the MVP.
- Drag-and-drop ordering is out of scope for the MVP.
- Course, Chapter, and Lesson lists are ordered by `created_at` for the MVP.
- Course Order must be stable and scoped as follows:
  - Courses globally.
  - Chapters within a Course.
  - Lessons within a Chapter.

### Published content deletion

- Draft Courses can be deleted.
- Chapters and Lessons in Draft Courses can be deleted.
- Published Courses cannot be deleted; they can be Archived.
- Chapters and Lessons in Published or Archived Courses cannot be deleted in the MVP.
- Admins can edit or reorder Chapters and Lessons in Published Courses, and those changes are visible to enrolled Learners immediately.
- If a completed Lesson is edited, existing Lesson Progress remains complete.

### Progress persistence

- Lesson Progress records are created lazily when a Learner marks a Lesson complete.
- Absence of a Lesson Progress record means the Lesson is incomplete for that Learner.
- Marking a Lesson incomplete clears or removes that Learner's completed state for that Lesson.
- Progress percentage is calculated as completed Lessons divided by total Lessons in the Course.
- If a Course has no Lessons, it cannot be Published and has no Learner-facing Progress percentage.

### Empty states

- If a Learner has no Enrollments, Continue Learning shows an empty state that directs them to Explore Courses.
- If there are no Published Courses available to start, Explore Courses shows an empty state instead of an empty list.
- If an Admin has not created any Courses, the Admin Course list shows an empty state with a Create Course action.

### Minimum operational visibility

- Course, Chapter, and Lesson records keep timestamps.
- Enrollment and Lesson Progress records keep timestamps.
- First-User Admin assignment and Admin-managed User promotion should be covered by automated tests.

## Implementation proof

The MVP is not complete until automated tests cover the core behavior described in this PRD and `BDD_SPEC.md`.

Required test coverage:

- Public sign-up creates Learner access, gives Admin access only to the first registered User, and does not give Admin access to later sign-ups.
- Non-Admins cannot access Admin screens.
- Admins can assign Admin access to another User from the User page.
- Admins can create, edit, order, publish, and archive content according to lifecycle rules.
- Invalid Draft Courses cannot be Published.
- Draft and Archived Courses are hidden from Learners who are not enrolled.
- Published Courses appear in Explore Courses.
- Starting a Course creates exactly one Enrollment per Learner and Course.
- Lesson bodies are hidden before Enrollment and visible after Enrollment.
- Learners can mark Lessons complete and incomplete.
- Progress percentage, Chapter completion, and Course completion derive from Lesson completion.
- Resume Point uses the first incomplete Lesson in current Course Order.
- Reordering Lessons changes Resume Point and previous/next navigation without losing completed Lesson Progress.
- Archived Courses remain available to Learners who already have an Enrollment.
- Published Chapters and Lessons cannot be deleted in the MVP.

Minimum verification command:

```sh
mix test
```

## MVP acceptance criteria

### Learner

- A visitor can sign up and become a Learner.
- The first registered User automatically becomes an Admin.
- Later registered Users do not automatically become Admins.
- A Learner can see Continue Learning and Explore Courses.
- A Learner can start a Published Course.
- Starting a Course creates an Enrollment.
- A Learner can view a Course Overview before Enrollment.
- A Learner cannot view Lesson bodies before Enrollment.
- An enrolled Learner can view any Lesson in the Course.
- A Learner can mark Lessons complete and incomplete.
- A Learner can resume the first incomplete Lesson in Course Order.
- Completed Chapter and Course states derive from Lesson completion.

### Admin

- An Admin can access Admin screens.
- An Admin can assign Admin access to another User from the User page.
- An Admin can create and edit Courses, Chapters, and Lessons.
- Courses, Chapters, and Lessons are shown in `created_at` order.
- A new Course starts as Draft.
- A Draft Course is hidden from Learners.
- An Admin can Publish only structurally valid Courses.
- A Published Course appears in Explore Courses.
- An Admin can Archive a Published Course.
- An Archived Course is hidden from new Learners but available to already-enrolled Learners.

## Open questions

These should be resolved before or during implementation planning:

1. What exact copy should empty states and validation messages use?
2. Should Markdown links get stricter handling, such as limiting URL schemes or adding external-link attributes?
