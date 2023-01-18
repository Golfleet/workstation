# Automação de Workstation

Esse repositório contem scripts ansible e jinja2 para automatizar o processo de instalação de workstations.

> **_Observação_** :  
> Testado em Ubuntu 22.04 LTS
___

## Instalação

1. Instale o Ansible
```bash
sudo apt update && sudo apt install ansible unzip git -y
```
2. Clone esse repositório
```bash
git clone https://github.com/asf-git/workstation.git
```

3. Execute o script ansible
```bash
ansible-playbook workstation/ubuntu.yml -K
```
> Digite sua senha quando for solicitado, alguns processos exigem acesso root.
___

