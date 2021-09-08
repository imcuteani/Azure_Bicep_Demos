// Create the Azure Synapse Analytics workspace with Bicep

resource myAzureSQLServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: 'azsqlservanidemo'
  location: 'southeast asia'
  identity:{
    type: 'SystemAssigned'
  }
  properties: {
    administratorLogin: 'adminuser'
    administratorLoginPassword: 'BigData@09031986'
    publicNetworkAccess: 'Enabled'
  }
}

resource myAzureSQLdb 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
  name: 'azsqldbani/'
  location: 'southeast asia'
   dependsOn: [
    myAzureSQLServer
   ]
  }



resource mySynapse 'Microsoft.Synapse/workspaces@2021-05-01' ={
  name: 'ani-synapsedemo'
  location: 'southeast asia'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    publicNetworkAccess:'Enabled'
    sqlAdministratorLogin: myAzureSQLServer.properties.administratorLogin
    sqlAdministratorLoginPassword:myAzureSQLServer.properties.administratorLoginPassword
  }
  dependsOn: [
    myAzureSQLdb
  ]
  
}
