#AppServicePlan Template Deploy
#基本設定
#Name　AppServicePlan名
#location　リージョン名
#sku　プラン名(Basic,Standard,PremiumV2)、
#skucode　インスタンス名(B1等)
#kind　(linux or Win)(Winの場合はappと指定する)

$TemplateFilePath = "C:\Users\gsdadmin\Desktop\PowerShell\AppServicePlan_20200523.json"
$ImportCSVPath = "C:\Users\gsdadmin\Desktop\PowerShell\AppServicePlan作成_20200523.csv"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

# Template Deploy
foreach( $c in $csv ){

# Bool Value
[Bool]$boolValue = [System.Convert]::ToBoolean($c.reserved)

New-AzResourceGroupDeployment `
  -ResourceGroupName $c.ResourceGroupName `
  -TemplateFile $TemplateFilePath `
  -location $c.location `
  -AppServicePlanName $c.AppServicePlanName `
  -sku $c.sku `
  -skucode $c.skucode `
  -reserved $boolValue `
  -kind $c.kind
}