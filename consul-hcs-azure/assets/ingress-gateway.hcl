Kind = "ingress-gateway"
Name = "ingress-gateway"

Listeners = [
 {
   Port = 8080
   Protocol = "tcp"
   Services = [
     {
       Name = "frontend"
     }
   ]
 }
]