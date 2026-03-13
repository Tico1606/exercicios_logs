#!/bin/bash


if [ -f /var/log/auth.log ]; then
    LOG_FILE="/var/log/auth.log"
elif [ -f /var/log/secure ]; then
    LOG_FILE="/var/log/secure"
else
    echo "Arquivo de log de autenticação não encontrado"
    exit 1
fi

echo "=== RELATÓRIO DE LOGINS BEM-SUCEDIDOS NO SISTEMA ==="
echo


grep "Accepted" "$LOG_FILE" | \
    awk '{
        data = $1 " " $2 " " $3
        hora = $4
        
        for (i=1; i<=NF; i++) {
            if ($i == "user=" || $i == "for") {
                if ($i == "for" && $(i+1) ~ /^[^=]+$/) {
                    usuario = $(i+1)
                    break
                } else if ($i == "user=") {
                    usuario = $(i+1)
                    gsub(/[,;]/, "", usuario)
                    break
                }
            }
        }
        
        if (!usuario) {
            for (i=1; i<=NF; i++) {
                if ($i ~ /user=/) {
                    usuario = substr($i, 6)
                    gsub(/[,;]/, "", usuario)
                    break
                }
            }
        }
        
        printf "Data/Hora: %-20s | Usuário: %-15s | Tipo: %s\n", data " " hora, usuario, $NF
    }' | sort

echo
echo "Nota: Este script mostra todos os acessos bem-sucedidos ao sistema."
