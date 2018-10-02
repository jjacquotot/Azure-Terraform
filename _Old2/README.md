# Note JJA : POC
git@git.bcstechno.net:jjacquotot/JJA-POC.git
touch README.md
git push -u origin master
git add fichier.txt : ajout un fichier au git
git commit (git commmit -a : commit tout les fichiers avec des modifications )
git push

https://portal.azure.com/bcstechno.onmicrosoft.com 
jjacquotot@bcstechno.onmicrosoft.com 
MDPJJAPERSO

PS C:\Users\jjacquotot> Login-AzAccount
Account          : jjacquotot@bcstechno.onmicrosoft.com
SubscriptionName : Microsoft Azure
SubscriptionId   : 5195a29e-84ca-474a-b2c0-c6f695ed3364
TenantId         : f9f50f22-a5b6-403c-bf97-451d1bb587e2
Environment      : AzureCloud

PS C:\Users\jjacquotot\Desktop\JJA-POC> az login
[
  {
    "cloudName": "AzureCloud",
    "id": "5195a29e-84ca-474a-b2c0-c6f695ed3364",
    "isDefault": true,
    "name": "Microsoft Azure",
    "state": "Enabled",
    "tenantId": "f9f50f22-a5b6-403c-bf97-451d1bb587e2",
    "user": {
      "name": "jjacquotot@bcstechno.onmicrosoft.com",
      "type": "user"
    }
  }
]

provider "azurerm" {}

Terraform init = check syntax
Terraform plan = Test exécution 
Terraform apply = Execute le script
Terraform destroy = Détruit ce que fait le script

Problème de parallelisme de job terraform
terraform apply -parallelism=2

Déploy module without destroy 
terraform apply -target module.[nom module] (ressource.nom)