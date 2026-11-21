---
name: Git Commit
description: Analyse staged changes and generate a conventional commit message with Added/Updated/Removed bullets. Use when asked to write a commit message for staged changes.
---

# Git Commit

Generate a commit message from staged changes only. Do not modify files.

## Steps

1. Read `git diff --cached` and `git status --short` to catch added, modified and deleted files.
2. Pick the conventional type: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `build`, `ci`, `perf`, `style`.
3. Write a short imperative description (no trailing period, lower case).
4. List each change under `Added`, `Updated` or `Removed`, one bullet per logical change, naming the file or feature.

## Output

Reply with only the commit message: no code fences, no preamble, no commentary. Omit sections with no entries.

```text
<type>: <description>

Added ...
Updated ...
Removed ...
```
