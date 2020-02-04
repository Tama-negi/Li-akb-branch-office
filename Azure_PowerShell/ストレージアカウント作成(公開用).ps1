param (
    [String] [Parameter(Mandatory=$true)]  $storageAccount
    )

#複数サブスクリプション利用時
#環境1
#$SubscriptionId ="環境1のサブスクリプションID"
#環境2
#$SubscriptionId ="環境2のサブスクリプションID"
#Select-AzSubscription -SubscriptionId $SubscriptionId    

#V1を利用の場合は、Kind、AccessTierの部分を修正してください。
$resourceGroupName = "リソースグループ名"
$location ="ロケーション名"
$SkuName ="データ冗長性(例;Standard_LRS)"
$Kind ="StorageV2"
$AccessTier ="Access tier(cool等)"

New-AzStorageAccount `
  -ResourceGroupName $resourceGroupName `
  -Name $storageAccount `
  -SkuName $SkuName `
  -Location $location `
  -Kind $Kind `
  -AccessTier $AccessTier