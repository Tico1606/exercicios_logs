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

echo "=== ULTIMO BOOT DO SISTEMA ==="
echo "Arquivo de log utilizado: $WTMP_FILE"
echo


last -x -f "$WTMP_FILE" | \
    awk '/reboot/ {
        printf "Ultimo boot: %s %s %s %s %s %s\n", $1, $4, $5, $6, $7, $8
        found = 1
        exit
    }
    END {
        if (!found) {
            print "Nenhum evento de boot foi encontrado no log"
        }
    }'

echo
echo "Nota: o comando consulta o arquivo wtmp, que registra eventos de login e boot."
