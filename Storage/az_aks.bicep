
param clusterName string

resource myAKS  'Microsoft.Kubernetes/connectedClusters@2021-03-01' = {
  name: clusterName
  location: 'southeast asia'
  identity: {
    type: 'SystemAssigned'
  }
  properties:{
    agentPublicKeyCertificate: 'None'
  }
}

