#-----------------------------------------------------------------------------------
# To configure Transform secrets engine, you need vault provider v2.12.0 or later
#-----------------------------------------------------------------------------------
terraform {
  required_providers {
    vault = "~> 2.12"
  }
}

#------------------------------------------------------------------------------
# To leverate more than one namespace, define a vault provider per namespace
#------------------------------------------------------------------------------
provider "vault" {
  alias = "finance"
  namespace = "finance"
}

provider "vault" {
  alias = "engineering"
  namespace = "engineering"
}

#------------------------------------------------------------------------------
# Create namespaces: finance, and engineering
#------------------------------------------------------------------------------
resource "vault_namespace" "finance" {
  path = "finance"
}

resource "vault_namespace" "engineering" {
  path = "engineering"
}
