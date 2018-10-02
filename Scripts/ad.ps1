Add-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature
Add-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature
Add-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature

$CreateDnsDelegation = $false
$DomainName = "cltdom.local"
$NetbiosName = "CLTDOM"
$NTDSPath = "C:\Windows\NTDS"
$LogPath = "C:\Windows\NTDS"
$SysvolPath = "C:\Windows\SYSVOL"
$DomainMode = 'Default'
$InstallDNS = $true
$ForestMode = "Default"
$NoRebootOnCompletion = $false
$SafeModeClearPassword = "P@$$w0rd"
$SafeModeAdministratorPassword = ConvertTo-SecureString $SafeModeClearPassword -AsPlaintext -Force

$forest = Install-ADDSForest -CreateDnsDelegation:$CreateDnsDelegation `
-DomainName $DomainName `
-DatabasePath $NTDSPath `
-DomainMode $DomainMode `
-DomainNetbiosName $NetbiosName `
-ForestMode $ForestMode `
-InstallDNS:$InstallDNS `
-LogPath $LogPath `
-NoRebootOnCompletion:$NoRebootOnCompletion `
-SysvolPath $SysvolPath `
-SafeModeAdministratorPassword $SafeModeAdministratorPassword `
-Force:$true