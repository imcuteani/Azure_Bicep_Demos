// Create Synapse Analytics workspace

resource myazSQLserv 'Microsoft.Sql/servers@2020-02-02-preview' = {
  name: 'azsqlservanidemo'
  location: 'southeast asia'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    administratorLogin: 'sqladminUser'
    administratorLoginPassword: 'BigData@09031986'
    publicNetworkAccess: 'Enabled'
    
}
tags: {
  name: 'SQLServer'
  resourceType: 'sqlserverdb'
}
}

resource myazsqldb 'Microsoft.Sql/servers/databases@2019-06-01-preview' = {
  name: 'myazsqldb/'
  location: 'southeast asia'
  properties: {
    licenseType: 'BasePrice'
    zoneRedundant: false
  }
  dependsOn: [
    myazSQLserv
  ]

}

resource mySynapseDataLakeStore 'Microsoft.DataLakeStore/accounts@2016-11-01' = {
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


resource mySynapse 'Microsoft.Synapse/workspaces@2021-05-01' = {
  name: 'mySynapsedemo'
  location: 'southeast asia'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    sqlAdministratorLogin: myazSQLserv.properties.administratorLogin
    sqlAdministratorLoginPassword:myazSQLserv.properties.administratorLoginPassword
    publicNetworkAccess:'Enabled'
    defaultDataLakeStorage: mySynapseDataLakeStore
   /* managedVirtualNetworkSettings: {
      preventDataExfiltration:true
    } */
  }
  dependsOn: [
    myazSQLserv
    mySynapseDataLakeStore
  ]
}
