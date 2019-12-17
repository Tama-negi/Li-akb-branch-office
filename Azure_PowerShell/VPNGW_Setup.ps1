#VPN GW Create PowerShell

#RG Name Location
$resourceGroupName = "Resouece Gropu Name"
$location = "Location(ex;eastjapan)"

#VNET Subnet
$VnetName = "Virtual Network Name"
$SubAddress ="XXX.XXX.XXX.XXX/XX"

#Public IP
$PubIPName = "Public Ip Name"

#VPN GW
$GwName = "VPN GW Name"
$gatewayType = "GW Type(ex;Vpn)"
$VpnType = "RouteBased"
$GatewaySKU = "Basic"

#PubIP Create

$Pubip    = New-AzPublicIpAddress `
-Name $PubIPName `
-ResourceGroupName $resourceGroupName `
-Location $location `
-AllocationMethod Dynamic

#Subnet Create
$virtualNetwork = get-AzVirtualNetwork `
-Name $VnetName `
-ResourceGroupName $resourceGroupName

Add-AzVirtualNetworkSubnetConfig `
-Name 'GatewaySubnet' `
-AddressPrefix $SubAddress `
-VirtualNetwork $virtualNetwork `

$virtualNetwork | Set-AzVirtualNetwork

$subnet   = Get-AzVirtualNetworkSubnetConfig `
-Name 'GatewaySubnet' `
-VirtualNetwork $virtualNetwork `

#GW Create

$gwipconf = New-AzVirtualNetworkGatewayIpConfig `
-Name $GwName `
-Subnet $subnet `
-PublicIpAddress $Pubip

New-AzVirtualNetworkGateway `
-Name $GwName `
-ResourceGroupName $resourceGroupName `
-Location $location `
-IpConfigurations $gwipconf `
-GatewayType $gatewayType `
-VpnType $VpnType `
-GatewaySku $GatewaySKU
