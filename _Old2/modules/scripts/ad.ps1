# Rename & restart

Rename-Computer -NewName CLT-AD1 -Force
Restart-Computer

# Enforce LAN configuration
New-NetIPAddress -IPAddress "10.0.1.5" -PrefixLength "24" -InterfaceIndex (Get-NetAdapter).ifIndex -DefaultGateway "10.0.1.1"

# Enforce DNS configuration
Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).ifIndex -ServerAddresses ("127.0.0.1")

# Enforce NIC name
Rename-NetAdapter -Name EthernetAD1 -NewName LAN

# Install services : Active Directory (AD-Domain-Services), DNS (DNS) et les outils d'administration graphique (RSAT-AD-Tools) mais ceci est facultatif.
$FeatureList = @("RSAT-AD-Tools","AD-Domain-Services","DNS")

Foreach($Feature in $FeatureList){

   if(((Get-WindowsFeature-Name $Feature).InstallState)-eq"Available"){

     Write-Output"Feature $Feature will be installed now !"

     Try{

        Add-WindowsFeature-Name $Feature-IncludeManagementTools -IncludeAllSubFeature

        Write-Output"$Feature : Installation is a success !"

     }Catch{

        Write-Output"$Feature : Error during installation !"
     }
   } # if(((Get-WindowsFeature -Name $Feature).InstallState) -eq "Available")
} # Foreach($Feature in $FeatureList)

# COnfig domaine
$DomainNameDNS = "cltdom.local"
$DomainNameNetbios = "CLTDOM"

$ForestConfiguration = @{
'-DatabasePath'= 'C:\Windows\NTDS';
'-DomainMode' = 'Default';
'-DomainName' = $DomainNameDNS;
'-DomainNetbiosName' = $DomainNameNetbios;
'-ForestMode' = 'Default';
'-InstallDns' = $true;
'-LogPath' = 'C:\Windows\NTDS';
'-NoRebootOnCompletion' = $false;
'-SysvolPath' = 'C:\Windows\SYSVOL';
'-Force' = $true;
'-CreateDnsDelegation' = $false }

Import-Module ADDSDeployment
Install-ADDSForest @ForestConfiguration

Restart-Computer
