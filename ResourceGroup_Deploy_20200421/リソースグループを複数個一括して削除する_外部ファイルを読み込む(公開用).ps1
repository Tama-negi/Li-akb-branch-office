#Resource Group Deploy

#初期設定値
$ImportCSVPath = "CSVファイルのパス名"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

#Deploy Command
foreach( $c in $csv ){

Remove-AzResourceGroup `
  -Name $c.resourceGroupName `
　-Force
}