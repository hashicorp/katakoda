The OpenShift CLI is accessed using the command `oc`. From here, you can
administrate the entire OpenShift cluster and deploy new applications. The CLI
exposes the underlying Kubernetes orchestration system with the enhancements
made by OpenShift.

To install Vault via the Helm chart in the next step requires that you are
logged in as administrator within a project.

Login to the OpenShift cluster with as the user `admin` with the password
`admin`.

```shell
oc login -u admin -p admin
```{{execute}}

