#!/bin/bash
# Replace with your Azure Key Vault details
key_vault_name=${AZURE_KEYVAULT_NAME}
secret_name=${AZURE_KEYVAULT_PAT_SECRET_NAME}
ado_url=${AZURE_DEVOPS_ORGANIZTION_URL}
ado_pool=${AZURE_DEVOPS_POOL_NAME}
ado_project=${AZURE_DEVOPS_PROJECT_NAME}

# Get the access token for the managed identity
access_token=$(curl -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net" | jq -r '.access_token')

# Fetch the secret using Azure REST API
pat_token=$(curl -s "https://${key_vault_name}.vault.azure.net/secrets/${secret_name}/?api-version=7.1" -H "Authorization: Bearer ${access_token}" | jq -r '.value')

export AGENT_ALLOW_RUNASROOT="1"
mkdir azagent
cd azagent
curl -fkSL -o vstsagent.tar.gz https://vstsagentpackage.azureedge.net/agent/3.220.5/vsts-agent-linux-x64-3.220.5.tar.gz
tar -zxvf vstsagent.tar.gz
if [ -x "$(command -v systemctl)" ]
    then ./config.sh --pool ${ado_pool} --acceptteeeula --agent $HOSTNAME \
        --url ${ado_url} --work _work --projectname ${ado_project} \
        --auth PAT --token ${pat_token} --runasservice
    sudo ./svc.sh install
    sudo ./svc.sh start
    else ./config.sh --pool ${ado_pool} --acceptteeeula --agent $HOSTNAME \
    --url ${ado_url} --work _work --projectname ${ado_project} \
    --auth PAT --token $pat_token}
    ./run.sh
fi