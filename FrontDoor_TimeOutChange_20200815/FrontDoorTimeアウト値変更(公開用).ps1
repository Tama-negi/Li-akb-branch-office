#FrontDoorのタイムアウト値を変更するPower Shell
$FrontDoorName = "FrontDoor名"

#設定前の値確認
$frontDoorConf = Get-AzFrontDoor -Name $FrontDoorName
$frontDoorConf.BackendPoolsSetting

#設定変更実施
$frontDoorConf.BackendPoolsSetting.SendRecvTimeoutInSeconds = 30
$frontDoorConf | Set-AzFrontDoor

#設定後の値確認
$frontDoorConfAfter = Get-AzFrontDoor -Name $FrontDoorName
$frontDoorConfAfter.BackendPoolsSetting
