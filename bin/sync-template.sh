#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 [--dry-run] [--pull] [--push]" >&2
  exit 1
}

dry_run=false
do_pull=false
do_push=false

for arg in "$@"; do
  case "$arg" in
    --dry-run) dry_run=true ;;
    --pull)    do_pull=true ;;
    --push)    do_push=true ;;
    *) usage ;;
  esac
done

if [[ $# -eq 0 || ( $do_pull = false && $do_push = false ) ]]; then
  usage
fi

LOG_DIR="logs"
LOG_FILE="${LOG_DIR}/sync.log"
mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') $*" | tee -a "$LOG_FILE"
}

if ! command -v gh &> /dev/null; then
  log "GitHub CLI (gh) is not installed. Please install it first."
  exit 1
fi

if command -v gh &> /dev/null; then
  DEFAULT_REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "")
else
  DEFAULT_REPO=""
fi
TEMPLATE_REPO="${TEMPLATE_REPO:-$DEFAULT_REPO}"
if [[ -z "$TEMPLATE_REPO" ]]; then
  log "TEMPLATE_REPO not specified and could not be determined."
  exit 1
fi
TEMPLATE_REMOTE="upstream"
LOCAL_TMP_DIR="./.tmp-template-sync"

mkdir -p "$LOCAL_TMP_DIR"
cd "$LOCAL_TMP_DIR"

log "Starting template sync..."

TEMPLATE_OWNER="${TEMPLATE_REPO%%/*}"
forks=$(gh repo list "$TEMPLATE_OWNER" --fork --json nameWithOwner -q '.[].nameWithOwner')

for fork in $forks; do
  log "Processing $fork"
  repo_dir="$(basename "$fork")"

  if $dry_run; then
    log "[DRY-RUN] git clone git@github.com:$fork.git $repo_dir"
  else
    git clone "git@github.com:$fork.git" "$repo_dir" &>> "$LOG_FILE"
  fi

  cd "$repo_dir"

  if ! git remote | grep -q "$TEMPLATE_REMOTE"; then
    if $dry_run; then
      log "[DRY-RUN] git remote add $TEMPLATE_REMOTE git@github.com:$TEMPLATE_REPO.git"
    else
      git remote add "$TEMPLATE_REMOTE" "git@github.com:$TEMPLATE_REPO.git" &>> "$LOG_FILE"
    fi
  fi

  if $do_pull; then
    if $dry_run; then
      log "[DRY-RUN] git fetch $TEMPLATE_REMOTE"
      log "[DRY-RUN] git merge $TEMPLATE_REMOTE/main --allow-unrelated-histories --no-edit"
    else
      git fetch "$TEMPLATE_REMOTE" &>> "$LOG_FILE"
      git merge "$TEMPLATE_REMOTE/main" --allow-unrelated-histories --no-edit &>> "$LOG_FILE"
    fi
  fi

  if $do_push; then
    if $dry_run; then
      log "[DRY-RUN] git push origin main"
    else
      git push origin main &>> "$LOG_FILE"
    fi
  fi

  cd ..
  if $dry_run; then
    log "[DRY-RUN] rm -rf $repo_dir"
  else
    rm -rf "$repo_dir"
  fi
done

cd ..
rm -rf "$LOCAL_TMP_DIR"

log "Sync complete."

