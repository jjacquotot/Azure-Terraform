$domain = "cltdom.local"
$password = "Passw0rd1" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\administrateur" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential
Restart-Computer