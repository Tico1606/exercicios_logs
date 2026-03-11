#!/bin/bash

# EXERCÍCIO 2: Gerar relatório de todos os logins bem-sucedidos
# Objetivo: Mostrar o nome do usuário e a data/hora do acesso
# Arquivo de log utilizado: /var/log/auth.log (ou /var/log/secure em sistemas RedHat)

# Verificar qual arquivo de log existe no sistema
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

# Comando explicado:
# grep "Accepted": busca por linhas que contêm "Accepted" (login bem-sucedido)
# awk: extrai a data (campos 1-3), a hora (campo 4), o usuário (após "for user")
# sort: ordena os resultados por data e hora

grep "Accepted" "$LOG_FILE" | \
    awk '{
        # Extrai data e hora (MMM DD HH:MM:SS)
        data = $1 " " $2 " " $3
        hora = $4
        
        # Procura pela linha que contém "for user" e extrai o usuário
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
        
        # Se não encontrou, tenta outra abordagem
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
