Vault's secret engines generate passwords that adhere to a default pattern that
may not meet the standards required by your applications or within your
organization.

Vault 1.5 introduced support for configurable password generation defined by
a password policy. A policy defines the rules and requirements that the password
must adhere and can provide that password directly through a new endpoint or
within secrets engines.
