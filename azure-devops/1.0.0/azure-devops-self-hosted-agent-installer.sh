#!/bin/bash
# Replace with your Azure Key Vault details
key_vault_name=""
secret_name=""
ado_url=""
ado_pool=""
ado_project=""

# Parse named arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --key_vault_name) key_vault_name="$2"; shift ;;
    --secret_name) secret_name="$2"; shift ;;
    --ado_url) ado_url="$2"; shift ;;
    --ado_pool) ado_pool="$2"; shift ;;
    --ado_project) ado_project="$2"; shift ;;
    *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
  shift
done

if [[ -z "$key_vault_name" || -z "$secret_name" || -z "$ado_url" || -z "$ado_pool" || -z "$ado_project" ]]; then
  echo "Missing required arguments."
  exit 1
fi

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
        --auth PAT --token ${pat_token} --runasservice --replace  
    sudo ./svc.sh install
    sudo ./svc.sh start
    else ./config.sh --pool ${ado_pool} --acceptteeeula --agent $HOSTNAME \
        --url ${ado_url} --work _work --projectname ${ado_project} \
        --auth PAT --token ${pat_token} --replace
    ./run.sh
fi