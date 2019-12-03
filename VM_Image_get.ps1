#Image List get

$location="japaneast"

#pubName Get
#Get-AzVMImagePublisher -Location $location

$pubName="MicrosoftSQLServer"

#offer Name Get
#Get-AzVMImageOffer -Location $location -Publisher $pubName

$offerName="SQL2008R2SP3-WS2008R2SP1"
Get-AzVMImageSku -Location $location -Publisher $pubName -Offer $offerName