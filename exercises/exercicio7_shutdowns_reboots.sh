#!/bin/bash


WTMP_FILE="/var/log/wtmp"

if [ ! -f "$WTMP_FILE" ]; then
    echo "Arquivo de log $WTMP_FILE nao encontrado"
    exit 1
fi

if ! command -v last >/dev/null 2>&1; then
    echo "Comando 'last' nao encontrado no sistema"
    exit 1
fi

echo "=== EVENTOS DE SHUTDOWN E REBOOT ==="
echo "Arquivo de log utilizado: $WTMP_FILE"
echo


last -x -f "$WTMP_FILE" | \
    egrep 'reboot|shutdown' | \
    awk '{
        tipo = ($1 == "reboot") ? "REBOOT" : "SHUTDOWN"
        printf "Tipo: %-10s | Data/Hora: %s %s %s %s %s\n", tipo, $4, $5, $6, $7, $8
    }'

echo
echo "Nota: a listagem e exibida em ordem do evento mais recente para o mais antigo."
