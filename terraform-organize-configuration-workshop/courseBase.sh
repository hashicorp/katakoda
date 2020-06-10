mkdir -p learn-terraform/assets

cd learn-terraform

touch {main.tf,variables.tf,outputs.tf}

# Include current dir in prompt
PS1='\W$ '

# Prevent `yes` command from accidentally being run
alias yes=""

clear