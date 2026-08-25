#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Ús:
  install-agent-network.sh --source <ruta-o-url> --target <checkout-odoo> [--ref <branca>]

Sincronitza els agents de .github/agents sense modificar el codi d'Odoo.
EOF
}

source_path=""
target_path=""
ref="main"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --source)
            source_path="$2"
            shift 2
            ;;
        --target)
            target_path="$2"
            shift 2
            ;;
        --ref)
            ref="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            printf 'Argument desconegut: %s\n' "$1" >&2
            usage >&2
            exit 2
            ;;
    esac
done

if [[ -z "$source_path" || -z "$target_path" ]]; then
    usage >&2
    exit 2
fi

if [[ ! -d "$target_path" ]]; then
    printf 'El checkout de destinació no existeix: %s\n' "$target_path" >&2
    exit 1
fi

tmp_dir=""
cleanup() {
    if [[ -n "$tmp_dir" ]]; then
        rm -rf "$tmp_dir"
    fi
}
trap cleanup EXIT

if [[ "$source_path" =~ ^(https?|ssh|git)://|^[^/]+@[^:]+: ]]; then
    tmp_dir="$(mktemp -d)"
    git clone --depth 1 --branch "$ref" "$source_path" "$tmp_dir/source"
    source_path="$tmp_dir/source"
elif [[ ! -d "$source_path/.github/agents" ]]; then
    printf "No existe .github/agents en l'origen: %s\n" "$source_path" >&2
    exit 1
fi

if [[ ! -d "$source_path/.github/agents" ]]; then
    printf "No existe .github/agents en l'origen: %s\n" "$source_path" >&2
    exit 1
fi

agents_parent="$target_path/.github"
agents_target="$agents_parent/agents"
mkdir -p "$agents_parent"

if [[ -e "$agents_target" ]]; then
    backup="$agents_parent/agents.backup.$(date +%Y%m%d%H%M%S)"
    mv "$agents_target" "$backup"
    printf 'Còpia de seguretat creada: %s\n' "$backup"
fi

mkdir -p "$agents_target"
cp -R "$source_path/.github/agents/." "$agents_target/"
printf "Xarxa d'agents instal·lada a: %s\n" "$agents_target"
