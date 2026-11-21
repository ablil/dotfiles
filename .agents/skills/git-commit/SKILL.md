---
name: Git Commit
description: Use whenever creating a git commit message, including when another skills says to commit
---

# Git Commit

Generate a commit message from staged changes only. Do not modify files.

## Steps

1. Read `git diff --cached` and `git status --short` to catch added, modified and deleted files.
2. Pick the conventional type: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `build`, `ci`, `perf`, `style`.
3. Write a short imperative description (no trailing period, lower case).
4. Group the changes into behaviour-level bullets under `Added`, `Updated` or `Removed`. Describe what changed for the user of the code — a feature, capability or behaviour. Never list file names, paths or code identifiers.

## Output

Reply with only the commit message: no code fences, no preamble, no commentary. Omit sections with no entries. Bullets describe behaviour ("Added retry on failed uploads"), never files.

```text
<type>: <description>

Added ...
Updated ...
Removed ...
```
