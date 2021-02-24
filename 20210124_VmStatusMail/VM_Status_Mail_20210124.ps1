#VM Status
Param(
    [parameter(Mandatory=$True)]
    [string]$vmName,
    [parameter(Mandatory=$True)]
    [string]$resourceGroupName,
    [parameter(Mandatory=$True)]
    [string]$FromMailAddress,
    [parameter(Mandatory=$True)]
    [string]$ToMailAddress
)


$Conn = Get-AutomationConnection -Name AzureRunAsConnection
    Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID `
    -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

$VMStatus = Get-AzVM -Name $vmName -resourceGroupName $resourceGroupName -Status| `
      select-Object Name,@{n="Status"; e={$_.Statuses[1].Code}}| `
      ConvertTo-HTML
   
# SendGrid の資格情報を取得
$SmtpCredential = Get-AutomationPSCredential -Name "Automationアカウント資格情報名"

    function EncodeSubject($s) {
        $enc = [Text.Encoding]::GetEncoding("csISO2022JP")
        $s64 = [Convert]::ToBase64String($enc.GetBytes($s), [Base64FormattingOptions]::None)
        return [String]::Format("=?{0}?B?{1}?=", $enc.HeaderName, $s64)  
    }

    $Subject = EncodeSubject(EncodeSubject("$vmName のステータス"))

    Send-MailMessage `
        -To "$ToMailAddress"  `
        -Subject $Subject  `
        -Body "$VMStatus" `
        -UseSsl `
        -Port 587 `
        -SmtpServer 'smtp.sendgrid.net' `
        -BodyAsHtml `
        -From $FromMailAddress `
        -Encoding ([System.Text.Encoding]::UTF8) `
        -Credential $SmtpCredential
