$SubscriptionId = "サブスクリプションID"
$resourceGropuName = "リソースグループ名"
$APGWName = "APGW名"
$TemplatePath ="テンプレートのパス（例：C:\temp）"

#Getコマンドで情報取得
Get-AzApplicationGateway -Name $APGWName -ResourceGroupName $resourceGropuName

#テンプレートをエクスポートする
Export-AzResourceGroup `
-ResourceGroupName $resourceGropuName `
-Resource "/subscriptions/$SubscriptionId/resourceGroups/$resourceGropuName/providers/Microsoft.Network/applicationGateways/$APGWName"`
-Path $TemplatePath