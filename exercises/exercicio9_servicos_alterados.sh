#!/bin/bash


LOG_FILES=("/var/log/syslog" "/var/log/messages")
LOG_FILE=""

for file in "${LOG_FILES[@]}"; do
    if [ -f "$file" ]; then
        LOG_FILE="$file"
        break
    fi
done

if [ -z "$LOG_FILE" ]; then
    echo "Nenhum log de servicos foi encontrado"
    exit 1
fi

echo "=== SERVICOS INICIADOS OU PARADOS RECENTEMENTE ==="
echo "Arquivo de log utilizado: $LOG_FILE"
echo


grep -Ei 'systemd\[[0-9]+\]: (Started|Stopped|Starting|Stopping|Restarted|Reloaded)|service.*(started|stopped)' "$LOG_FILE" | \
    awk '{
        data_hora = $1 " " $2 " " $3
        acao = "ALTERADO"
        servico = "desconhecido"

        if (match($0, /(Started|Stopped|Starting|Stopping|Restarted|Reloaded) (.*)\./, parts)) {
            acao = parts[1]
            servico = parts[2]
        } else if (match($0, /service ([^ ]+) (started|stopped)/, parts)) {
            servico = parts[1]
            acao = parts[2]
        }

        printf "Data/Hora: %-15s | Acao: %-10s | Servico: %s\n", data_hora, acao, servico
    }'

echo
echo "Nota: o script procura mensagens de systemd e de servicos registrados no syslog tradicional."
