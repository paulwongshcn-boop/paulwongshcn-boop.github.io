#!/bin/bash
# STARKVERSE Version Manager
SITE="/www/wwwroot/stark-store"

case "${1:-help}" in
  status)
    cd $SITE
    echo "╔════════════════════════════════════╗"
    echo "║   STARKVERSE Version Manager       ║"
    echo "╚════════════════════════════════════╝"
    echo "Current: $(git describe --tags --always 2>/dev/null)"
    echo "Last:    $(git log -1 --format='%h %s' 2>/dev/null)"
    echo "Date:    $(git log -1 --format='%ci' 2>/dev/null)"
    if git status --short | grep -q .; then
      echo ""
      echo "Uncommitted changes:"
      git status --short
    else
      echo "Status: clean"
    fi
    ;;
  save|commit)
    msg="${2:-Update website}"
    cd $SITE && git add -A
    if git diff --cached --quiet; then echo "No changes."; else
      git commit -m "$msg"
      echo "✅ Saved: $(git log -1 --format='%h %s')"
    fi
    ;;
  log|list)
    cd $SITE && git log --oneline -"${2:-10}"
    ;;
  revert)
    [ -z "$2" ] && echo "Usage: ./version.sh revert <hash>" && exit 1
    cd $SITE
    git revert --no-commit "$2" && git commit -m "revert: rollback to $2"
    echo "✅ Reverted to $2"
    ;;
  diff)
    cd $SITE && git show "${2:-HEAD}" --stat
    ;;
  tag)
    cd $SITE
    [ -z "$2" ] && git tag -l || (git tag -a "$2" -m "${3:-Version $2}" && echo "✅ Tagged $2")
    ;;
  unlock)
    cd $SITE && rm -f .git/index.lock && echo "Lock removed"
    ;;
  *)
    echo "Commands: status | save <msg> | log [n] | revert <hash> | diff [id] | tag [name]"
    ;;
esac
