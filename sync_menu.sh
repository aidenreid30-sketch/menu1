#!/usr/bin/env bash
# =============================================================================
# sync_menu.sh — Automated menu1 deployment pipeline for Raspberry Pi 5
# Repository : https://github.com/aidenreid30-sketch/menu1
# Cron runs  : every 5 minutes
# =============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# CONFIGURATION — edit these two paths before first use
# ---------------------------------------------------------------------------
NEW_JSON="/path/to/downloads/item.json"       # where the external process drops the file
REPO_DIR="/path/to/repo/menu1"               # local clone of the GitHub repo
# ---------------------------------------------------------------------------

LOCK_FILE="/tmp/sync_menu.lock"
LOG_PREFIX="[sync_menu] $(date '+%Y-%m-%d %H:%M:%S')"
BACKUP_DIR="${REPO_DIR}/backup"
REPO_JSON="${REPO_DIR}/item.json"
TIMESTAMP="$(date '+%Y-%m-%d_%H-%M-%S')"
BACKUP_NAME="item.${TIMESTAMP}.json"

# ---------------------------------------------------------------------------
# 1. CONCURRENCY LOCK — only one instance at a time
# ---------------------------------------------------------------------------
exec 200>"${LOCK_FILE}"
if ! flock -n 200; then
    echo "${LOG_PREFIX} [WARN] Another instance is already running. Exiting." >&2
    exit 0
fi
# Lock is held for the lifetime of this script; flock releases it on exit.

# ---------------------------------------------------------------------------
# Helper: log + exit on error
# ---------------------------------------------------------------------------
die() {
    echo "${LOG_PREFIX} [ERROR] $*" >&2
    exit 1
}

info() {
    echo "${LOG_PREFIX} [INFO]  $*"
}

# ---------------------------------------------------------------------------
# 2. PRE-FLIGHT CHECKS
# ---------------------------------------------------------------------------
info "Starting sync pipeline."

command -v git >/dev/null 2>&1 || die "'git' not found. Install it with: sudo apt install git"
command -v jq  >/dev/null 2>&1 || die "'jq' not found.  Install it with: sudo apt install jq"

[[ -f "${NEW_JSON}" ]]  || { info "No new item.json found at '${NEW_JSON}'. Nothing to do."; exit 0; }
[[ -d "${REPO_DIR}" ]]  || die "Repo directory '${REPO_DIR}' does not exist."
[[ -d "${REPO_DIR}/.git" ]] || die "'${REPO_DIR}' is not a Git repository."

# ---------------------------------------------------------------------------
# 3. JSON VALIDATION
# ---------------------------------------------------------------------------
info "Validating JSON at '${NEW_JSON}'..."
if ! jq empty "${NEW_JSON}" >/dev/null 2>&1; then
    die "Malformed JSON detected in '${NEW_JSON}'. Aborting — repo unchanged."
fi
info "JSON is valid."

# ---------------------------------------------------------------------------
# 4. REPO SYNCHRONISATION — mirror GitHub exactly, no merge conflicts
# ---------------------------------------------------------------------------
info "Synchronising repo with origin/main..."
cd "${REPO_DIR}"
git fetch origin                        || die "git fetch failed."
git reset --hard origin/main            || die "git reset --hard failed."
info "Repo is up to date with origin/main."

# ---------------------------------------------------------------------------
# 5. BACKUP THE EXISTING item.json
# ---------------------------------------------------------------------------
mkdir -p "${BACKUP_DIR}"

if [[ -f "${REPO_JSON}" ]]; then
    info "Backing up existing item.json → backup/${BACKUP_NAME}"
    mv "${REPO_JSON}" "${BACKUP_DIR}/${BACKUP_NAME}"
else
    info "No existing item.json in repo — skipping backup step."
fi

# ---------------------------------------------------------------------------
# 6. INSTALL THE NEW FILE
# ---------------------------------------------------------------------------
info "Copying new item.json into repo root..."
cp "${NEW_JSON}" "${REPO_JSON}"

# ---------------------------------------------------------------------------
# 7. SMART COMMIT — skip if nothing actually changed
# ---------------------------------------------------------------------------
git add item.json backup/

CHANGES="$(git status --porcelain)"
if [[ -z "${CHANGES}" ]]; then
    info "No changes detected after staging. The new file is identical to the current repo version. Exiting without a commit."
    exit 0
fi

COMMIT_MSG="Auto-update and backup item.json via Raspberry Pi — ${TIMESTAMP}"
info "Committing: '${COMMIT_MSG}'"
git commit -m "${COMMIT_MSG}"

# ---------------------------------------------------------------------------
# 8. PUSH TO GITHUB
# ---------------------------------------------------------------------------
info "Pushing to origin/main..."
git push origin main || die "git push failed. Check SSH key permissions and network connectivity."

# ---------------------------------------------------------------------------
# 9. CLEANUP — delete the processed download so the next cron run doesn't
#    treat the same file as a new update (prevents infinite backup loop).
#    If your external process requires the file to exist, replace the rm
#    with:  > "${NEW_JSON}"   (empties it; jq will reject it and abort safely)
# ---------------------------------------------------------------------------
info "Cleaning up processed download file..."
rm "${NEW_JSON}"

info "Pipeline complete. GitHub Pages will redeploy automatically."

# Lock released automatically when script exits (flock on fd 200).
