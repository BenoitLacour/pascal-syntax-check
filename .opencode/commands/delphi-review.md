---
description: Review modified Delphi files for syntax and best practices
agent: delphi-reviewer
---

Review all modified Delphi/Pascal files in the current git working tree.

Show the git diff summary:
!`git diff --stat`

Show the list of modified files:
!`git diff --name-only`

For each modified file:
1. Run the Pascal syntax checker: `./target/release/pascal-check {filename}`
2. Show the git diff for that file: `git diff {filename}`
3. Provide feedback on any syntax issues or code quality concerns

Focus on:
- Syntax correctness
- Consistency with codebase conventions
- Potential bugs or issues
