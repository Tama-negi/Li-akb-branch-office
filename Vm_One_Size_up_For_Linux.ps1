#Vm one size Up Linux

#RG Name、VM Name
$resourceGroupName = "RG Name"
$VmName = "Vm Name"

# VM Setting
$VmCfg = get-azvm -ResourceGroupName $resourceGroupName -Name $VmName

# Now VM Size
$VmSize = ( $VmCfg.hardwareprofile | grep Standard |awk '{print $1}')

Write-Host 'VmSize is '  $VmSize  ' '

# New VM Size
$New_VmSize  = ""
$New_VmSize = ( `
Get-AzVMSize -ResourceGroupName $resourceGroupName -VMName $VmName `
| Sort-Object -property NumberOfCores,MemoryInMB,ResourceDiskSizeInMB `
| grep $VmSize.Substring(0,10) `
| grep -A 1 $VmSize.Substring(0,$VmSize.Length) `
| awk 'NR== 2 {print $1}' )

# New Vm Update Ok
if($New_VmSize -eq $null) {
    Write-Host 'No Vm Size'
}else{
    Write-Host 'New VM Size Is '  $New_VmSize  ' '

$vmCfg.HardwareProfile.VmSize = $New_VmSize
Update-AzVM -VM $vmCfg -ResourceGroupName $resourceGroupName

}
