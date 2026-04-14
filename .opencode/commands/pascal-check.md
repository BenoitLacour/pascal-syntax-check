---
description: Check Delphi/Pascal file syntax
agent: delphi-reviewer
---

Check the syntax of the Delphi/Pascal file(s) specified.

Current git status:
!`git status --short`

If files are specified, run `./target/release/pascal-check $ARGUMENTS` to validate them.
If no files are specified, run `./target/release/pascal-check Examples/valid/*.pas` to validate all example files.

Report the results. If there are syntax errors, provide a summary of the issues found.
