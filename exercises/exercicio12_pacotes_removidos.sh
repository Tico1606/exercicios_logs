#!/bin/bash


LOG_FILES=("/var/log/dpkg.log" "/var/log/dnf.log" "/var/log/yum.log")
LOG_FILE=""

for file in "${LOG_FILES[@]}"; do
    if [ -f "$file" ]; then
        LOG_FILE="$file"
        break
    fi
done

if [ -z "$LOG_FILE" ]; then
    echo "Nenhum log de gerenciador de pacotes foi encontrado"
    exit 1
fi

echo "=== PACOTES REMOVIDOS DO SISTEMA ==="
echo "Arquivo de log utilizado: $LOG_FILE"
echo

if [ "$LOG_FILE" = "/var/log/dpkg.log" ]; then
    awk '$3 == "remove" || $3 == "purge" {
        printf "Data/Hora: %-19s | Acao: %-7s | Pacote: %-35s | Versao: %s\n", $1 " " $2, $3, $4, $5
    }' "$LOG_FILE"
else
    awk '/Removed:|Erased:/ {
        if (match($0, /(Removed:|Erased:) (.*)/, partes)) {
            printf "Data/Hora: %-19s | Acao: %-7s | Pacote: %s\n", $1 " " $2 " " $3, partes[1], partes[2]
        }
    }' "$LOG_FILE"
fi

echo
echo "Nota: 'purge' indica remocao do pacote com limpeza de arquivos de configuracao."
