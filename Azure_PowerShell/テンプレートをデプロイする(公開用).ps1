$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$TemplateFilePath = "テンプレートファイルの場所\ActionGroup_templete.json"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
  -TemplateFile $TemplateFilePath