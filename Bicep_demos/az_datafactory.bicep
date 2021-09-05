// Create Azure Data Factory using Bicep

resource myADF 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: 'myadfanidemo'
  location: 'southeast asia'
  identity:{
    type: 'SystemAssigned'
  }
  properties: {
    publicNetworkAccess:'Enabled'
    repoConfiguration: {
      type: 'FactoryGitHubConfiguration'
      collaborationBranch: 'main'
      rootFolder: 'dataFactory'
      repositoryName: 'adfdemo'
      accountName: 'imcuteani'
    }
  }
}

resource myadflinkedService 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  name: 'adflinkedservice/'
  location: myADF.location
  properties: {
    type: 'AzureBlobStorage'
    typeProperties: {
    }
  }
 dependsOn:[
   myADF
 ]
}

resource myADFTriggers 'Microsoft.DataFactory/factories/triggers@2018-06-01'= {
  name: 'adfTriggerDemo/'
  properties: {
    type: 'BlobTrigger'
    typeProperties: {
      folderPath: '/'
      linkedService: {
        referenceName: 'adflinkedservice/'
        type:  'LinkedServiceReference'
      }
      maxConcurrency: 2
    }
  }
  dependsOn:[
    myadflinkedService
  ]
}

resource myADFActivity 'Microsoft.DataFactory/factories/datasets@2018-06-01'= {
  name: 'ADFdataset/'
  properties: {
    type: 'AzureBlob'
    linkedServiceName: {
      referenceName: 'adflinkedservice/'
      type: 'LinkedServiceReference'
    }
  }
  dependsOn:[
    myADF
  ]
}

resource myADFPipeline 'Microsoft.DataFactory/factories/pipelines@2018-06-01' = {
  name:'adfpipelinedemo/'
   properties: {
    description: 'The Azure Data Factory Pipeline'
    activities:[]
     concurrency:2
  }
  dependsOn:[
    myADF
  ]
}
