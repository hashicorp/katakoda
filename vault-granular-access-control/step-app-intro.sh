export VAULT_ADDR=http://0.0.0.0:8200

vault login root

vault policy write apps-policy apps-policy.hcl

USERPASS_ACCESSOR=$(vault auth list -format=json | jq -r '.["userpass/"].accessor')

vault write auth/userpass/users/apps \
  password=apps-password \
  policies=apps-policy

# app1 secrets and user

vault kv put external-apis/app1/socials/twitter \
  api_key=MQfS4XAJXYE3SxTna6Yzrw \
  api_secret_key=uXZ4VHykCrYKP64wSQ72SRM10WZwirnXq5rmyiLnVk

vault kv put external-apis/app1/socials/instagram \
  api_key=vQYPLeiRFpr3cKLa7HCowQ \
  api_secret_key=2Z3RxDxkgZ4qE39s3NYgwzHdHuNRriCAPb4nq2q7va

vault write auth/userpass/users/app1 \
  password=app1-password \
  policies=apps-policy

vault write identity/entity name="app1"

APP1_CAN_ID=$(vault read -format=json identity/entity/name/app1 | jq -r '.["data"]["id"]')

vault write identity/entity-alias \
  name="app1" \
  canonical_id=$APP1_CAN_ID \
  mount_accessor=$USERPASS_ACCESSOR

# app2 user

vault kv put external-apis/app2/socials/twitter \
  api_key=MQfS4XAJXYE3SxTna6Yzrw \
  api_secret_key=uXZ4VHykCrYKP64wSQ72SRM10WZwirnXq5rmyiLnVk

vault kv put external-apis/app2/socials/instagram \
  api_key=vQYPLeiRFpr3cKLa7HCowQ \
  api_secret_key=2Z3RxDxkgZ4qE39s3NYgwzHdHuNRriCAPb4nq2q7va

vault write auth/userpass/users/app2 \
  password=app2-password \
  policies=apps-policy

vault write identity/entity name="app2"

APP2_CAN_ID=$(vault read -format=json identity/entity/name/app2 | jq -r '.["data"]["id"]')

vault write identity/entity-alias \
  name="app2" \
  canonical_id=$APP2_CAN_ID \
  mount_accessor=$USERPASS_ACCESSOR
