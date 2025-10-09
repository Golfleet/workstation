# Automação de Workstation

Esse repositório contem playbooks Ansible e jinja2 para automatizar o processo de instalação de workstations.

> **_Observação:_**  
> Utilize a **playbook** referente ao sistema operacional da workstation:  
> Playbook zorin16.yml - Testado em ZorinOS 16 (Ubuntu 20.04 LTS)  
> Playbook zorin18.yml - Testado em ZorinOS 18 (Ubuntu 24.04 LTS)
___

## Instalação

1. Instale o Ansible
```bash
sudo apt update && sudo apt install ansible unzip git -y
```
2. Clone esse repositório
```bash
git clone https://github.com/Golfleet/workstation.git
```

3. Preencha as variáveis no playbook Ansible que será utilizado 
```bash
nano workstation/zorin18.yml
#  vars:
#    so_user: 
#    repo_url: 
#    repo_user: 
#    repo_pass: 
```

4. Execute o playbook Ansible
```bash
ansible-playbook workstation/zorin18.yml -K
```
> Digite sua senha quando for solicitado, alguns processos exigem acesso root.
___

