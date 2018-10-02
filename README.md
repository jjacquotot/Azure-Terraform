# Azure-Terraform
Terraform init = check syntax
Terraform plan = Test exécution 
Terraform apply = Execute le script
Terraform destroy = Détruit ce que fait le script

Problème de parallelisme de job terraform
terraform apply -parallelism=2

Déploy module without destroy 
terraform apply -target module.[nom module] (ressource.nom)