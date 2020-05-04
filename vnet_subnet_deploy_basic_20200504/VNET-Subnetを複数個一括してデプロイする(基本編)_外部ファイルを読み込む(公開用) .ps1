#Vnet + Subnet Template Deploy
#基本設定（Vnet＋Subnet1つを作成、ServiceTag等は指定無し)

$TemplateFilePath = "テンプレートのファイルパス"
$ImportCSVPath = "CSVファイルのファイルパス"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

# Template Deploy
foreach( $c in $csv ){

New-AzResourceGroupDeployment `
  -ResourceGroupName $c.ResourceGroupName `
  -TemplateFile $TemplateFilePath `
  -location $c.location `
  -vnetName $c.vnetname `
  -addressSpaces $c.addressSpaces `
  -subnet_name $c.subnet_name `
  -subnet_addressRange $c.subnet_addressRange `
  -tag_name $c.tag_name `
  -tag_value $c.tag_value
}