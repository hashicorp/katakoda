# acl-policy-server-node.hcl
node_prefix "server-" {
  policy = "write"
}
node_prefix "" {
   policy = "read"
}
service_prefix "" {
   policy = "read"
}