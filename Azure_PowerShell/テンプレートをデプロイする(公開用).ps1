$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$TemplateFilePath = "�e���v���[�g�t�@�C���̏ꏊ\ActionGroup_templete.json"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
  -TemplateFile $TemplateFilePath