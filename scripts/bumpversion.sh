#!/bin/bash
# -*- coding: utf-8 -*-
# Author: ablil <ablil@protonmail.com>
# created: 2021-09-10
# Description: bump python package version and commit change

function usage() {
    echo "Usage: "
    echo -e "\t$0 (--major|--minor|--patch)    increase version number"
    exit 1;
}

[[ $# != 1 ]] && usage

if [[ ! -f setup.py ]]; then
    echo "setup.py not found, make sure you are inside a python package"
    exit 2;
fi

# Extract current version
version=$(sed -n -r -e "s/version=('|\")([[:digit:]]+.[[:digit:]]+.[[:digit:]]+)('|\"),?/\2/p" setup.py)
echo "current version is $version"
major=$(echo $version | cut -f 1 -d .)
minor=$(echo $version | cut -f 2 -d .)
patch=$(echo $version | cut -f 3 -d .)

# increment version
if [[ $1 == '--major' ]]; then
    major=`expr $major + 1`
elif [[ $1 == '--minor' ]]; then
    minor=`expr $minor + 1`
elif [[ $1 == '--patch' ]]; then 
    patch=`expr $patch + 1`
else
    usage
fi

# update with new version
newversion="${major}.${minor}.${patch}"
sed -r -i -e "s/version=('|\").+('|\"),?/version='$newversion',/g" setup.py
echo "new version is $newversion"

# git add and commit
git add setup.py && git commit -o setup.py -m "v$newversion"
