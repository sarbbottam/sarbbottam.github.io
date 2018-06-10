#!/bin/sh

if [ "$TRAVIS_BRANCH" = "main" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
  ( cd _site
    git init
    git config user.name "sarbbottam"
    git config user.email "sarbbottam@gmail.com"
    git add .
    git commit -m "initial commit"
    git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:master > /dev/null 2>&1
  )
else
   echo "not publising to master"
fi
