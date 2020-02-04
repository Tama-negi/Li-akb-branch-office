# Blobストレージにファイルをuploadする
# 参考URL
# https://docs.microsoft.com/ja-jp/azure/storage/blobs/storage-quickstart-blobs-powershell#upload-blobs-to-the-container

# パラメータ
$resourceGroupName ="RG名"
$StorageAccountName ="ストレージアカウント名"
$containerName = "コンテナ名"
$LocalFilePath ="アップロードするファイルパス"

# 処理部分
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $StorageAccountName
$ctx = $storageAccount.Context

Set-AzStorageBlobContent -File $LocalFilePath `
  -Container $containerName `
  -Context $ctx