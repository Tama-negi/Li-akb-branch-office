$resourceGroupName = "デプロイ先のリソースグループ名"
$TemplateFilePath = "テンプレートファイルのパス"
$ImportCSVPath = "CSVのファイルのパス"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

# Template Deploy
foreach( $c in $csv ){

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
  -TemplateFile $TemplateFilePath `
  -workspaceName $C.workspaceName `
  -location $c.location `
  -sku $c.sku
}