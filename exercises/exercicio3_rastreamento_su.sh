#!/bin/bash


if [ -f /var/log/auth.log ]; then
    LOG_FILE="/var/log/auth.log"
elif [ -f /var/log/secure ]; then
    LOG_FILE="/var/log/secure"
else
    echo "Arquivo de log de autenticação não encontrado"
    exit 1
fi

echo "=== RASTREAMENTO DE USO DO COMANDO su (SWITCH USER) ==="
echo


grep "su\[" "$LOG_FILE" | \
    awk '{
        data = $1 " " $2 " " $3
        hora = $4
        
        usuario_origem = ""
        usuario_destino = ""
        
        for (i=1; i<=NF; i++) {
            if ($i == "by") {
                usuario_origem = $(i+1)
                gsub(/[,;]/, "", usuario_origem)
                break
            }
        }
        
        for (i=1; i<=NF; i++) {
            if ($i ~ /^\(to/) {
                usuario_destino = substr($i, 5)
                gsub(/\)/, "", usuario_destino)
                break
            }
        }
        
        if (!usuario_destino) {
            for (i=1; i<=NF; i++) {
                if ($i ~ /to/) {
                    usuario_destino = $(i+1)
                    gsub(/\)/, "", usuario_destino)
                    gsub(/[,;]/, "", usuario_destino)
                    break
                }
            }
        }
        
        printf "Data/Hora: %-20s | De Usuário: %-15s | Para Usuário: %-15s\n", \
            data " " hora, usuario_origem, usuario_destino
    }' | sort

echo
echo "Nota: Este script mostra todas as tentativas de mudança de usuário com o comando su."
