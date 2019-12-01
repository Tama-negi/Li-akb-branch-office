#VM Start (Time TimeSpecification)(Runbook)
$resourceGroupName ="RG Name"
$vmName ="VM Name"


# Authentication (Comment out for Runbook） 
#$Conn = Get-AutomationConnection -Name AzureRunAsConnection
#Connect-AzureRmAccount -ServicePrincipal -Tenant $Conn.TenantID `
#-ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

#Time(JST)
$JST = (Get-Date).AddHours(9)

        if(($JST.Hour -lt 9) -or ($JST.Hour -gt 18)){
         Write-Output(“Proceed”)

# 実行する処理
        Restart-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmName

    }
    else
    {
        Write-Output(“Don’t proceed”)
    }


Start-AzVM -ResourceGroupName $resourceGroupName -Name $vmName