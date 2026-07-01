---
id: ll-s77i
status: open
deps: [ll-jpqf]
links: []
created: 2026-07-01T12:41:15Z
type: feature
priority: 2
assignee: Riza Fahmi
---
# Render sanitized Markdown lesson bodies

Support Markdown-authored Lesson bodies and render them safely for enrolled Learners. Lesson body rendering should support the PRD-required formatting while keeping untrusted author content safe before display.

Decisions baked in from the PRD:
- Lesson bodies are authored as Markdown stored as text.
- Raw HTML in Markdown is escaped or disabled before sanitization.
- Rendered HTML is sanitized before display.
- Support headings, paragraphs, lists, links, and fenced code blocks.
- File uploads, embedded videos, custom components, and WYSIWYG editing are out of scope.

## Acceptance Criteria

- [ ] Lessons store a Markdown text body.
- [ ] Rendered Lesson bodies support headings, paragraphs, lists, links, and fenced code blocks.
- [ ] Raw HTML authored in Markdown is not rendered as trusted HTML.
- [ ] Rendered Lesson body HTML is sanitized before display.
- [ ] Automated tests cover supported Markdown features and unsafe raw HTML handling.

