Kind = "ingress-gateway"
Name = "ingress-service"

Listeners = [
 {
   Port = 8080
   Protocol = "http"
   Services = [
     {
       Name = "dashboard"
       Hosts = ["*"]
     }
   ]
 }
]