#!/bin/bash
ansible-galaxy collection install azure.azcollection
pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
ansible-galaxy collection install community.docker
ansible-galaxy collection install kubernetes.core
ansible-galaxy collection install microsoft.ad
pip3 install pywinrm