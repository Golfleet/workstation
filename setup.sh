#!/bin/bash

# 1. Identificar o diretório onde o script está localizado
BASE_DIR=$(dirname "$(readlink -f "$0")")
PLAYBOOK="zorin18.yml"
PATH_PLAYBOOK="$BASE_DIR/$PLAYBOOK"

# 2. Verificar se o arquivo ansible existe no diretório
if [[ ! -f "$PATH_PLAYBOOK" ]]; then
    echo "-------------------------------------------------------"
    echo "ERRO: Arquivo $PLAYBOOK não encontrado em $BASE_DIR"
    echo "Certifique-se de que o script shell e o .yml estão na mesma pasta."
    echo "-------------------------------------------------------"
    exit 1
fi

# 3. Função para solicitar entrada e validar se está vazia
get_input() {
    local prompt=$1
    local var_name=$2
    local input=""
    
    while [[ -z "$input" ]]; do
        read -p "$prompt: " input
        if [[ -z "$input" ]]; then
            echo "Este campo é obrigatório. Por favor, preencha."
        fi
    done
    eval "$var_name=\"$input\""
}

echo "--- Configuração do Ambiente Zorin 18 ---"

# Coleta das entradas
get_input "Digite o so_user" SO_USER
get_input "Digite a repo_url" REPO_URL
get_input "Digite o repo_user" REPO_USER
read -s -p "Digite a repo_pass: " REPO_PASS
echo "" # Pular linha após o password

# 4. Mostrar resumo para o usuário
echo -e "\n-------------------------------------------------------"
echo "RESUMO DAS CONFIGURAÇÕES:"
echo "-------------------------------------------------------"
echo "Usuário SO: $SO_USER"
echo "URL Repo:   $REPO_URL"
echo "User Repo:  $REPO_USER"
echo "Password:   ********"
echo "Diretório que será excluído: $BASE_DIR"
echo "-------------------------------------------------------"

read -p "Os dados acima estão corretos? (s/n): " CONFIRM
if [[ $CONFIRM != "s" && $CONFIRM != "S" ]]; then
    echo "Operação cancelada pelo usuário."
    exit 0
fi

# 5. Executar o Ansible Playbook
# Passando as variáveis via extra-vars (-e) para que o Ansible as reconheça
echo -e "\nIniciando execução do Ansible...\n"
ansible-playbook "$PATH_PLAYBOOK" -K -e "so_user=$SO_USER repo_url=$REPO_URL repo_user=$REPO_USER repo_pass=$REPO_PASS"

# 6. Limpar histórico de forma profunda
history -c && history -w

# 7. Excluir o diretório (incluindo o shell script e o playbook)
echo -e "\nLimpando arquivos temporários e diretório..."
# Agendamos a remoção para garantir que o script termine o processo antes da pasta sumir completamente
rm -rf "$BASE_DIR"

# 8. Resumo final e Reboot
echo "-------------------------------------------------------"
echo "OPERAÇÃO CONCLUÍDA COM SUCESSO"
echo "O histórico foi limpo e os arquivos locais foram removidos."
echo "-------------------------------------------------------"

read -p "Deseja reiniciar o sistema agora? (s/n): " REBOOT_CONFIRM
if [[ $REBOOT_CONFIRM == "s" || $REBOOT_CONFIRM == "S" ]]; then
    echo "Reiniciando..."
    sudo reboot
else
    echo "Reboot cancelado. Lembre-se de reiniciar manualmente se necessário."
fi
