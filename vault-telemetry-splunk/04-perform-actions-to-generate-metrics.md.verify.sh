#!/usr/bin/env bash
# shellcheck disable=SC2143

export log_dir="/home/scrapbook/tutorial/.log"

kv_v2_enabled="$(vault secrets list --detailed | grep kv/ | grep -q 'version:2'; echo $?)"
50_secret_present="$(vault kv list kv/ | grep -q 50-secret ; echo $?)"
userpass_enabled="$(vault auth list | grep -q userpass/ ; echo $?)"
learner_user_present="$(vault list auth/userpass/users/ | grep -q learner ; echo $?)"

if [ "${kv_v2_enabled}" = "0" ] && [ "${50_secret_present}" = "0" ] && [ "${userpass_enabled}" = "0" ] && [ "${learner_user_present}" = "0" ]; then
  echo "done"
else
  echo "something is wrong" >> "$log_dir"/04-perform-actions.log
fi
