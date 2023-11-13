# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

if [[ `hcltool /etc/consul.d/config.hcl | jq .acl.enabled` == true ]]
then 
  echo "done"
else 
  echo "ACLs are not enabled"
fi