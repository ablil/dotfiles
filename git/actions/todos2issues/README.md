
# Todos2Issues GitHub Action

This GitHub Action automatically converts `TODO` comments in your codebase into GitHub issues. It scans the differences between two Git references (e.g., branches, commits, or tags), extracts `TODO` comments, and creates GitHub issues for them. If an issue with the same title already exists, it skips creating a duplicate.

---

## Features

- **Extract TODOs**: Scans `git diff` between two Git references for `TODO` comments.
- **Create Issues**: Automatically creates GitHub issues for each unique `TODO`.
- **Avoid Duplicates**: Checks if an issue with the same title already exists before creating a new one.
- **Flexible Inputs**: Allows specifying the Git references (`left_ref` and `right_ref`) to compare.

---

## Usage

### Inputs

| Input       | Description                                                                 | Required |
|-------------|-----------------------------------------------------------------------------|----------|
| `left_ref`  | The base Git reference (e.g., branch, commit, or tag) to compare against.   | Yes      |
| `right_ref` | The target Git reference (e.g., branch, commit, or tag) to compare with.    | Yes      |

### Example Workflow

The following example run on every commit to main branch or opened pull requests and alwasys compare current commit with previous one

```yaml
# .github/workflows/github_issues.yaml
name: convert TODOs to Github issues

on:
  pull_request:
    branches: [main, master]
  push:
    branches: [main, master]

permissions: write-all

env:
  GH_TOKEN: ${{ github.token }}

jobs:
  main:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 2

      - uses: ablil/dotfiles/git/actions/todos2issues@master
        with:
          left_ref: HEAD^
          right_ref: HEAD

```

---

## Example

### Input Code
```diff
// TODO: Fix the login function
# TODO: Add error handling for API calls
```

### Output
1. If no issue exists:
   - Creates an issue with the title `Fix the login function`.
   - Creates an issue with the title `Add error handling for API calls`.

2. If an issue with the title `Fix the login function` already exists:
   - Skips creating a duplicate issue and logs:
     ```
     Issue already exists for TODO: Fix the login function
     ```

---

## Prerequisites

1. Make sure you're workflow has permission to create issues

2. Make sure to fetch Git history up to all the input references

### Permission Issues
If the action fails to create issues, ensure:
- The GitHub token has sufficient permissions (`issues: write`).
- The GitHub CLI is authenticated.


