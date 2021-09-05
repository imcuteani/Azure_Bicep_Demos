resource myAZVNET 'Microsoft.Network/virtualNetworks@2020-05-01' = {
  name: 'myVNETdemo'
  location: 'southeast asia'
  properties: {
    addressSpace:{
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet_1'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'subnet_2'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
    
  }
}
