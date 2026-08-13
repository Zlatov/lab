#!/usr/bin/env bash
# Удаляет сессии Claude Code, переименованные (/rename) в "DEL".
#
# По умолчанию — dry-run (только показывает, что будет удалено).
# Для реального удаления: ./clean-del-sessions.sh --force
#
# Ищет во всех проектах ~/.claude/projects/*/*.jsonl файлы,
# у которых первые строки содержат {"type":"custom-title","customTitle":"DEL",...}
# Вместе с .jsonl удаляет и одноимённую папку-компаньон (sessionId/),
# если она существует (там лежат транскрипты сабагентов и т.п.).

set -euo pipefail

PROJECTS_DIR="$HOME/.claude/projects"
FORCE=false

for arg in "$@"; do
  case "$arg" in
    --force) FORCE=true ;;
    -h|--help)
      echo "Usage: $0 [--force]"
      echo "  без флагов — dry-run, только показывает найденные сессии"
      echo "  --force    — реально удаляет файлы и папки-компаньоны"
      exit 0
      ;;
  esac
done

if [ ! -d "$PROJECTS_DIR" ]; then
  echo "Не найдена директория $PROJECTS_DIR" >&2
  exit 1
fi

mapfile -d '' -t files < <(grep -rlZ '"type":"custom-title","customTitle":"DEL"' "$PROJECTS_DIR"/*/*.jsonl 2>/dev/null || true)

if [ "${#files[@]}" -eq 0 ]; then
  echo "Сессий с меткой DEL не найдено."
  exit 0
fi

total_size=0
echo "Найдено сессий: ${#files[@]}"
echo

for f in "${files[@]}"; do
  size=$(stat -c%s "$f")
  total_size=$((total_size + size))
  dir="${f%.jsonl}"
  echo "  $f ($(numfmt --to=iec-i --suffix=B "$size" 2>/dev/null || echo "${size}B"))"
  if [ -d "$dir" ]; then
    dsize=$(du -sb "$dir" 2>/dev/null | cut -f1)
    total_size=$((total_size + dsize))
    echo "    + папка-компаньон: $dir"
  fi
done

echo
echo "Итого к освобождению: $(numfmt --to=iec-i --suffix=B "$total_size" 2>/dev/null || echo "${total_size}B")"

if [ "$FORCE" != true ]; then
  echo
  echo "Это был dry-run. Ничего не удалено."
  echo "Запустите с флагом --force, чтобы удалить эти файлы."
  exit 0
fi

echo
for f in "${files[@]}"; do
  dir="${f%.jsonl}"
  rm -f -- "$f"
  if [ -d "$dir" ]; then
    rm -rf -- "$dir"
  fi
done

echo "Удалено сессий: ${#files[@]}"
