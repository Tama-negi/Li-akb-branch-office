#Subnet Template Deploy
#SubnteをパラメータをCSVファイルから読み込んでデプロイする

$TemplateFilePath = "テンプレートファイルのパス"
$ImportCSVPath = "CSVファイルのパス"

# Inclued Configure Entries

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

# Template Deploy
foreach( $c in $csv ){

New-AzResourceGroupDeployment `
  -ResourceGroupName $c.ResourceGroupName `
  -TemplateFile $TemplateFilePath `
  -location $c.location `
  -vnetName $c.vnetName `
  -subnet_name $c.subnet_name `
  -subnet_addressRange $c.subnet_addressRange `
  -NSG_Name $c.NSG_name `
}