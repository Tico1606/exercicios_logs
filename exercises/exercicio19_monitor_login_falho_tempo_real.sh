#!/bin/bash


if [ -f /var/log/auth.log ]; then
    LOG_FILE="/var/log/auth.log"
elif [ -f /var/log/secure ]; then
    LOG_FILE="/var/log/secure"
else
    echo "Arquivo de log de autenticacao nao encontrado"
    exit 1
fi

echo "=== MONITORAMENTO EM TEMPO REAL DE LOGIN FALHO ==="
echo "Arquivo de log utilizado: $LOG_FILE"
echo "Pressione Ctrl+C para encerrar o monitoramento."
echo


tail -Fn0 "$LOG_FILE" | grep --line-buffered -Ei 'Failed password|authentication failure|FAILED LOGIN|Login incorrect|Invalid user'
