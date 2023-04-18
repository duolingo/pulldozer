#!/usr/bin/env sh

COMMIT_MESSAGE="run make download strings for release"

transform() {
  make -C ui_strings download-strings-for-release
}

REPOS='
duolingo/duolingo-web
duolingo/ai-features-backend
duolingo/course-data-backend
duolingo/det-exam-administration-backend
duolingo/det-transcode-backend
duolingo/duoflow-backend
duolingo/duolingo-comeback
duolingo/duopress
duolingo/explanations
duolingo/generic-etl-loader
duolingo/gromits-backend
duolingo/login-backend
duolingo/points-backend
duolingo/shop-backend
duolingo/user-tree-backend
'

DESCRIPTION='
Do not commit
'
