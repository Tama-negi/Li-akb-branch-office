#MariaDB Template Deploy
#基本設定
#serverName　DBサーバ名
#administratorLogin 管理者ユーザー名
#administratorLoginPassword 管理者ユーザーパスワード
#location リージョン名
#skuName SKU名(skuTier略称(B,GP,MO)+Gen5+vCore数)
#skuSizeMB ストレージサイズ
#skuTier 価格レベル(Basic,GeneralPurpose,MemoryOptimize))
#version MariaDBのバージョン(10.2,10.3))
#backupRetentionDays バックアップ保存日数(最低7日)
#geoRedundantBackup バックアップでGeo冗長を利用するか
#storageAutoGrow ストレージの自動拡張
#sslEnforcement MariaDBへアクセスする際にSSLを強制するか
#infrastructureEncryption DB暗号化

$TemplateFilePath = "ARMテンプレートファイルのパス"
$ImportCSVPath = "CSVファイルのパス"

# Inclued Configure Entries
$csv = Import-Csv -path $ImportCSVPath 

# Template Deploy
foreach( $c in $csv ){

$secureadminpass = ConvertTo-SecureString $c.administratorLoginPassword -AsPlainText -Force

New-AzResourceGroupDeployment `
  -ResourceGroupName $c.ResourceGroupName `
  -TemplateFile $TemplateFilePath `
  -serverName $c.serverName `
  -administratorLogin $c.administratorLogin `
  -administratorLoginPassword $secureadminpass `
  -location $c.location `
  -skuName $c.skuName `
  -skuSizeMB $c.skuSizeMB `
  -skuTier $c.skuTier `
  -version $c.version `
  -backupRetentionDays $c.backupRetentionDays `
  -geoRedundantBackup $c.geoRedundantBackup `
  -storageAutoGrow $c.storageAutoGrow `
  -sslEnforcement $c.sslEnforcement `
  -infrastructureEncryption $c.infrastructureEncryption `
}