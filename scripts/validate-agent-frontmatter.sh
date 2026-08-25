#!/usr/bin/env bash
set -euo pipefail

agents_dir="${1:-.github/agents}"
status=0

while IFS= read -r -d '' agent_file; do
    if ! head -n 1 "$agent_file" | grep -qx -- '---' || ! awk 'NR > 1 && /^---$/ { found = 1; exit } END { exit !found }' "$agent_file"; then
        printf 'Frontmatter invàlid: %s\n' "$agent_file" >&2
        status=1
        continue
    fi
    if ! grep -q '^description:' "$agent_file"; then
        printf 'Falta description: %s\n' "$agent_file" >&2
        status=1
    fi
done < <(find "$agents_dir" -type f -name '*.agent.md' -print0 | sort -z)

exit "$status"
