#!/bin/bash

# EXERCÍCIO 1: Listar usuários com tentativas de login com senha incorreta
# Objetivo: Mostrar o nome do usuário e o número de tentativas de login falhas
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

echo "=== RELATÓRIO DE TENTATIVAS DE LOGIN COM SENHA INCORRETA ==="
echo

# Comando explicado:
# grep: busca por linhas contendo "Invalid password" ou "Failed password"
#   - essas são as mensagens típicas para tentativas de senha incorreta
# awk: extrai o nome do usuário (geralmente a palavra após "for user")
# sort: ordena os usuários
# uniq -c: conta ocorrências de cada usuário
# sort -rn: ordena em ordem decrescente pelo número de tentativas

grep -E "(Invalid password|Failed password)" "$LOG_FILE" | \
    grep -oP "user=\K\w+" | \
    sort | \
    uniq -c | \
    sort -rn | \
    awk '{printf "Usuário: %-15s | Tentativas de Login Falhadas: %d\n", $2, $1}'

echo
echo "Nota: Se nenhum resultado aparecer, pode não haver tentativas registradas no log."
