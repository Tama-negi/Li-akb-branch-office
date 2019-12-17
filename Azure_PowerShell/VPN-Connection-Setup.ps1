#接続を作成する側の情報
$resourceGroupName1 = "接続元RG名"
$location1 = "接続元ロケーション(ex;japaneast)"
$GwName1 = "接続先VPN GW 名"
$ConnectionName = "接続名"
$SharedKey = "共有キー (PSK)"

#接続先の情報
$GwName2 = "接続先VPN GW Name"
$GwId2 = "/subscriptions/････/接続先VPN GW 名"

#接続先の情報を作成する
$vnet2gw = New-Object -TypeName Microsoft.Azure.Commands.Network.Models.PSVirtualNetworkGateway
$vnet2gw.Name = $GwName2
$vnet2gw.Id = $GwId2

#接続を作成する
$vnet1gw = Get-AzVirtualNetworkGateway -Name $GWName1 -ResourceGroupName $resourceGroupName1
New-AzVirtualNetworkGatewayConnection `
-Name $ConnectionName `
-ResourceGroupName $resourceGroupName1 `
-VirtualNetworkGateway1 $vnet1gw `
-VirtualNetworkGateway2 $vnet2gw `
-Location $location1 `
-ConnectionType Vnet2Vnet `
-SharedKey $SharedKey