#Front Door Cash clear Power Shell

param (
    [String] [Parameter(Mandatory=$true)]  $ResourceGroupName ,
    [String] [Parameter(Mandatory=$true)]  $FrontDoorName ,
    [String] [Parameter(Mandatory=$true)]  $ContentPath
    )

Remove-AzFrontDoorContent -ResourceGroupName $ResourceGroupName -Name $FrontDoorName -ContentPath $ContentPath