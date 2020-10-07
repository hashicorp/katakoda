Kind           = "service-resolver"
Name           = "backend"
LoadBalancer = {
  Policy = "least_request"
  LeastRequestConfig = {
    ChoiceCount = "2"
  }
}