#!/usr/bin/env bash
# Tests bin/ralph's stop/continue protocol with a fake `claude` on PATH.
set -euo pipefail

RALPH="$(cd "$(dirname "$0")" && pwd)/ralph"
failures=0

# run_case <name> <fake-claude-body> <expected-exit> <expected-runs>
run_case() {
  local name="$1" body="$2" want_exit="$3" want_runs="$4"
  local work
  work="$(mktemp -d)"
  mkdir -p "$work/fakebin"
  printf '#!/usr/bin/env bash\necho run >> "$PWD/runs"\n[[ $(wc -l < "$PWD/runs") -gt 5 ]] && exit 99 # runaway guard\n%s\n' "$body" > "$work/fakebin/claude"
  chmod +x "$work/fakebin/claude"
  echo "prompt" > "$work/prompt.md"

  local got_exit=0
  (cd "$work" && PATH="$work/fakebin:$PATH" "$RALPH" prompt.md >/dev/null 2>&1) || got_exit=$?
  local got_runs
  got_runs="$(wc -l < "$work/runs" | tr -d ' ')"

  if [[ "$got_exit" == "$want_exit" && "$got_runs" == "$want_runs" ]]; then
    echo "ok   $name"
  else
    echo "FAIL $name: exit $got_exit (want $want_exit), runs $got_runs (want $want_runs)"
    failures=$((failures + 1))
  fi
  rm -rf "$work"
}

run_case "stops when no continue signal is written" \
  'exit 0' 0 1

run_case "continues once when the first run signals, then stops" \
  '[[ $(wc -l < "$PWD/runs") -eq 1 ]] && echo "more todos" > .ralph/continue; exit 0' 0 2

run_case "stops and passes through a non-zero exit" \
  'echo "more todos" > .ralph/continue; exit 3' 3 1

run_case "turns the superpowers plugin off for its runs" \
  '[[ "$*" == *"\"superpowers@claude-plugins-official\":false"* ]] || exit 4; exit 0' 0 1

exit "$failures"
