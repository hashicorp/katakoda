Kind           = "service-resolver"
Name           = "backend"
LoadBalancer = {
  Policy = "maglev"
  HashPolicies = [
    {
      Field = "header"
      FieldValue = "x-user-id"
    }
  ]
}
