#!/bin/bash
# update-hot-cache.sh — PM Wiki Stop Hook
#
# Runs at the end of every Claude session (via Claude Code Stop hook).
# Reads the session transcript, calls Claude to summarize it, and writes
# the summary to wiki/hot.md — ready to be injected into the next session.
#
# Installation:
#   Add to your Claude Code config (settings.json or .claude/settings.json):
#   {
#     "hooks": {
#       "Stop": [{ "type": "command", "command": "bash .claude/hooks/update-hot-cache.sh" }]
#     }
#   }
#
# Requirements:
#   - Claude CLI (claude) installed and authenticated
#   - jq installed (brew install jq / apt install jq)
#   - Run from the vault root directory

set -euo pipefail

VAULT_ROOT="$(pwd)"
HOT_MD="$VAULT_ROOT/hot.md"
TODAY=$(date +%Y-%m-%d)

# Read transcript path from stdin (passed by Claude Code Stop hook as JSON)
TRANSCRIPT_PATH=$(cat | jq -r '.transcript_path // empty')

if [ -z "$TRANSCRIPT_PATH" ] || [ ! -f "$TRANSCRIPT_PATH" ]; then
  echo "[update-hot-cache] No transcript found — skipping hot.md update" >&2
  exit 0
fi

echo "[update-hot-cache] Generating session summary from transcript..." >&2

# Call Claude to summarize the session (90s timeout, fire-and-forget)
SUMMARY=$(timeout 90 claude -p "You are summarizing a PM Wiki session for the hot.md session memory file.

Read this session transcript and produce a compact summary in this exact format:

## Session: $TODAY

### What happened
- [bullet for each page created or updated]
- [bullet for each decision or key conclusion reached]
- [bullet for each research item processed]

### Open threads
- [bullet for each unresolved question or decision pending]
- [bullet for work started but not finished]

### Pick up next
- [one specific recommended next action]

Be concise. Each bullet should be one line. Maximum 15 bullets total.
If nothing meaningful happened, write 'No significant vault changes this session.'

Transcript:
$(cat "$TRANSCRIPT_PATH")" 2>/dev/null) || {
  echo "[update-hot-cache] Claude call failed or timed out — hot.md unchanged" >&2
  exit 0
}

# Write the new hot.md
cat > "$HOT_MD" << EOF
# Session Memory — hot.md

> Auto-maintained between sessions. Never edit manually.
> The LLM reads this at the start of every session to restore context.

---

$SUMMARY
EOF

echo "[update-hot-cache] hot.md updated for $TODAY" >&2
