#!/usr/bin/bash
#
# An example hook script to check the commit log message.
# Called by "git commit" with one argument, the name of the file
# that has the commit message.  The hook should exit with non-zero
# status after issuing an appropriate message if it wants to stop the
# commit.  The hook is allowed to edit the commit message file.
#
# To enable this hook, rename this file to "commit-msg".

# Uncomment the below to add a Signed-off-by line to the message.
# Doing this in a hook is a bad idea in general, but the prepare-commit-msg
# hook is more suited to it.
#
# SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"

# This example catches duplicate Signed-off-by lines.

msg=$(cat "$1")
if [[ ${#msg} -gt 80 ]]; then
  echo "Commit message has more than 80 characters !!!"
  exit 1
fi

if [[ $msg =~ ^(build|ci|docs|feat|perf|refactor|test).* ]]; then
  exit 0
else
  echo "Commit message should start with: build,ci,docs,feat,pef,refactor,test"
  exit 1
fi
