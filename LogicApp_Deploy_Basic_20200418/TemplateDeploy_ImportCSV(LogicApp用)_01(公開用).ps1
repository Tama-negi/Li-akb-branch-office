#Logic App Template Deploy
#基本設定（RG名、LogicApp名、Location、Tagのみ指定）

param (
    [String] [Parameter(Mandatory=$true)]  $ResourceGroupName
    )

$TemplateFilePath = "テンプレートファイルのパス名"
$ImportCSVPath = "CSVファイルのパス名"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

# Template Deploy
foreach( $c in $csv ){

New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName `
  -TemplateFile $TemplateFilePath `
  -workflows_LogicApp_name $c.LogicAppName `
  -location $c.location `
  -tag $c.tag
}