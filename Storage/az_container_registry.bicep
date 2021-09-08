
resource myAZACRStorage 'Microsoft.Storage/storageAccounts@2019-04-01' = {
  name: 'acrdemostorage'
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



resource myAZContainerRegistry 'Microsoft.ContainerRegistry/registries@2019-05-01' = {
  name: 'myazacrdemo'
   location: 'southeast asia'
   sku: {
    name: 'Basic'
   }
   properties: {
     adminUserEnabled: true
     storageAccount: myAZACRStorage
     networkRuleSet: {
       defaultAction: 'Allow'
    }
  policies: {
    retentionPolicy: {
      days:7
    }
  }
  
   }

   dependsOn: [
     myAZACRStorage
   ]
   
}
