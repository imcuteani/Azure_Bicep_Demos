@description('Name of the EventHub namespace')
param namespaceName string

@description('Name of the Event Hub')
param eventHubName string

@description('Name of the Consumer Group')
param consumerGroupName string

@description('The administrator username of the SQL Server.')
param sqlAdministratorLogin string

@description('The administrator password of the SQL Server.')
@secure()
param sqlAdministratorLoginPassword string

@description('Enable or disable Transparent Data Encryption (TDE) for the database.')
@allowed([
  'Enabled'
  'Disabled'
])
param transparentDataEncryption string = 'Enabled'

@description('Stream Analytics Job Name, can contain alphanumeric characters and hypen and must be 3-63 characters long')
@minLength(3)
@maxLength(63)
param streamAnalyticsJobName string

@description('Stream Analytics Job Name, can contain alphanumeric characters and hypen and must be 3-63 characters long')
@minLength(3)
@maxLength(63)
param streamAnalyticsJobName2 string

@description('Number of Streaming Units')
@minValue(1)
@maxValue(48)
@allowed([
  1
  3
  6
  12
  18
  24
  30
  36
  42
  48
])
param numberOfStreamingUnits int

var location = resourceGroup().location
var apiVersion = '2015-08-01'
var defaultSASKeyName = 'RootManageSharedAccessKey'
var authRuleResourceId = resourceId('Microsoft.EventHub/namespaces/authorizationRules', namespaceName, defaultSASKeyName)
var sqlServerName_var = 'sqlserver${uniqueString(subscription().id, resourceGroup().id)}'
var databaseName = 'swiftdbprod'
var databasedwName = 'swiftdwprod'
var databaseEdition = 'Basic'
var databasedwEdition = 'DataWarehouse'
var databaseCollation = 'SQL_Latin1_General_CP1_CI_AS'
var databaseServiceObjectiveName = 'Basic'

resource namespaceName_resource 'Microsoft.EventHub/Namespaces@2015-08-01' = {
  name: namespaceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

resource namespaceName_eventHubName 'Microsoft.EventHub/Namespaces/EventHubs@2015-08-01' = {
  parent: namespaceName_resource
  name: '${eventHubName}'
  properties: {
    path: eventHubName
  }
}

resource namespaceName_eventHubName_consumerGroupName 'Microsoft.EventHub/Namespaces/EventHubs/ConsumerGroups@2015-08-01' = {
  parent: namespaceName_eventHubName
  name: consumerGroupName
  properties: {}
}

resource sqlServerName 'Microsoft.Sql/servers@2014-04-01-preview' = {
  location: resourceGroup().location
  name: sqlServerName_var
  properties: {
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqlAdministratorLoginPassword
    version: '12.0'
  }
  tags: {
    displayName: 'SqlServer'
  }
}

resource sqlServerName_databasedwName 'Microsoft.Sql/servers/databases@2015-01-01' = {
  parent: sqlServerName
  name: '${databasedwName}'
  location: resourceGroup().location
  tags: {
    displayName: 'Database'
  }
  properties: {
    edition: databasedwEdition
    collation: databaseCollation
  }
}

resource sqlServerName_AllowAllMicrosoftAzureIps 'Microsoft.Sql/servers/firewallrules@2014-04-01' = {
  parent: sqlServerName
  name: 'AllowAllMicrosoftAzureIps'
  location: resourceGroup().location
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}

resource streamAnalyticsJobName_resource 'Microsoft.StreamAnalytics/StreamingJobs@2016-03-01' = {
  name: streamAnalyticsJobName
  location: resourceGroup().location
  properties: {
    sku: {
      name: 'Standard'
    }
    outputErrorPolicy: 'Stop'
    eventsOutOfOrderPolicy: 'Adjust'
    eventsOutOfOrderMaxDelayInSeconds: 0
    eventsLateArrivalMaxDelayInSeconds: 5
    dataLocale: 'en-US'
    inputs: []
    transformation: {
      name: 'SwiftSampleData'
      properties: {
        streamingUnits: numberOfStreamingUnits
        query: 'SELECT\r\n    *\r\nINTO\r\n    [YourOutputAlias]\r\nFROM\r\n    [YourInputAlias]'
      }
    }
  }
}

resource streamAnalyticsJobName2_resource 'Microsoft.StreamAnalytics/StreamingJobs@2016-03-01' = {
  name: streamAnalyticsJobName2
  location: resourceGroup().location
  properties: {
    sku: {
      name: 'Standard'
    }
    outputErrorPolicy: 'Stop'
    eventsOutOfOrderPolicy: 'Adjust'
    eventsOutOfOrderMaxDelayInSeconds: 0
    eventsLateArrivalMaxDelayInSeconds: 5
    dataLocale: 'en-US'
    inputs: []
    transformation: {
      name: 'Transformation'
      properties: {
        streamingUnits: numberOfStreamingUnits
        query: 'SELECT\r\n    *\r\nINTO\r\n    [YourOutputAlias]\r\nFROM\r\n    [YourInputAlias]'
      }
    }
  }
}

output NamespaceConnectionString string = listkeys(authRuleResourceId, apiVersion).primaryConnectionString
output SharedAccessPolicyPrimaryKey string = listkeys(authRuleResourceId, apiVersion).primaryKey
output sqlServerFqdn string = sqlServerName.properties.fullyQualifiedDomainName
output databaseName string = databaseName