#!/bin/bash
# Description: check commit message

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
