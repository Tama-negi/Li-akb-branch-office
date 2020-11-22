#AzureパブリックIpの逆引き設定を削除するPower Shell

#逆引き設定削除対象
$ResourceGroupName = "リソースグループ名"
$PublicIpName = "パブリックIP名"

#逆引き設定を削除する
$pip = Get-AzPublicIpAddress -Name $PublicIpName -ResourceGroupName $ResourceGroupName
$pip.DnsSettings.ReverseFqdn = ""
Set-AzPublicIpAddress -PublicIpAddress $pip

#設定結果を表示する
Get-AzPublicIpAddress -Name $PublicIpName -ResourceGroupName $ResourceGroupName