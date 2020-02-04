# VHD→ManagedDisk PowerShell

#Select Subscription
$SubscriptionId =“コピー先のサブスクリプションID”
Select-AzSubscription -SubscriptionId $SubscriptionId

#Parameter
$ResourceGroupName = “ManagedDiskのRG名”
$location = “ManagedDiskのロケーション”
$DiskName = “作成するManagedDisk名”
$vhdUri = “コピーしたファイルのURL”
$AccountType =“ストレージアカウントのType (ex; Standard_LRS)”<
$OsType = ”ManagedDiskのOS Type (ex; Linux)”

#Disk Config
$DiskConfig = New-AzDiskConfig `
-AccountType $AccountType `
-Location $Location `
-CreateOption Import `
-SourceUri $vhdUri `
-OsType $OsType

#VHD → Managed Disk
New-AzDisk `
-DiskName $DiskName `
-Disk $DiskConfig `
-ResourceGroupName $ResourceGroupName