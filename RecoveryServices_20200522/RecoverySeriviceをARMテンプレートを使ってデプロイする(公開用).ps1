#RecoveryServicesコンテナー Template Deploy

$TemplateFilePath = "ARMテンプレートファイルのパス"
$ImportCSVPath = "パラメータを指定するCSVファイルのパス"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

# Template Deploy
foreach( $c in $csv ){

# Bool Value
[Bool]$boolValue = [System.Convert]::ToBoolean($c.changeStorageType)

# Deploy Command
New-AzResourceGroupDeployment `
  -ResourceGroupName $c.ResourceGroupName `
  -TemplateFile $TemplateFilePath `
  -location $c.location `
  -changeStorageType $boolValue `
  -vaultStorageType $c.vaultStorageType `
  -vaultName $c.vaultName
}