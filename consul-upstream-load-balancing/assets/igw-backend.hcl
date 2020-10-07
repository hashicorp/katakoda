Kind = "ingress-gateway"
Name = "ingress-service"

Listeners = [
 {
   Port = 8080
   Protocol = "tcp"
   Services = [
     {
       Name = "backend"
     }
   ]
 }
]