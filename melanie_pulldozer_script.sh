#!/usr/bin/env sh

COMMIT_MESSAGE="run make download strings for release"

transform() {
  make -C ui_strings download-strings-for-release
}

REPOS='
duolingo/duolingo-ios
duolingo/account-reclamation-backend
duolingo/avatars
duolingo/det-collusion-detection-backend
duolingo/det-items-factory-backend
duolingo/drive-thru
duolingo/duolingo-blast
duolingo/duolingo-schools
duolingo/email-recovery-backend
duolingo/friends-backend
duolingo/generic-etl-transformer
doulingo/localization-lib
duolingo/password-quality-backend
duolingo/promo-code-backend
duolingo/subscriptions-backend
'

DESCRIPTION='
Do not commit
'
