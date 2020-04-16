param (
    [String] [Parameter(Mandatory=$true)]  $VMname
    )

$subscriptionID ="サブスクリプションID"
$resourceGroupName = "リソースグループ名"

$startTime = (Get-Date).AddMinutes(-3) | Get-Date  -Format 'yyyy-MM-dd THH:mm'
$endTime = Get-Date -Format "yyyy-MM-dd THH:mm"

(Get-AzMetric `
    -ResourceId "/subscriptions/$subscriptionID/resourceGroups/$resourceGroupName/providers/Microsoft.Compute/virtualMachines/$VMname" `
    -TimeGrain 00:01:00 `
    -AggregationType "Average" `
    -StartTime $startTime `
    -EndTime $endTime `
    -MetricName "CPU Credits Remaining" `
    -DetailedOutput).Data `
| Select-Object TimeStamp,Average