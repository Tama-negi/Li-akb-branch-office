#NSG Template Deploy

param (
  [String] [Parameter(Mandatory=$true)]  $NSGName ,
  [String] [Parameter(Mandatory=$true)]  $Address
    )

$resourceGroupName = "リソースグループ名"
$location = "ロケーション名"
$NSGRuleName ="セキュリティ規則名"
$TemplateFilePath = "テンプレートのパス"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
  -TemplateFile $TemplateFilePath `
  -NSGName $NSGName `
  -NSGRuleName $NSGRuleName `
  -PermitIP $Address `
  -location $location