#Create Availability sets

param (
    [String] [Parameter(Mandatory=$true)]  $avsetname
    )

    #作成する場所の情報
    $resourceGroupName = "RG名"
    $location ="ロケーション名"

    #障害ドメイン数(1-3)
    $FaultDomainCount ="2"
    #更新ドメイン数(1-20)
    $UpdateDomainCount ="2"

New-AzAvailabilitySet `
   -Location $location `
   -Name $avsetname `
   -ResourceGroupName $resourceGroupName `
   -Sku aligned `
   -PlatformFaultDomainCount $FaultDomainCount `
   -PlatformUpdateDomainCount $UpdateDomainCount