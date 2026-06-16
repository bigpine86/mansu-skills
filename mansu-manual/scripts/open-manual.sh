#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/mansu-manual"
PORT_START="${MANSU_MANUAL_PORT_START:-8765}"
PORT_END="${MANSU_MANUAL_PORT_END:-8799}"

manual_path=""
for candidate in \
  "$SKILL_DIR/docs/mansu-manual.html" \
  "$SKILL_DIR/../docs/mansu-manual.html"
do
  if [ -f "$candidate" ]; then
    manual_path="$(cd "$(dirname "$candidate")" && pwd)/$(basename "$candidate")"
    break
  fi
done

if [ -z "$manual_path" ]; then
  echo "FAIL: mansu manual HTML not found" >&2
  echo "Checked:" >&2
  echo "- $SKILL_DIR/docs/mansu-manual.html" >&2
  echo "- $SKILL_DIR/../docs/mansu-manual.html" >&2
  exit 1
fi

manual_dir="$(dirname "$manual_path")"
manual_file="$(basename "$manual_path")"
mkdir -p "$CACHE_DIR"

is_url_ready() {
  local url="$1"
  if command -v curl >/dev/null 2>&1; then
    curl -fsS "$url" >/dev/null 2>&1
  else
    return 1
  fi
}

open_url() {
  local url="$1"
  if command -v open >/dev/null 2>&1; then
    open "$url"
  elif command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$url" >/dev/null 2>&1 &
  else
    echo "OPEN_UNAVAILABLE:$url"
    exit 2
  fi
}

for port in $(seq "$PORT_START" "$PORT_END"); do
  url="http://127.0.0.1:${port}/${manual_file}"
  pid_file="$CACHE_DIR/${port}.pid"
  root_file="$CACHE_DIR/${port}.root"

  if [ -f "$pid_file" ] && kill -0 "$(cat "$pid_file")" >/dev/null 2>&1; then
    if [ -f "$root_file" ] && [ "$(cat "$root_file")" = "$manual_dir" ] && is_url_ready "$url"; then
      open_url "$url"
      echo "OPENED:$url"
      exit 0
    fi
  fi

  if command -v lsof >/dev/null 2>&1 && lsof -iTCP:"$port" -sTCP:LISTEN -n -P >/dev/null 2>&1; then
    continue
  fi

  if ! command -v python3 >/dev/null 2>&1; then
    break
  fi

  log_file="$CACHE_DIR/${port}.log"
  (
    cd "$manual_dir"
    nohup python3 -m http.server "$port" --bind 127.0.0.1 >"$log_file" 2>&1 &
    echo $! >"$pid_file"
  )
  echo "$manual_dir" >"$root_file"

  for _ in 1 2 3 4 5 6 7 8 9 10; do
    if is_url_ready "$url"; then
      open_url "$url"
      echo "OPENED:$url"
      exit 0
    fi
    sleep 0.2
  done

  if [ -f "$pid_file" ]; then
    kill "$(cat "$pid_file")" >/dev/null 2>&1 || true
  fi
done

if command -v open >/dev/null 2>&1; then
  open "$manual_path"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$manual_path" >/dev/null 2>&1 &
else
  echo "OPEN_UNAVAILABLE:$manual_path"
  exit 2
fi

echo "OPENED:$manual_path"
