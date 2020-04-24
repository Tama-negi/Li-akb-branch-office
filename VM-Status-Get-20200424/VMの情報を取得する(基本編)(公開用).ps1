#VMの情報を取得するPowerShell（基本編）
#VM名を指定して、IF名、IP、DISK名、サイズ、SKU等を取得

#パラメータ指定
param (
    [String] [Parameter(Mandatory=$true)] $VMName
    )

# VM Status 取得

$vm = Get-AzVM -name $VMName

# サブスクリプションID指定

$SubscriptionId ="サブスクリプションID"
Select-AzSubscription -SubscriptionId $SubscriptionId 

# VMの各情報を取得

Get-AzVm -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Status `
| select-Object Name,@{n="Status"; e={$_.Statuses[1].Code}},@{n="VMSize"; e={$vm.HardwareProfile.VmSize}}
& `
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName`
| Where { $_.ManagedBy -contains $VM.id }`
| Select-Object @{n="DiskNmae"; e={$_.Name}},DiskSizeGB,@{n="Tier"; e={$_.sku.Name}}
& `
Get-AzNetworkInterface `
| Where { $_.VirtualMachine.id -contains $VM.id}`
| Select-Object @{n="NWInterFaceNmae"; e={$_.Name}},`
@{n="PrivateIP"; e={$_.IpConfigurations.PrivateIpAddress}},`
@{n="PrivateIpAllocation"; e={$_.IpConfigurations.PrivateIpAllocationMethod}}