#!/usr/bin/env sh

COMMIT_MESSAGE="run make download strings for release"

transform() {
  make -C ui_strings download-strings-for-release
}

REPOS='
duolingo/duolingo-android
duolingo/duolingo-web
duolingo/account-reclamation-backend
duolingo/attribution-backend
duolingo/course-data-backend
duolingo/det-collusion-detection-backend
duolingo/det-exam-media-data-backend
duolingo/det-transcode-backend
duolingo/drive-thru
duolingo/duolingo-2
duolingo/duolingo-comeback
duolingo/duolingo-schools
duolingo/email-push-templates-backend
duolingo/explanations
duolingo/friends-backend
duolingo/generic-etl-receiver
duolingo/gromits-backend
doulingo/localization-lib
duolingo/math-backend
duolingo/points-backend
duolingo/promo-code-backend
duolingo/show-home-backend
duolingo/user-tree-backend
'

DESCRIPTION='
Do not commit
'
