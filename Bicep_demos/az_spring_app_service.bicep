// Create Azure App Service Resource 

resource myApp 'Microsoft.AppPlatform/Spring/apps@2020-07-01' = {
  name: 'mySpring-aniapp/'
  location: 'southeast asia'
  identity:{
    type: 'SystemAssigned'
  }
  properties: {
    activeDeploymentName: 'springappdeploy'
    temporaryDisk:{
      mountPath: '/tmp'
      sizeInGB: 64
    }
    persistentDisk:{
      mountPath:'/'
      sizeInGB:1024
    }
    public:true
    httpsOnly:true
    fqdn:'sprintbootani.azurewebsites.net'
    
  }
}

output mySprintBootApp string = myApp.properties.activeDeploymentName
output mySprintBootApploc string = myApp.location
output mySpringBootApp_status string = myApp.properties.provisioningState
output mySpringBootApp_url string = myApp.properties.url
