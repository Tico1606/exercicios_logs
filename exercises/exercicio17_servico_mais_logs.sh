#!/bin/bash


LOG_FILES=("/var/log/syslog" "/var/log/messages" "/var/log/auth.log")
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

echo "=== FREQUENCIA DE MENSAGENS POR SERVICO ==="
echo "Arquivo de log utilizado: $LOG_FILE"
echo


awk '{
    servico = $5
    sub(/\[[0-9]+\]:$/, "", servico)
    sub(/:$/, "", servico)
    if (servico != "" && servico != "kernel") {
        count[servico]++
    }
}
END {
    for (servico in count) {
        printf "%7d %s\n", count[servico], servico
    }
}' "$LOG_FILE" | sort -rn

echo
echo "Nota: a primeira linha da saida representa o servico com maior quantidade de logs."
