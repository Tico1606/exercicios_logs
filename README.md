# Lista de Exercícios - Análise de Logs do Sistema

## 📋 Descrição

Coleção de scripts shell para análise e rastreamento de eventos do sistema Linux através de logs internos (`/var/log`). Os exercícios cobrem autenticação, atividade do sistema, gerenciamento de pacotes e falhas críticas.

---

## 🚀 Como Rodar os Scripts

### Pré-requisitos

- **Ambiente**: Linux com bash
- **Acesso**: Alguns scripts requerem privilégios de `root` para ler logs protegidos
- **Localização**: Coloque todos os arquivos `.sh` no mesmo diretório

### Execução Básica

1. **Abra um terminal** no diretório do projeto
2. **Torne os scripts executáveis** (opcional):
   ```bash
   chmod +x exercicio*.sh
   ```

3. **Execute um script** sem parâmetros:
   ```bash
   bash exercicio6_ultimo_boot.sh
   # ou
   ./exercicio6_ultimo_boot.sh
   ```

### Grupos de Exercícios

#### 1️⃣ **Tentativas de Senha (Ex. 1-5)**
| Exercício | Comando | Descrição |
|-----------|---------|-----------|
| 1 | `bash exercicio1_login_falhos.sh` | Usuários com login falhos e contagem |
| 2 | `bash exercicio2_logins_sucesso.sh` | Logins bem-sucedidos |
| 3 | `bash exercicio3_rastreamento_su.sh` | Rastreamento do comando `su` |
| 4 | `bash exercicio4_auditoria_sudo.sh` | Auditoria de uso do `sudo` |
| 5 | `bash exercicio5_logins_rejeitados.sh` | Logins rejeitados (outros motivos) |

#### 2️⃣ **Análise de Atividade do Sistema (Ex. 6-10)**
| Exercício | Comando | Descrição |
|-----------|---------|-----------|
| 6 | `bash exercicio6_ultimo_boot.sh` | Última inicialização do sistema |
| 7 | `bash exercicio7_shutdowns_reboots.sh` | Eventos de shutdown/reboot |
| 8 | `bash exercicio8_erros_kernel.sh` | Erros e falhas do kernel |
| 9 | `bash exercicio9_servicos_alterados.sh` | Serviços iniciados/parados |
| 10 | `bash exercicio10_hardware_problemas.sh` | Problemas com hardware |

#### 3️⃣ **Análise de Pacotes (Ex. 11-13)**
| Exercício | Comando | Descrição |
|-----------|---------|-----------|
| 11 | `bash exercicio11_pacotes_instalados_semana.sh` | Pacotes instalados na última semana |
| 12 | `bash exercicio12_pacotes_removidos.sh` | Pacotes removidos |
| 13 | `bash exercicio13_rastreamento_pacotes.sh` | Rastreamento de apt/dpkg |

#### 4️⃣ **Análise de Períodos (Ex. 14-15)**
| Exercício | Comando | Descrição |
|-----------|---------|-----------|
| 14 | `bash exercicio14_tempo_atividade.sh` | Diferença entre boot e shutdown |
| 15 | `bash exercicio15_eventos_14h_15h.sh [DATA]` | Eventos entre 14h e 15h |

#### 5️⃣ **Falhas Críticas e Erros (Ex. 16-23)**
| Exercício | Comando | Descrição |
|-----------|---------|-----------|
| 16 | `bash exercicio16_falhas_criticas.sh` | Mensagens critical/fatal/segfault |
| 17 | `bash exercicio17_servico_mais_logs.sh` | Serviço com mais logs |
| 18 | `bash exercicio18_login_falho_metodo.sh` | Login falho e método de autenticação |
| 19 | `bash exercicio19_monitor_login_falho_tempo_real.sh` | Monitor em tempo real de logins falhos |
| 20 | `bash exercicio20_pacotes_atualizados.sh` | Pacotes atualizados |
| 21 | `bash exercicio21_erros_servico.sh [SERVIÇO]` | Erros/avisos de um serviço |
| 22 | `bash exercicio22_processos_falha_grave.sh` | Processos com segfault/killed |
| 23 | `bash exercicio23_tempo_logado_usuario.sh [USUÁRIO]` | Tempo de sessão de um usuário |

---

## 📝 Scripts com Parâmetros

Alguns scripts aceitam argumentos:

### Exercício 15 - Filtro por Data
```bash
bash exercicio15_eventos_14h_15h.sh 2023-03-10
```
- **Parâmetro**: Data em formato `YYYY-MM-DD`
- **Retorno**: Eventos entre 14h e 15h naquele dia

### Exercício 21 - Erros de um Serviço
```bash
bash exercicio21_erros_servico.sh sshd
bash exercicio21_erros_servico.sh cron
```
- **Parâmetro**: Nome do serviço
- **Retorno**: Mensagens de erro e aviso desse serviço

### Exercício 23 - Tempo de Login de um Usuário
```bash
bash exercicio23_tempo_logado_usuario.sh alberto
bash exercicio23_tempo_logado_usuario.sh root
```
- **Parâmetro**: Nome do usuário
- **Retorno**: Duração total das sessões do usuário

---

## ⚠️ Notas Importantes

1. **Privilégios**: Execute com `sudo` se receber erros de permissão:
   ```bash
   sudo bash exercicio6_ultimo_boot.sh
   ```

2. **Disponibilidade de Logs**: Os scripts buscam em `/var/log`. Se um log não existir, o script exibirá "Nenhum registro encontrado".

3. **Distribuição Linux**: Scripts testados para Debian/Ubuntu e RedHat/CentOS. Alguns logs podem estar em locais diferentes em outras distribuições.

4. **Monitoramento em Tempo Real** (Ex. 19): O script mantém o log em `tail -f`. Pressione `Ctrl+C` para sair.

5. **Comentários no Código**: Abra qualquer arquivo `.sh` em um editor para ver comentários explicando cada comando e o raciocínio do pipeline.

---

## 📚 Estrutura dos Logs

| Exercício | Logs Utilizados |
|-----------|-----------------|
| 1-5 | `/var/log/auth.log` ou `/var/log/secure` |
| 6-7 | `/var/log/syslog` ou `/var/log/messages` |
| 8 | `/var/log/kern.log` ou `/var/log/messages` |
| 9 | `/var/log/syslog` ou `/var/log/messages` |
| 10 | `/var/log/syslog` ou `/var/log/messages` |
| 11-13 | `/var/log/apt/history.log` ou `/var/log/yum.log` |
| 14-15 | `/var/log/syslog` ou `/var/log/messages` |
| 16-23 | Vários (cada script detecta o log apropriado) |

---

## 🔧 Troubleshooting

### "Permissão negada"
```bash
sudo bash exercicio_numero.sh
```

### "Arquivo não encontrado"
Verifique se os logs existem em sua distribuição:
```bash
ls -la /var/log/auth.log    # Debian/Ubuntu
ls -la /var/log/secure      # RedHat/CentOS
```

### "Nenhum resultado"
Significa que não há registros para o filtro especificado. Verifique:
- Se o log existe
- Se há dados suficientes no período consultado
- Se você tem permissão de leitura

---

## 💡 Exemplo de Uso Completo

```bash
# 1. Listar último boot
bash exercicio6_ultimo_boot.sh

# 2. Ver usuários com login falho
bash exercicio1_login_falhos.sh

# 3. Monitorar logins falhos em tempo real
bash exercicio19_monitor_login_falho_tempo_real.sh &

# 4. Verificar erros do SSH
bash exercicio21_erros_servico.sh sshd

# 5. Ver tempo de login de um usuário
bash exercicio23_tempo_logado_usuario.sh `whoami`
```

---

**Versão**: 1.0  
**Compatibilidade**: Linux (Debian/Ubuntu, RedHat/CentOS)
# exercicios_logs
