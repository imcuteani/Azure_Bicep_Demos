
resource myAZStorage 'Microsoft.Storage/storageAccounts@2019-04-01' = {
  name: 'acrdemoanistorage'
  location: 'southeast asia'
  sku: {
    name: 'Standard_LRS'
    
  }
  properties: {
    allowBlobPublicAccess: true
    accessTier: 'Hot'
    supportsHttpsTrafficOnly:true
    
  }
  kind: 'StorageV2'
}

output storageId string = myAZStorage.id
