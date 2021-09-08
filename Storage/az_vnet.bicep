param vNetSettings object = {
  name: 'aniVNet1'
  location: 'southeast asia'
  addressPrefixes: [
    {
      name: 'firstPrefix'
      addressPrefix: '10.0.0.0/16'
    }
  ]
  subnets: [
    {
      name: 'subnet_1'
      addressPrefix: '10.0.1.0/24'
    }
    {
      name: 'subnet_2'
      addressPrefix: '10.0.2.0/24'
    }
  ]
}


resource my_vnet 'Microsoft.Network/virtualNetworks@2019-06-01'= {
  name : vNetSettings.name
  location:vNetSettings.location
  properties:{
    addressSpace: {
      addressPrefixes:[
        vNetSettings.addressPrefixes[0].addressPrefix
      ]
    }
    subnets: [
      {
      name: vNetSettings.subnets[0].name
      properties: {
        addressPrefix: vNetSettings.subnets[0].addressPrefix
      }
    }
    {
    name: vNetSettings.subnets[1].name
    properties: {
      addressPrefix: vNetSettings.subnets[1].addressPrefix
    }
  }
    ]
  }
}
