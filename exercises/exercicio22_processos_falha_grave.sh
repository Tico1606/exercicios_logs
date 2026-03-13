#!/bin/bash


LOG_FILES=("/var/log/syslog" "/var/log/messages" "/var/log/kern.log")
LOG_FILE=""

for file in "${LOG_FILES[@]}"; do
    if [ -f "$file" ]; then
        LOG_FILE="$file"
        break
    fi
done

if [ -z "$LOG_FILE" ]; then
    echo "Nenhum log do sistema foi encontrado"
    exit 1
fi

echo "=== EVENTOS DE SEGFAULT OU PROCESSO KILLED ==="
echo "Arquivo de log utilizado: $LOG_FILE"
echo


grep -Ei 'segfault|killed process|killed|oom-killer|out of memory' "$LOG_FILE"

echo
echo "Nota: mensagens de OOM Killer tambem foram incluidas por indicarem terminacao forcada de processo."
