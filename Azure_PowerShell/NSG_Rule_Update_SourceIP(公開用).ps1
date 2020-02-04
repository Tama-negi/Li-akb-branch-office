#NSG Rule Update(SourceAddressPrefix)

param (
    [String[]] [Parameter(Mandatory=$true)]  $Address
    )

$resourceGroupName = "RG名"
$NSGName ="NSG名Z"
$NSGRuleName = "ルール名"

# Get the NSG resource
$nsg = Get-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $resourceGroupName

# New Prefix List 
$newPrefix = New-Object 'System.Collections.Generic.List[string]'

# Existing Prefix Add
($nsg.SecurityRules | where {$_.Name -eq $NSGRuleName}).SourceAddressPrefix | foreach { $newPrefix.Add($_) }

# New Prefix Add
$Address | foreach { $newPrefix.Add($_) }
#$newPrefix.Add($Address)

# New Prefix Rewrite
($nsg.SecurityRules | where {$_.Name -eq $NSGRuleName}).SourceAddressPrefix = $newPrefix

# Reflect changes
$nsg | Set-AzNetworkSecurityGroup
