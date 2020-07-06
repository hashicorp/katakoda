#!/usr/bin/env bash
# shellcheck disable=SC2143

export log_dir="/root/.log"
export VAULT_ADDR='http://[[HOST_SUBDOMAIN]]-8200-[[KATACODA_HOST]].environments.katacoda.com'

vault login "$(grep 'Initial Root Token' .vault-init | awk '{print $NF}')" \
>> "$log_dir"/04-perform-actions.log

sleep 1

if vault kv list kv/ | grep -q 50-secret; then
    pass=true
else
    echo "Cannot list 50-secret" >> "$log_dir"/04-perform-actions.log
    pass=false
fi

if vault secrets list --detailed | grep kv | grep -q; then
    pass=true
else
    echo "Cannot list kv v2 secrets engine" >> "$log_dir"/04-perform-actions.log
    pass=false
fi

if vault auth list | grep -q userpass; then
    pass=true
else
    echo "Cannot list userpass auth method" >> "$log_dir"/04-perform-actions.log
    pass=false
fi

if vault list auth/userpass/users/ | grep -q learner; then
    pass=true
else
    echo "Cannot list userpass leaerner user" >> "$log_dir"/04-perform-actions.log
    pass=false
fi

if [ "$pass" = "true" ]; then
    echo "done"
else
    echo "verifications failed" >> "$log_dir"/04-perform-actions.log
fi

