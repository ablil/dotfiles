#!/usr/bin/env bash
set -u

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/policy.sh"

failures=0

check_equal() {
  local name="$1" expected="$2" actual="$3"

  if [[ "$expected" == "$actual" ]]; then
    printf 'ok   %s\n' "$name"
  else
    printf 'FAIL %s\n  expected: %q\n  actual:   %q\n' "$name" "$expected" "$actual"
    failures=$((failures + 1))
  fi
}

check_true() {
  local name="$1"
  shift

  if "$@"; then
    printf 'ok   %s\n' "$name"
  else
    printf 'FAIL %s\n' "$name"
    failures=$((failures + 1))
  fi
}

check_false() {
  local name="$1"
  shift

  if "$@"; then
    printf 'FAIL %s\n' "$name"
    failures=$((failures + 1))
  else
    printf 'ok   %s\n' "$name"
  fi
}

check_equal "ticket from branch" "SHOP-1234" "$(ticket_from_branch 'SHOP-1234-add-login' 'SHOP')"
check_equal "two digit ticket" "SHOP-12" "$(ticket_from_branch 'SHOP-12-x' 'SHOP')"
check_equal "one digit ticket rejected" "" "$(ticket_from_branch 'SHOP-1-x' 'SHOP')"
check_equal "custom prefix" "ABC-42" "$(ticket_from_branch 'ABC-42-fix' 'ABC')"
check_equal "no ticket branch" "" "$(ticket_from_branch 'chore/cleanup' 'SHOP')"

check_equal "adds ticket scope" \
  "feat(SHOP-1234): add login" \
  "$(rewrite_commit_message 'SHOP-1234-add-login' 'SHOP' 'feat: add login')"

check_equal "replaces existing scope" \
  "fix(SHOP-1234): handle timeout" \
  "$(rewrite_commit_message 'SHOP-1234-add-login' 'SHOP' 'fix(auth): handle timeout')"

check_equal "already ticketed" \
  "feat(SHOP-1234): add login" \
  "$(rewrite_commit_message 'SHOP-1234-add-login' 'SHOP' 'feat(SHOP-1234): add login')"

check_equal "non conventional message" \
  "SHOP-1234: add login" \
  "$(rewrite_commit_message 'SHOP-1234-add-login' 'SHOP' 'add login')"

check_equal "branch without ticket untouched" \
  "chore: dead code" \
  "$(rewrite_commit_message 'chore/cleanup' 'SHOP' 'chore: dead code')"

check_equal "multi-line body preserved" \
  $'fix(SHOP-1234): handle timeout\n\nRetry twice.\nRefs SHOP-9999.' \
  "$(rewrite_commit_message 'SHOP-1234-add-login' 'SHOP' $'fix(auth): handle timeout\n\nRetry twice.\nRefs SHOP-9999.')"

check_equal "ticket in body left alone" \
  $'feat: add login\n\nRefs SHOP-1234.' \
  "$(rewrite_commit_message 'SHOP-1234-add-login' 'SHOP' $'feat: add login\n\nRefs SHOP-1234.')"

check_equal "custom prefix rewrite" \
  "perf(ABC-42): cache" \
  "$(rewrite_commit_message 'ABC-42-fix-cache' 'ABC' 'perf: cache')"

check_equal "todo comment in added line" \
  "foo.js:2:// TODO: fix this" \
  "$(todo_comments_in_diff $'diff --git a/foo.js b/foo.js\n--- a/foo.js\n+++ b/foo.js\n@@ -0,0 +1,2 @@\n+const x = 1;\n+// TODO: fix this')"

check_equal "todo comment in context is ignored" \
  "" \
  "$(todo_comments_in_diff $'diff --git a/foo.js b/foo.js\n--- a/foo.js\n+++ b/foo.js\n@@ -1,2 +1,2 @@\n // TODO: already here\n+const x = 1;')"

check_equal "TODO string is not a comment" \
  "" \
  "$(todo_comments_in_diff $'diff --git a/foo.js b/foo.js\n--- a/foo.js\n+++ b/foo.js\n@@ -0,0 +1,2 @@\n+const note = "TODO";\n+const url = "http://TODO";')"

check_equal "hash todo comment" \
  "script.sh:1:# TODO: later" \
  "$(todo_comments_in_diff $'diff --git a/script.sh b/script.sh\n--- a/script.sh\n+++ b/script.sh\n@@ -0,0 +1 @@\n+# TODO: later')"

check_equal "html todo comment" \
  "page.html:1:<!-- TODO: later -->" \
  "$(todo_comments_in_diff $'diff --git a/page.html b/page.html\n--- a/page.html\n+++ b/page.html\n@@ -0,0 +1 @@\n+<!-- TODO: later -->')"

check_equal "todo later in a comment" \
  "foo.js:1:// note: TODO later" \
  "$(todo_comments_in_diff $'diff --git a/foo.js b/foo.js\n--- a/foo.js\n+++ b/foo.js\n@@ -0,0 +1 @@\n+// note: TODO later')"

check_equal "quoted hash is not a comment" \
  "" \
  "$(todo_comments_in_diff $'diff --git a/script.sh b/script.sh\n--- a/script.sh\n+++ b/script.sh\n@@ -0,0 +1 @@\n+echo "# TODO"')"

check_true "main protected" branch_is_protected "main"
check_true "master protected" branch_is_protected "master"
check_false "feature branch allowed" branch_is_protected "feature/x"
check_false "detached head allowed" branch_is_protected ""
check_true "custom protected branch" branch_is_protected "release/1.0" "main release/1.0"
check_true "comma separated protected branches" branch_is_protected "release/1.0" "main,release/1.0"

if [[ $failures -eq 0 ]]; then
  printf '\nall policy tests passed\n'
else
  printf '\n%d policy test(s) failed\n' "$failures"
fi

exit "$failures"
