#仮想マシンを関連リソースと一緒に削除するPower Shell

$param (
    [String] [Parameter(Mandatory=$true)] $resourceGroupName,
    [String] [Parameter(Mandatory=$true)] $VMName
    )

$vms = Get-AzVM -ResourceGroupName $resourceGroupName -Name $VMName
$report = @()
$publicIps = Get-AzPublicIpAddress 

Foreach ($vm in $vms){
$info = "" | Select VmName, ResourceGroupName, PublicIPName, NicName, DiskName 

$nics = Get-AzNetworkInterface | Where { $_.VirtualMachine.id -contains $vm.id} 
$disks = Get-AzDisk -ResourceGroupName $vm.ResourceGroupName | Where { $_.ManagedBy -contains $vm.id }

    foreach($publicIp in $publicIps) { 
        if($nics.IpConfigurations.id -eq $publicIp.ipconfiguration.Id) {
            $info.PublicIPName = $publicIp.Name
            } 
        }    
              
        $info.VMName = $vm.Name 
        $info.ResourceGroupName = $vm.ResourceGroupName 
        $info.NicName = $nics.Name 
        $info.DiskName = $disks.Name 
        $report+=$info 
    } 

Write-Host ""
Write-Host "削除対象はこちらのアイテムになります。"
$report | ft VmName, ResourceGroupName, PublicIPName, NicName, DiskName

#VMを削除します。
Write-Host "VMを削除します：$($VMName)"

Remove-AzVM -ResourceGroupName $resourceGroupName -Name $VMName

#関連アイテムの削除確認
$deletecheck = 1

#Nicを削除します。
foreach ($DeleteNic in $nics) {
    if($deletecheck -eq 1){
        Write-Host "Deleting NicName: $($DeleteNic.Name)"
        $DeleteNic | Remove-AzNetworkInterface 
    }else{
        Write-Host "Deleting NicName: $($DeleteNic.Name)"
    } 
} 

#Diskを削除します。
foreach ($DeleteDisk in $disks) {
    if($deletecheck -eq 1){
        Write-Host "Deleting DiskName: $($DeleteDisk.Name)"
        $DeleteDisk | Remove-AzDisk
    }else{
        Write-Host "Deleting DiskName: $($DeleteDisk.Name)"
    } 
} 

#PublicIPを削除します。
foreach ($DeletePublicIP in $publicIp) {
    if($deletecheck -eq 1){
        Write-Host "Deleting PublicIPName: $($DeletePublicIP.Name)"
        $DeletePublicIP | Remove-AzPublicIpAddress 
    }else{
        Write-Host "Deleting PublicIPName: $($DeletePublicIP.Name)"
    } 
} 
