#!/bin/bash

# build pages
gitbook build

# check if there is any error
if [ $? -ne 0 ]; then
    exit
fi

# push to github
git add .
git commit -m "update at $(date '+%Y-%m-%d %H:%M:%S')"
git push origin master

# push to gh-pages branch
remote_url=$(git remote -v | head -1 | awk '{print $2}')
pushd _book &> /dev/null
if [ ! -d .git ]; then
    git init .
    git remote add origin ${remote_url}
    git checkout --orphan gh-pages
    git push -u origin gh-pages
else
    git checkout gh-pages
fi
git add .
git commit -m "update gh-pages branch at $(date '+%Y-%m-%d %H:%M:%S')"
git push origin gh-pages
popd &> /dev/null
