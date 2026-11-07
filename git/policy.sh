#!/usr/bin/env bash

ticket_from_branch() {
  local branch="${1:-}" prefix="${2:-SHOP}" rest

  [[ -n "$branch" && -n "$prefix" ]] || return 0
  [[ "$branch" == "$prefix"-* ]] || return 0

  rest="${branch#"$prefix"-}"
  if [[ "$rest" =~ ^[0-9]{2,} ]]; then
    printf '%s-%s\n' "$prefix" "${BASH_REMATCH[0]}"
  fi
}

rewrite_commit_message() {
  local branch="${1:-}" prefix="${2:-SHOP}" message="${3:-}"
  local ticket first_line body new_first type subject
  local conventional_re='^(feat|fix|chore|ci|refactor|test|style|perf|build|revert|docs)(\([^)]*\))?:[[:space:]]*(.*)$'

  ticket="$(ticket_from_branch "$branch" "$prefix")"
  if [[ -z "$ticket" ]]; then
    printf '%s\n' "$message"
    return 0
  fi

  if [[ "$message" == *"$ticket"* ]]; then
    printf '%s\n' "$message"
    return 0
  fi

  first_line="${message%%$'\n'*}"
  if [[ "$message" == *$'\n'* ]]; then
    body=$'\n'"${message#*$'\n'}"
  else
    body=""
  fi

  if [[ "$first_line" =~ $conventional_re ]]; then
    type="${BASH_REMATCH[1]}"
    subject="${BASH_REMATCH[3]}"
    new_first="$type($ticket): $subject"
  else
    new_first="$ticket: $first_line"
  fi

  printf '%s%s\n' "$new_first" "$body"
}

todo_comments_in_diff() {
  local diff="${1:-}"

  printf '%s\n' "$diff" | awk '
    /^\+\+\+ / {
      file = substr($0, 7)
      next
    }
    /^@@ / {
      if (match($0, /\+[0-9]+/)) {
        line = substr($0, RSTART + 1, RLENGTH - 1) + 0
      } else {
        line = 0
      }
      next
    }
    /^\+/ && !/^\+\+\+/ {
      text = substr($0, 2)
      if (text ~ /(^|[ \t])(\/\/|#|\/\*|\*|<!--|--|;|%).*TODO([^[:alnum:]_]|$)/) {
        printf "%s:%d:%s\n", file, line, text
      }
      line++
      next
    }
    /^ / { line++ }
  '
}

branch_is_protected() {
  local branch="${1:-}" protected="${2:-main master}" item

  protected="${protected//,/ }"
  [[ -n "$branch" ]] || return 1
  for item in $protected; do
    [[ "$branch" == "$item" ]] && return 0
  done
  return 1
}
