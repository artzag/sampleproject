#!/bin/sh

setup_git() {
  git config --global user.email "builds@travis-ci.com"
  git config --global user.name "Travis CI"
}

tag() {
    YEAR=$(date +"%Y")
    MONTH=$(date +"%m")
    export VERSION_NO=$(python -c 'from sample import VERSION as version; print(version)');
    export APP_NAME=sample
    export GIT_TAG=$APP_NAME-$VERSION_NO
    git fetch --tags
    msg="Tag Generated from TravisCI on branch $TRAVIS_BRANCH for build $TRAVIS_BUILD_NUMBER ($YEAR-$MONTH)"
    echo $msg
    echo $GIT_TAG
    #if git tag $GIT_TAG -a -m "$msg" 2>/dev/null; then
    git tag $GIT_TAG -a -m "$msg"
}

upload_files() {
  #git remote add origin-pages https://${GH_TOKEN}@github.com/artzag/sampleproject.git > /dev/null 2>&1
  #git push --quiet --set-upstream origin master
  git push origin master && git push origin master --tags
}

setup_git
tag
upload_files
