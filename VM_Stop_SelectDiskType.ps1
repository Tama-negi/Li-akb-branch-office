#VM Stop Disk Type Select

param (
        [string] [Parameter(Mandatory=$true)]  $vmName
      )

$resourceGroupName ="RG Name"
$storageType ="StandardSSD_LRS"
#$vmName ="VM Name"

Stop-AzVM -ResourceGroupName $resourceGroupName -Name $vmName -Force

$VM = Get-AzVM -Name $vmName -resourceGroupName $resourceGroupName
$vmDisks = Get-AzDisk | Where { $_.ResourceGroupName -eq $resourceGroupName } | Where { $_.ManagedBy -eq $VM.id }

foreach ($disk in $vmDisks)
{
    if ($disk.ManagedBy -eq $vm.Id)
        {
        $diskUpdateConfig = New-AzDiskUpdateConfig –AccountType $storageType
        Update-AzDisk -DiskUpdate $diskUpdateConfig -ResourceGroupName $resourceGroupName `
        -DiskName $disk.Name

    }
}

