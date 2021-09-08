// Create Azure Databricks workspace

param workspaceName string
@allowed([
  'standard'
  'premium'
])

param pricingTier string = 'standard'
param location string = resourceGroup().location

var managedResourceGroupName = 'databricks-ani-rg-${workspaceName}'


resource myDataBricks 'Microsoft.Databricks/workspaces@2018-04-01' = {
  name: workspaceName
  location: location
  sku: {
    name: pricingTier
  }
  properties:{
   managedResourceGroupId: '${subscription().id}/resourceGroups/${managedResourceGroupName}'
  }
   

  
}

output workspace object = myDataBricks
