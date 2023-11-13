# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

mkdir -p learn-terraform/assets

cd learn-terraform

# Include current dir in prompt
PS1='\W$ '

# Prevent `yes` command from accidentally being run
alias yes=""

clear