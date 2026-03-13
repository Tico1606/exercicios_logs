#!/bin/bash


if [ -f /var/log/auth.log ]; then
    LOG_FILE="/var/log/auth.log"
elif [ -f /var/log/secure ]; then
    LOG_FILE="/var/log/secure"
else
    echo "Arquivo de log de autenticação não encontrado"
    exit 1
fi

echo "=== RELATÓRIO DE TENTATIVAS DE LOGIN COM SENHA INCORRETA ==="
echo


grep -E "(Invalid password|Failed password)" "$LOG_FILE" | \
    grep -oP "user=\K\w+" | \
    sort | \
    uniq -c | \
    sort -rn | \
    awk '{printf "Usuário: %-15s | Tentativas de Login Falhadas: %d\n", $2, $1}'

echo
echo "Nota: Se nenhum resultado aparecer, pode não haver tentativas registradas no log."
