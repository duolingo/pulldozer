#!/usr/bin/env sh

COMMIT_MESSAGE="run make download strings for release"

transform() {
  make -C ui_strings download-strings-for-release
}

REPOS='
duolingo/duolingo-ios
duolingo/schools-web
duolingo/ai-features-backend
duolingo/avatars
duolingo/datahub
duolingo/det-exam-administration-backend
duolingo/det-items-factory-backend
duolingo/diagnostics-backend
duolingo/duoflow-backend
duolingo/duolingo-blast
duolingo/duolingo-englishtest
duolingo/duopress
duolingo/email-recovery-backend
duolingo/feed-backend
duolingo/generic-etl-loader
duolingo/generic-etl-transformer
duolingo/leaderboards-backend
duolingo/login-backend
duolingo/password-quality-backend
duolingo/practice-games-backend
duolingo/shop-backend
duolingo/subscriptions-backend
duolingo/web-backend
'

DESCRIPTION='
Do not commit
'
