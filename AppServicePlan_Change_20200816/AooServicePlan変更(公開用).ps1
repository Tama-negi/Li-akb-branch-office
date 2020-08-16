#App Service Plan変更するPower Shell

#設定変更対象のAppServicePlan
$ResourceGroupName = "リソースグループ名"
$AppServicePlanName = "App Service Plan名"

#AppServicePlan変更後の設定値
$Name = "F1"
$Tier = "Free"
$Size = $Name
$Family = "F"
$Capacity = 1

#現在のAppServicePlanの情報取得
$AppservicePlanConf = Get-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName

#現在の情報表示
Write-Host "変更前の設定情報: $($AppServicePlanName)"
$AppservicePlanConf
$AppservicePlanConf.Sku

#設定変更する
$AppservicePlanConf.Sku.Name = $Name
$AppservicePlanConf.Sku.Tier = $Tier
$AppservicePlanConf.Sku.Size = $Size
$AppservicePlanConf.Sku.Family = $Family
$AppservicePlanConf.Sku.Capacity = $Capacity

$AppservicePlanConf | Set-AzAppServicePlan

#設定変更後AppServicePlanの情報取得
$AppservicePlanConfAfter = Get-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName

#設定変更後の情報表示
Write-Host "変更後の設定情報: $($AppServicePlanName)"
$AppservicePlanConfAfter
$AppservicePlanConfAfter.Sku

