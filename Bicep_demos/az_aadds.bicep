resource myADDS 'Microsoft.AAD/domainServices@2020-01-01' = {
  name: 'myadds-ani'
  location: 'southeast asia'
  properties: {
    sku:'basic'
    ldapsSettings:{
      externalAccess:'Enabled'
    }
    filteredSync:'Disabled'
    domainSecuritySettings:{
      syncOnPremPasswords:'Enabled'
      syncKerberosPasswords:'Enabled'
      syncNtlmPasswords:'Disabled'
    }
    notificationSettings:{
      notifyDcAdmins:'Enabled'
      notifyGlobalAdmins:'Disabled'
    }
  }
}

output myADDS_id string = myADDS.id
output myADDS_location string = myADDS.location
 