#!/bin/bash

# mode: dry run se passar --dry
DRY_RUN=false
FORCE_TRASH=false

while [[ "$1" =~ ^- ]]; do
  case "$1" in
    --dry) DRY_RUN=true ;;
    --trash) FORCE_TRASH=true ;; # move pro Lixo em vez de rm -rf
    *) echo "Flag desconhecida: $1"; exit 1 ;;
  esac
  shift
done

# coleta apps instalados
APPS=()
while IFS= read -r -d $'\0' app; do
  APPS+=("$app")
done < <(find /Applications ~/Applications -maxdepth 2 -iname '*.app' -type d -print0 2>/dev/null)

if [ ${#APPS[@]} -eq 0 ]; then
  echo "Nenhum .app encontrado em /Applications ou ~/Applications."
  exit 1
fi

# se não passaram nomes como args, entra interativo
TO_DELETE=()
if [ $# -eq 0 ]; then
  echo "Apps encontrados:"
  for i in "${!APPS[@]}"; do
    printf "[%02d] %s\n" "$i" "$(basename "${APPS[$i]}")"
  done
  echo
  read -p "Digite os números separados por espaço dos apps que quer remover (ex: 0 3 15): " -r selection
  for idx in $selection; do
    if [[ "$idx" =~ ^[0-9]+$ ]] && [ "$idx" -lt "${#APPS[@]}" ]; then
      TO_DELETE+=("${APPS[$idx]}")
    fi
  done
else
  # nomes passados como argumento: case-insensitive match
  for name in "$@"; do
    for app in "${APPS[@]}"; do
      if [[ "$(basename "$app" | tr '[:upper:]' '[:lower:]')" == *"$(echo "$name" | tr '[:upper:]' '[:lower:]')"*".app"* ]]; then
        TO_DELETE+=("$app")
      fi
    done
  done
fi

if [ ${#TO_DELETE[@]} -eq 0 ]; then
  echo "Nenhum app selecionado pra remoção."
  exit 0
fi

echo
echo "=== RESUMO ==="
for app in "${TO_DELETE[@]}"; do
  echo "- $(basename "$app")"
done
echo

read -p "Confirmar remoção? (digite YES) " conf
if [ "$conf" != "YES" ]; then
  echo "Cancelado."
  exit 0
fi

for app in "${TO_DELETE[@]}"; do
  name=$(basename "$app")
  echo ">>> Processando: $name"

  # pegar bundle identifier
  bundle_id=$(defaults read "$app/Contents/Info" CFBundleIdentifier 2>/dev/null || echo "")
  version=$(defaults read "$app/Contents/Info" CFBundleShortVersionString 2>/dev/null || echo "??")
  echo "   versão: $version  bundle_id: ${bundle_id:-(não encontrado)}"

  # limpar restos com base no bundle_id
  if [ -n "$bundle_id" ]; then
    targets=(
      "$HOME/Library/Preferences/${bundle_id}*"
      "$HOME/Library/Caches/${bundle_id}*"
      "$HOME/Library/Application Support/${bundle_id}*"
      "$HOME/Library/Logs/${bundle_id}*"
      "$HOME/Library/LaunchAgents/${bundle_id}*.plist"
      "/Library/LaunchAgents/${bundle_id}*.plist"
      "/Library/LaunchDaemons/${bundle_id}*.plist"
    )
    for t in "${targets[@]}"; do
      if $DRY_RUN; then
        echo "   [DRY] rm -rf $t"
      else
        echo "   removendo $t"
        rm -rf $t 2>/dev/null
      fi
    done
  else
    echo "   bundle_id não detectado; pulando limpeza por identificador."
  fi

  # remover o .app
  if $FORCE_TRASH; then
    if $DRY_RUN; then
      echo "   [DRY] mv \"$app\" ~/.Trash/"
    else
      echo "   movendo para o lixo: $name"
      mv "$app" ~/.Trash/ 2>/dev/null
    fi
  else
    if $DRY_RUN; then
      echo "   [DRY] sudo rm -rf \"$app\""
    else
      echo "   apagando: $name"
      sudo rm -rf "$app"
    fi
  fi

  echo "---"
done

echo "Feito. Revise se precisa reiniciar processos/serviços relacionados."
