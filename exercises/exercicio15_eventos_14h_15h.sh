#!/bin/bash


if [ -z "$1" ]; then
    echo "Uso: $0 AAAA-MM-DD [arquivo_de_log]"
    exit 1
fi

DATA_ALVO="$1"
LOG_FILE="$2"

if [ -z "$LOG_FILE" ]; then
    if [ -f /var/log/syslog ]; then
        LOG_FILE="/var/log/syslog"
    elif [ -f /var/log/messages ]; then
        LOG_FILE="/var/log/messages"
    else
        echo "Nenhum log padrao foi encontrado"
        exit 1
    fi
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "Arquivo de log nao encontrado: $LOG_FILE"
    exit 1
fi

MES=$(date -d "$DATA_ALVO" '+%b' 2>/dev/null)
DIA=$(date -d "$DATA_ALVO" '+%-d' 2>/dev/null)

if [ -z "$MES" ] || [ -z "$DIA" ]; then
    echo "Data invalida. Use o formato AAAA-MM-DD"
    exit 1
fi

echo "=== EVENTOS ENTRE 14H E 15H ==="
echo "Data filtrada: $DATA_ALVO"
echo "Arquivo de log utilizado: $LOG_FILE"
echo


awk -v mes="$MES" -v dia="$DIA" '$1 == mes && ($2 + 0) == (dia + 0) && $3 >= "14:00:00" && $3 < "15:00:00" {
    print
}' "$LOG_FILE"

echo
echo "Nota: se o formato do log for diferente do syslog tradicional, ajuste os campos no awk."
