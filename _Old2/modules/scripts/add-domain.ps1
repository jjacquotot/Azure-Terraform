$cred = New-Object System.Management.Automation.PsCredential("CLTDOM\administrateur", (ConvertTo-SecureString "Passw0rd1" -AsPlainText -Force))
Add-Computer -DomainName "cltdom.local" -Credential $cred #-OUPath "OU=computers,OU=yourlocation,DC=your,DC=domain,DC=here" (Specify OU)
Restart-Computer