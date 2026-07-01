---
id: ll-8av3
status: open
deps: []
links: []
created: 2026-07-01T12:40:45Z
type: feature
priority: 2
assignee: Riza Fahmi
---
# Add learner and admin roles to authentication

Add role support on top of the generated email/password authentication so public sign-up creates Learner users, the first registered User is bootstrapped as an Admin, and Admins can assign Admin access from the User page.

Decisions baked in from the PRD:
- Public sign-up always creates Learner access.
- The first registered User automatically receives Admin access.
- Public sign-up after the first registered User does not create Admin access.
- Admins can assign Admin access to other Users from the User page.
- Non-Admins are redirected with a flash when trying to access Admin screens.

## Acceptance Criteria

- [ ] A visitor can sign up and becomes a Learner.
- [ ] The first registered User automatically becomes an Admin.
- [ ] Later newly signed-up users are not Admins by default.
- [ ] A User can be a Learner, an Admin, or both.
- [ ] Admins can assign Admin access to another User from the User page.
- [ ] Non-Admins cannot access Admin screens.
- [ ] Unauthorized Admin access redirects with a flash.
- [ ] Automated tests cover first-user Admin bootstrap, later sign-up role defaults, Admin assignment, and Admin access protection.
