#Resource Group Deploy
#RGを複数個纏めて作成します。設定値はCSVファイルを読み込みます。

#初期設定値
$ImportCSVPath = "CSVファイルのパス"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

#Deploy Command
foreach( $c in $csv ){

New-AzResourceGroup `
  -Name $c.resourceGroupName `
  -Location $c.location
}