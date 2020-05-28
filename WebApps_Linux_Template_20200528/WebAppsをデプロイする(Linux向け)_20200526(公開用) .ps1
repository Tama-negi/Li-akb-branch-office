#Web Apps Template For Linux Deploy
#基本設定
#webAppName　Web Apps名
#AppServicePlanName　AppServicePlan名
#location　リージョン名
#sku　プラン名(Basic,Standard,PremiumV2)、
#skucode　インスタンス名(B1等)
#kind　(linux)
#linuxFxVersion(RuntimeStackVersion)(ランタイムスタック)
#newOrExisting(新規作成 Or 既存利用)

$TemplateFilePath = "ARMテンプレートのパス"
$ImportCSVPath = "CSVファイルのパス"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

# Template Deploy
foreach( $c in $csv ){

# Bool Value
[Bool]$boolValue = [System.Convert]::ToBoolean($c.reserved)

New-AzResourceGroupDeployment `
  -ResourceGroupName $c.ResourceGroupName `
  -TemplateFile $TemplateFilePath `
  -webAppName $c.webAppName `
  -AppServicePlanName $c.AppServicePlanName `
  -location $c.location `
  -sku $c.sku `
  -skucode $c.skucode `
  -reserved $boolValue `
  -kind $c.kind `
  -linuxFxVersion $c.RuntimeStackVersion `
  -newOrExisting $c.newOrExisting `
}