
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'anistorage-bicep'
  location: 'southeast asia'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}
