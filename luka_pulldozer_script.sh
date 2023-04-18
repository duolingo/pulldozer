#!/usr/bin/env sh

COMMIT_MESSAGE="run make download strings for release"

transform() {
  make -C ui_strings download-strings-for-release
}

REPOS='
duolingo/duolingo-android
duolingo/schools-web
duolingo/attribution-backend
duolingo/datahub
duolingo/det-exam-media-data-backend
duolingo/diagnostics-backend
duolingo/duolingo-2
duolingo/duolingo-englishtest
duolingo/email-push-templates-backend
duolingo/feed-backend
duolingo/generic-etl-receiver
duolingo/leaderboards-backend
duolingo/math-backend
duolingo/practice-games-backend
duolingo/show-home-backend
duolingo/web-backend
'

DESCRIPTION='
Do not commit
'
