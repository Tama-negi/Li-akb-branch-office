#AzureパブリックIpの逆引き設定するPower Shell

#逆引き設定対象
$ResourceGroupName = "リソースグループ名"
$PublicIpName = "パブリックIP名"

#逆引き設定するFQDN名
$FQDNName = "FQDN名(必ず最後に.(ピリオド)付けます)"

#逆引き設定を行う
$pip = Get-AzPublicIpAddress -Name $PublicIpName -ResourceGroupName $ResourceGroupName
$pip.DnsSettings.ReverseFqdn = $FQDNName
Set-AzPublicIpAddress -PublicIpAddress $pip

#設定結果を表示する
Get-AzPublicIpAddress -Name $PublicIpName -ResourceGroupName $ResourceGroupName