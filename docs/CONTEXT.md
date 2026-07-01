# Learning Management

A web app where learners move through structured learning content at their own pace. This context captures the domain language for organizing content and tracking learner progress.

## Language

**Course**:
A complete learning experience with a title and short description, made of ordered chapters.
_Avoid_: Program, curriculum

**Draft Course**:
A course that Admins can edit but Learners cannot see.
_Avoid_: Unpublished course, hidden course

**Published Course**:
A course that is visible to Learners.
_Avoid_: Live course, active course

**Archived Course**:
A course hidden from new Learners but still available to already-enrolled Learners.
_Avoid_: Deleted course, inactive course

**Chapter**:
A named section of a course made of ordered lessons.
_Avoid_: Module, unit

**Lesson**:
The smallest learning unit whose completion is tracked for a learner, consisting of a title and rich text body.
_Avoid_: Class, page, step

**Learner**:
A user who follows lessons and accumulates progress.
_Avoid_: Student, user when discussing learning behavior

**Admin**:
A user who manages course content.
_Avoid_: Instructor, teacher, author

**User**:
A signed-in person who can be a Learner, an Admin, or both.
_Avoid_: Account when discussing roles

**Progress**:
The learner-specific completion state across lessons in a course.
_Avoid_: Status, advancement

**Enrollment**:
The learner-specific relationship created when a learner starts a course.
_Avoid_: Registration, signup

**Resume Point**:
The next suggested lesson for a learner in an enrolled course.
_Avoid_: Bookmark, current lesson

**Learner Dashboard**:
The signed-in learner's home view, split between continuing enrolled courses and exploring available courses.
_Avoid_: Home page, portal

**Course Order**:
The Admin-controlled sequence used to display courses, chapters, and lessons.
_Avoid_: Sort order, position

**Course Overview**:
The learner-facing view of a course's description, outline, and progress.
_Avoid_: Course landing page, syllabus

## Relationships

- A **Course** contains one or more ordered **Chapters**
- A **Chapter** contains one or more ordered **Lessons**
- A **User** can be a **Learner**, an **Admin**, or both
- Public sign-up creates a **Learner**
- **Admin** access is assigned manually
- An **Admin** can create and edit **Courses**, **Chapters**, and **Lessons**
- An **Admin** controls **Course Order** for Courses, Chapters, and Lessons
- A **Course** is a **Draft Course**, **Published Course**, or **Archived Course**
- A **Published Course** must have at least one **Chapter**, and each **Chapter** must have at least one **Lesson**
- Admin edits to a **Published Course** are visible to Learners immediately
- A **Learner** can only discover and start **Published Courses**
- The **Learner Dashboard** shows enrolled **Courses** separately from **Published Courses** the **Learner** has not started
- A **Course Overview** shows the course description and ordered outline before Enrollment
- Lesson bodies require an **Enrollment** to view
- **Courses** do not have categories, tags, difficulty levels, estimated durations, or search fields in the MVP
- An **Archived Course** remains available to Learners who already have an **Enrollment**
- Draft content can be deleted, but Published Courses are archived instead of deleted
- A **Learner** can have **Enrollments** in many **Courses**
- An **Enrollment** belongs to exactly one **Learner** and one **Course**
- A **Learner** has **Progress** for individual **Lessons**
- A **Resume Point** is the first incomplete **Lesson** in Course Order
- A **Learner** can view any **Lesson** in an enrolled **Course** without unlocking it first
- A **Chapter** is complete for a **Learner** when all of its **Lessons** are complete
- A **Course** is complete for a **Learner** when all of its **Chapters** are complete

## Example dialogue

> **Dev:** "If a learner finishes three lessons in a five-lesson chapter, is the chapter complete?"
> **Domain expert:** "No — progress is tracked per lesson, and the chapter is complete only after all five lessons are complete."

## Flagged ambiguities

- "user" can mean any account holder, but learning progress belongs to a **Learner**.
- "admin managed" means **Admins** manage course content through basic web screens, not seed data or instructor-owned publishing.
