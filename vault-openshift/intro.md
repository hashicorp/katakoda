RedHat's OpenShift is a distribution of the Kubernetes platform that provides a
number of usability and security enhancements.

In this tutorial, you login to an OpenShift cluster, install Vault via the Helm
chart and then configure the authentication between Vault and the cluster. Then
you deploy two web applications. One that authenticates and requests secrets
directly from the Vault server. The other that employs deployment annotations
that enable it to remain Vault unaware.
