#Public IP Template Deploy

$TemplateFilePath = "テンプレートファイルのパス"
$ImportCSVPath = "CSVファイルのパス"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

# Template Deploy
foreach( $c in $csv ){

New-AzResourceGroupDeployment `
  -ResourceGroupName $c.ResourceGroupName `
  -TemplateFile $TemplateFilePath `
  -location $c.location `
  -publicIPAddresses_name $c.publicIPAddresses_name `
  -domainNameLabel $c.domainNameLabel `
  -publicIPAllocationMethod $c.publicIPAllocationMethod `
}