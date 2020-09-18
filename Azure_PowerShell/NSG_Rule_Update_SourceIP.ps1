#NSG Rule Update(SourceAddressPrefix)

param (
    [string] [Parameter(Mandatory=$true)]  $NSGName,
    [string] [Parameter(Mandatory=$true)]  $NSGRuleName,
    [string] [Parameter(Mandatory=$true)]  $Address
    )

$resourceGroupName = "RGName"

# Get the NSG resource
$nsg = Get-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $resourceGroupName

# New Prefix List 
$newPrefix = New-Object 'System.Collections.Generic.List[string]'

# Existing Prefix Add
($nsg.SecurityRules | where {$_.Name -eq $NSGRuleName}).SourceAddressPrefix | foreach { $newPrefix.Add($_) }

# New Prefix Add
$newPrefix.Add($Address)

# New Prefix Rewrite
($nsg.SecurityRules | where {$_.Name -eq $NSGRuleName}).SourceAddressPrefix = $newPrefix

# Reflect changes
$nsg | Set-AzNetworkSecurityGroup
