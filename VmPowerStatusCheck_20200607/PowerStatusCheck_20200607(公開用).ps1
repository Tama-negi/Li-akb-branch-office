#VM 割り当て解除忘れ漏れ対策 PowerShell

#RGを指定する場合（RGを指定しない場合は下記3行をコメントアウトします。)
param (
        [string] [Parameter(Mandatory=$true)]  $resourceGroupName
      )

#確認のみの場合は0を選択する
$vmstoporcheck=1

#VM の状態を取得
    $vmstat = (Get-AzVM -Status `
    | Select-Object ResourceGroupName,Name,PowerState `
    | Where-Object { $_.PowerState -eq "VM Stopped" } )

#RGを指定する場合
    foreach ($vmstatus in $vmstat | Where-Object {$_.ResourceGroupName -eq $resourceGroupName })

#RGを指定しない場合
#   foreach ($vmstatus in $vmstat)

{
    if($vmstoporcheck -eq 1){
  
        Write-Host "Stop VM Name: $($vmstatus.Name)"
        Stop-AzVM -ResourceGroupName $vmstatus.resourceGroupName -Name $vmstatus.Name -Force
    
    }else{

        Write-Host "Stop VM Name: $($vmstatus.Name)"

    }
}