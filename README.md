# Exercícios UFW vs iptables

Este repositório contém uma lista de exercícios (em `lista.md`) e uma pasta `exercicios/` com um arquivo por exercício (ex01.md … ex21.md), cada um mostrando os comandos equivalentes para:

- **UFW** (Uncomplicated Firewall) — ferramenta de alto nível para Ubuntu/Debian.
- **iptables** — ferramenta de baixo nível para manipular as tabelas do Netfilter.

---

## Como usar

1. **Abra o exercício desejado**
   - Por exemplo: `exercicios/ex01.md` é o exercício 1.
   - Os arquivos são numerados na mesma ordem do `lista.md`.

2. **Execute os comandos na sua máquina Linux**
   - Use um terminal e execute os comandos listados em cada arquivo.
   - A maioria dos comandos exige `sudo`.

3. **Recomendações**
   - Se estiver testando em ambiente produtivo, faça backup das regras locais antes de alterar:
     ```bash
     sudo iptables-save > ~/iptables-backup-$(date +%F).rules
     ```
   - Para restaurar:
     ```bash
     sudo iptables-restore < ~/iptables-backup-<date>.rules
     ```
   - No caso de UFW:
     ```bash
     sudo ufw status verbose
     sudo ufw reset  
     ```

4. **Rodando em WSL (Windows Subsystem for Linux)**
   - O WSL pode não suportar todos os recursos de `ufw`/`iptables` (especialmente networking avançado).
   - Use um ambiente Linux real ou uma VM para testes completos.

---

## Estrutura do repositório

- `lista.md`: enunciado completo dos exercícios.
- `exercicios/ex01.md` … `exercicios/ex21.md`: respostas com comandos UFW + iptables.

---

## Observações importantes

- `iptables` é uma ferramenta poderosa; regras erradas podem “travar” o acesso à máquina (inclusive SSH).
- Sempre teste localmente (e.g., em uma VM) antes de aplicar em produção.
- Muitos sistemas modernos usam `nftables` em vez de `iptables`; os comandos aqui são para `iptables` clássico.
