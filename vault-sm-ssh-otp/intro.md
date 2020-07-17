By default, SSH servers use password authentication with optional public key
authentication. If any user on the system has a fairly weak password, this
allows an attacker to hijack the SSH connection.

Vault can create a one-time password (OTP) for SSH authentication on a network
every time a client wants to SSH into a remote host using a helper command on
the remote host to perform verification.
