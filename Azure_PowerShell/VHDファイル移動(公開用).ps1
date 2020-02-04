##Managed Disk Copy PowerShell
#参考URL
# https://docs.microsoft.com/ja-jp/archive/blogs/jpaztech/export-managed-disks-to-vhd

# コピー元へのログイン
Login-AzAccount
Select-AzSubscription -SubscriptionId  “コピー元のサブスクリプション ID”

# コピー元のディスクパラメータ
$sourcergname = “コピー元リソースグループ名”
$diskname = “コピー対象のManagedDisk名”

# SAS URL の作成
$mdiskURL = Grant-AzDiskAccess -ResourceGroupName $sourcergname -DiskName $diskname -Access Read -DurationInSecond 3600

# コピー先の情報
# コピー先テナントにログイン

Login-AzAccount
Select-AzSubscription -SubscriptionId  “コピー先のサブスクリプション ID”

# コピー先の各種パラメーター
$targetrgname = “コピー先リソースグループ名”
$storageacccountname = “コピー先ストレージアカウント名”
$countainername = “コピー先コンテナ名”

$storageacccountkey = Get-AzStorageAccountKey -ResourceGroupName $targetrgname -Name $storageacccountname
$storagectx = New-AzStorageContext -StorageAccountName $storageacccountname -StorageAccountKey $storageacccountkey[0].Value
$targetcontainer = Get-AzStorageContainer -Name $countainername -Context $storagectx

$destdiskname = “コピー後のファイル名”
$sourceSASurl = $mdiskURL.AccessSAS
 
# コピー
$ops = Start-AzStorageBlobCopy -AbsoluteUri $sourceSASurl -DestBlob $destdiskname -DestContainer $targetcontainer.Name -DestContext $storagectx
Get-AzStorageBlobCopyState -Container $targetcontainer.Name -Blob $destdiskname -Context $storagectx -WaitForComplete