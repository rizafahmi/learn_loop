# Learn Loop BDD Specification

This specification describes the MVP behavior for Learn Loop using Given/When/Then scenarios. It uses the domain language from `CONTEXT.md` and should guide implementation and acceptance tests.

## Feature: Public learner sign-up

As a visitor, I want to create an account so I can become a Learner and start Courses.

### Scenario: Visitor signs up as a Learner

Given I am a visitor
When I sign up with valid account details
Then a User account is created for me
And I have Learner access
And I am taken to the Learner Dashboard

### Scenario: Public sign-up does not create an Admin

Given I am a visitor
When I sign up with valid account details
Then I do not have Admin access
And I cannot access Admin screens

## Feature: Learner Dashboard

As a Learner, I want one place to continue started Courses and discover new Courses.

### Scenario: New Learner sees Continue Learning empty state

Given I am a signed-in Learner
And I have no Enrollments
When I view the Learner Dashboard
Then I see a Continue Learning section
And the Continue Learning section tells me I have not started any Courses
And it directs me to Explore Courses

### Scenario: Learner sees Explore Courses empty state when no Courses are available

Given I am a signed-in Learner
And there are no Published Courses I have not started
When I view the Learner Dashboard
Then I see an Explore Courses section
And the Explore Courses section tells me there are no Courses available to start

### Scenario: New Learner sees available Published Courses

Given I am a signed-in Learner
And there are Published Courses I have not started
When I view the Learner Dashboard
Then I see an Explore Courses section
And the Explore Courses section lists those Published Courses
And each Course shows its title and short description
And each Course has a Start Course action

### Scenario: Learner sees enrolled Courses in Continue Learning

Given I am a signed-in Learner
And I have an Enrollment in a Published Course
When I view the Learner Dashboard
Then I see a Continue Learning section
And the Continue Learning section lists that Course
And the Course shows my Progress percentage rounded down to a whole number
And the Course has a Resume Course action

### Scenario: Started Courses are not duplicated in Explore Courses

Given I am a signed-in Learner
And I have an Enrollment in a Published Course
When I view the Learner Dashboard
Then that Course appears in Continue Learning
And that Course does not appear as an unstarted Course in Explore Courses

### Scenario: Draft Courses are hidden from Learners

Given I am a signed-in Learner
And an Admin has created a Draft Course
When I view the Learner Dashboard
Then I do not see the Draft Course in Explore Courses

### Scenario: Archived Courses are hidden from Learners who are not enrolled

Given I am a signed-in Learner
And there is an Archived Course
And I do not have an Enrollment in that Course
When I view the Learner Dashboard
Then I do not see the Archived Course in Explore Courses

### Scenario: Completed Courses remain visible as completed

Given I am a signed-in Learner
And I have completed every Lesson in an enrolled Course
When I view the Learner Dashboard
Then I see the Course as completed
And the primary action is Review Course

## Feature: Course Overview

As a Learner, I want to inspect a Course outline before starting it.

### Scenario: Learner views a Published Course Overview before enrollment

Given I am a signed-in Learner
And there is a Published Course with Chapters and Lessons
And I am not enrolled in that Course
When I view the Course Overview
Then I see the Course title
And I see the Course short description
And I see the ordered Chapter and Lesson outline
And I see a Start Course action

### Scenario: Lesson bodies are hidden before enrollment

Given I am a signed-in Learner
And there is a Published Course with a Lesson
And I am not enrolled in that Course
When I view the Course Overview
Then I can see the Lesson title in the outline
But I cannot view the Lesson body

### Scenario: Enrolled Learner sees progress on Course Overview

Given I am a signed-in Learner
And I have an Enrollment in a Published Course
And I have completed some Lessons in that Course
When I view the Course Overview
Then I see my Progress for the Course
And I see which Lessons are complete
And I see a Resume Course action

### Scenario: Completed Course Overview offers review

Given I am a signed-in Learner
And I have completed every Lesson in an enrolled Course
When I view the Course Overview
Then I see the Course as complete
And I see a Review Course action

### Scenario: Learner cannot view a Draft Course Overview

Given I am a signed-in Learner
And there is a Draft Course
When I try to view the Course Overview
Then I am told the Course is unavailable
And I cannot view the Course outline

### Scenario: Learner without Enrollment cannot view an Archived Course Overview

Given I am a signed-in Learner
And there is an Archived Course
And I do not have an Enrollment in that Course
When I try to view the Course Overview
Then I am told the Course is unavailable
And I cannot view the Course outline

### Scenario: Enrolled Learner can view an Archived Course Overview

Given I am a signed-in Learner
And I have an Enrollment in a Course
And an Admin has archived that Course
When I view the Course Overview
Then I see the Course title
And I see the ordered Chapter and Lesson outline
And I see my Progress for the Course

## Feature: Starting a Course

As a Learner, I want to start a Course so my progress can be tracked.

### Scenario: Learner starts a Published Course

Given I am a signed-in Learner
And there is a Published Course with at least one Lesson
And I am not enrolled in that Course
When I start the Course
Then an Enrollment is created for me and that Course
And I am taken to the first Lesson in Course Order

### Scenario: Starting a Course is idempotent

Given I am a signed-in Learner
And I already have an Enrollment in a Published Course
When I try to start that Course again
Then no duplicate Enrollment is created
And I remain enrolled in that Course

### Scenario: Learner cannot start a Draft Course

Given I am a signed-in Learner
And there is a Draft Course
When I try to start the Draft Course
Then no Enrollment is created
And I am told the Course is unavailable

### Scenario: Learner cannot newly start an Archived Course

Given I am a signed-in Learner
And there is an Archived Course
And I do not have an Enrollment in that Course
When I try to start the Archived Course
Then no Enrollment is created
And I am told the Course is unavailable

## Feature: Resuming a Course

As a Learner, I want to resume at the next suggested Lesson.

### Scenario: Resume sends Learner to first incomplete Lesson

Given I am a signed-in Learner
And I have an Enrollment in a Course with ordered Lessons
And I have completed the first Lesson
And I have not completed the second Lesson
When I resume the Course
Then I am taken to the second Lesson

### Scenario: Resume uses current Course Order

Given I am a signed-in Learner
And I have an Enrollment in a Course
And an Admin has reordered the Lessons
When I resume the Course
Then the Resume Point is calculated from the current Course Order

### Scenario: Completed Course resumes as review

Given I am a signed-in Learner
And I have completed every Lesson in an enrolled Course
When I choose the Course's primary action
Then I review the Course instead of being sent to an incomplete Lesson

## Feature: Lesson navigation and completion

As a Learner, I want to move through Lessons freely and control my own completion state.

### Scenario: Enrolled Learner views a Lesson

Given I am a signed-in Learner
And I have an Enrollment in a Course
And the Course has a Lesson
When I view that Lesson
Then I see the Lesson title
And I see the Lesson rich text body
And I see the Course sidebar
And the current Lesson is highlighted

### Scenario: Course sidebar shows ordered outline and completion state

Given I am a signed-in Learner
And I have an Enrollment in a Course with Chapters and Lessons
And I have completed some Lessons
When I view a Lesson
Then the sidebar shows Chapters and Lessons in Course Order
And completed Lessons have completion checkmarks
And incomplete Lessons do not have completion checkmarks

### Scenario: Learner can open any Lesson in an enrolled Course

Given I am a signed-in Learner
And I have an Enrollment in a Course with multiple Lessons
When I open a later incomplete Lesson directly
Then I can view that Lesson
And I am not blocked by incomplete earlier Lessons

### Scenario: Learner marks a Lesson complete

Given I am a signed-in Learner
And I have an Enrollment in a Course
And I am viewing an incomplete Lesson
When I mark the Lesson complete
Then the Lesson is recorded as complete for me
And the Lesson shows a completed state
And the Course Progress is updated

### Scenario: Learner marks a Lesson incomplete

Given I am a signed-in Learner
And I have an Enrollment in a Course
And I am viewing a completed Lesson
When I mark the Lesson incomplete
Then the Lesson is recorded as incomplete for me
And the Lesson no longer shows a completed state
And the Course Progress is updated

### Scenario: Learner uses previous and next navigation

Given I am a signed-in Learner
And I have an Enrollment in a Course with multiple Lessons
And I am viewing a Lesson that has a previous and next Lesson
When I use previous or next navigation
Then I am taken to the adjacent Lesson in Course Order

### Scenario: First Lesson has no previous navigation target

Given I am a signed-in Learner
And I have an Enrollment in a Course with multiple Lessons
And I am viewing the first Lesson in Course Order
When I view Lesson navigation
Then there is no Previous Lesson action
And there is a Next Lesson action

### Scenario: Last Lesson has no next navigation target

Given I am a signed-in Learner
And I have an Enrollment in a Course with multiple Lessons
And I am viewing the last Lesson in Course Order
When I view Lesson navigation
Then there is a Previous Lesson action
And there is no Next Lesson action

### Scenario: Learner cannot view Lesson body without Enrollment

Given I am a signed-in Learner
And there is a Published Course with a Lesson
And I do not have an Enrollment in that Course
When I try to view the Lesson body
Then I am not shown the Lesson body
And I am prompted to start the Course

### Scenario: Learner cannot view another Learner's enrolled Lesson body

Given I am a signed-in Learner
And another Learner has an Enrollment in a Course
And I do not have an Enrollment in that Course
When I try to view a Lesson body from that Course
Then I am not shown the Lesson body
And I am prompted to start the Course

### Scenario: Learner cannot update another Learner's Lesson Progress

Given I am a signed-in Learner
And another Learner has an Enrollment in a Course
And I do not have an Enrollment in that Course
When I try to mark a Lesson in that Course complete for the other Learner
Then the Lesson is not recorded as complete for me
And the Lesson is not recorded as complete for the other Learner
And I am denied access

### Scenario: Lesson Markdown is rendered safely for enrolled Learners

Given I am a signed-in Learner
And I have an Enrollment in a Course
And the Course has a Lesson with Markdown containing headings, paragraphs, lists, links, and fenced code blocks
When I view that Lesson
Then the Lesson body is rendered from Markdown
And unsafe HTML is not rendered as executable HTML
And unsafe script content does not run

## Feature: Progress calculation

As a Learner, I want my Course and Chapter completion to reflect completed Lessons.

### Scenario: Chapter is incomplete when any Lesson is incomplete

Given I am a signed-in Learner
And I have an Enrollment in a Course
And a Chapter has multiple Lessons
And at least one Lesson in that Chapter is incomplete for me
When my Chapter Progress is calculated
Then the Chapter is not complete

### Scenario: Chapter is complete when all Lessons are complete

Given I am a signed-in Learner
And I have an Enrollment in a Course
And a Chapter has multiple Lessons
And every Lesson in that Chapter is complete for me
When my Chapter Progress is calculated
Then the Chapter is complete

### Scenario: Course is incomplete when any Chapter is incomplete

Given I am a signed-in Learner
And I have an Enrollment in a Course with multiple Chapters
And at least one Chapter is incomplete for me
When my Course Progress is calculated
Then the Course is not complete

### Scenario: Course is complete when all Chapters are complete

Given I am a signed-in Learner
And I have an Enrollment in a Course with multiple Chapters
And every Chapter is complete for me
When my Course Progress is calculated
Then the Course is complete

### Scenario: New Lesson added to Published Course affects enrolled Learner progress

Given I am a signed-in Learner
And I have completed every Lesson in an enrolled Published Course
When an Admin adds a new Lesson to that Course
Then the new Lesson is incomplete for me
And the Course is no longer complete for me

## Feature: Admin access

As the product owner, I want only Admins to manage content.

### Scenario: Admin can access Admin screens

Given I am a signed-in User with Admin access
When I visit the Admin area
Then I can access Admin screens

### Scenario: Learner without Admin access cannot access Admin screens

Given I am a signed-in User without Admin access
When I visit the Admin area
Then I am denied access

### Scenario: User can be both Admin and Learner

Given I am a signed-in User with Admin access and Learner access
When I use the app
Then I can access Admin screens
And I can access Learner screens

## Feature: Admin Course management

As an Admin, I want to manage Courses so Learners can discover structured learning experiences.

### Scenario: Admin creates a Draft Course

Given I am a signed-in Admin
When I create a Course with a title and short description
Then the Course is created as a Draft Course
And the Course is not visible to Learners in Explore Courses

### Scenario: Admin sees empty state when no Courses exist

Given I am a signed-in Admin
And no Courses exist
When I view the Admin Course list
Then I see an empty state
And the empty state has a Create Course action

### Scenario: Admin cannot create a Course without required details

Given I am a signed-in Admin
When I try to create a Course without a title or short description
Then no Course is created
And I see validation messages for the missing details

### Scenario: Admin edits Course details

Given I am a signed-in Admin
And there is a Course
When I update the Course title or short description
Then the Course shows the updated details

### Scenario: Admin manually orders Courses

Given I am a signed-in Admin
And Course A appears before Course B in Course Order
When I move Course B before Course A
Then Course B appears before Course A in Learner-facing Course lists

### Scenario: Admin cannot publish structurally invalid Course

Given I am a signed-in Admin
And there is a Draft Course with no Chapters
When I try to publish the Course
Then the Course remains Draft
And I see a validation message explaining that a Published Course requires at least one Chapter and each Chapter requires at least one Lesson

### Scenario: Admin publishes structurally valid Course

Given I am a signed-in Admin
And there is a Draft Course with at least one Chapter
And every Chapter has at least one Lesson
When I publish the Course
Then the Course becomes a Published Course
And Learners can discover it in Explore Courses

### Scenario: Admin archives a Published Course

Given I am a signed-in Admin
And there is a Published Course
When I archive the Course
Then the Course becomes an Archived Course
And Learners without an Enrollment cannot discover or start it

### Scenario: Enrolled Learner can still access Archived Course

Given I am a signed-in Learner
And I have an Enrollment in a Course
And an Admin has archived that Course
When I view my enrolled Courses
Then I can still access that Course
And I can continue or review its Lessons

## Feature: Admin Chapter management

As an Admin, I want to organize a Course into ordered Chapters.

### Scenario: Admin creates a Chapter in a Course

Given I am a signed-in Admin
And there is a Course
When I create a Chapter with a title in that Course
Then the Chapter is added to the Course
And it appears in the Course outline

### Scenario: Admin cannot create a Chapter without a title

Given I am a signed-in Admin
And there is a Course
When I try to create a Chapter without a title in that Course
Then no Chapter is created
And I see a validation message for the missing title

### Scenario: Admin edits a Chapter title

Given I am a signed-in Admin
And there is a Chapter
When I update the Chapter title
Then the Chapter shows the updated title

### Scenario: Admin manually orders Chapters within a Course

Given I am a signed-in Admin
And Chapter A appears before Chapter B in a Course
When I move Chapter B before Chapter A
Then Chapter B appears before Chapter A in the Course outline
And Resume Point calculations use the new Chapter order

## Feature: Admin Lesson management

As an Admin, I want to create rich text Lessons within Chapters.

### Scenario: Admin creates a Lesson in a Chapter

Given I am a signed-in Admin
And there is a Chapter
When I create a Lesson with a title and rich text body
Then the Lesson is added to the Chapter
And it appears in the Course outline

### Scenario: Admin cannot create a Lesson without required details

Given I am a signed-in Admin
And there is a Chapter
When I try to create a Lesson without a title or rich text body
Then no Lesson is created
And I see validation messages for the missing details

### Scenario: Admin edits a Lesson

Given I am a signed-in Admin
And there is a Lesson
When I update the Lesson title or rich text body
Then the Lesson shows the updated content
And enrolled Learners see the updated content immediately

### Scenario: Admin manually orders Lessons within a Chapter

Given I am a signed-in Admin
And Lesson A appears before Lesson B in a Chapter
When I move Lesson B before Lesson A
Then Lesson B appears before Lesson A in the Chapter outline
And previous, next, and Resume Point calculations use the new Lesson order

## Feature: Draft deletion and published content preservation

As an Admin, I want safe deletion rules that avoid destroying Learner progress.

### Scenario: Admin deletes Draft Course content

Given I am a signed-in Admin
And there is Draft content with no Learner access
When I delete that Draft content
Then it is removed from the Admin content list

### Scenario: Admin deletes a Chapter from a Draft Course

Given I am a signed-in Admin
And there is a Chapter in a Draft Course
When I delete the Chapter
Then the Chapter is removed from the Draft Course outline

### Scenario: Admin deletes a Lesson from a Draft Course

Given I am a signed-in Admin
And there is a Lesson in a Draft Course
When I delete the Lesson
Then the Lesson is removed from the Draft Course outline

### Scenario: Admin cannot delete a Published Course

Given I am a signed-in Admin
And there is a Published Course
When I try to delete the Course
Then the Course is not deleted
And I am offered Archive instead

### Scenario: Admin cannot delete a Chapter from a Published Course

Given I am a signed-in Admin
And there is a Chapter in a Published Course
When I try to delete the Chapter
Then the Chapter is not deleted
And I am told Published Course content cannot be deleted

### Scenario: Admin cannot delete a Lesson from a Published Course

Given I am a signed-in Admin
And there is a Lesson in a Published Course
When I try to delete the Lesson
Then the Lesson is not deleted
And I am told Published Course content cannot be deleted

### Scenario: Admin cannot delete a Chapter from an Archived Course

Given I am a signed-in Admin
And there is a Chapter in an Archived Course
When I try to delete the Chapter
Then the Chapter is not deleted
And I am told Archived Course content cannot be deleted

### Scenario: Admin cannot delete a Lesson from an Archived Course

Given I am a signed-in Admin
And there is a Lesson in an Archived Course
When I try to delete the Lesson
Then the Lesson is not deleted
And I am told Archived Course content cannot be deleted

### Scenario: Published content is edited in place without versioning

Given I am a signed-in Admin
And there is a Published Course
When I edit its content
Then the changes are visible to Learners immediately
And no new Course version is created

## Feature: Out of scope behavior

These scenarios define behavior the MVP intentionally does not support.

### Scenario: Learner does not need payment or approval to start a Course

Given I am a signed-in Learner
And there is a Published Course
When I start the Course
Then I am not asked for payment
And I am not asked for Admin approval

### Scenario: Learner is not blocked by prerequisites

Given I am a signed-in Learner
And I have an Enrollment in a Course
And earlier Lessons are incomplete
When I open a later Lesson
Then I can view the later Lesson

### Scenario: Course discovery has no taxonomy filters

Given I am a signed-in Learner
When I explore Courses
Then I cannot filter by category, tag, difficulty, or duration
And I cannot search Courses in the MVP
