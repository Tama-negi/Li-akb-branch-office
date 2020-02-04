# APGW Custom error Page Update
# 参考URL
# https://docs.microsoft.com/ja-jp/powershell/module/az.network/set-azapplicationgatewayhttplistenercustomerror?view=azps-3.3.0&viewFallbackFrom=azps-2.4.0

#パラメータ
$resourceGroupName = "Application GatewayのRG名"
$APGWName ="Application Gateway名"
$ListenerName = "リスナー名"
$StatusCode ="更新対象のエラーコード（ex;HttpStatus403)"
$customError403Url = "ErrorページのURL(ex;https://Blobストレージ名.blob.core.windows.net/コンテナ名/ファイル名)"

#処理部分
$AppGw = Get-AzApplicationGateway -Name $APGWName -ResourceGroupName $resourceGroupName
$httplistner = Get-AzApplicationGatewayHttpListener -Name $ListenerName -ApplicationGateway $Appgw
$updatelistener = Set-AzApplicationGatewayHttpListenerCustomError -HttpListener $httplistner -StatusCode $StatusCode -CustomErrorPageUrl $customError403Url
Set-AzApplicationGateway -ApplicationGateway $AppGw