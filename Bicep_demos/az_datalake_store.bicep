// Create Azure Data Lake Store account 

resource myDataLakeStore 'Microsoft.DataLakeStore/accounts@2016-11-01' = {
  name: 'azdatalakeanidemo'
  location: 'southeast asia'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    firewallAllowAzureIps:'Disabled'
    encryptionState:'Enabled'
    firewallState:'Disabled'
  }
}
