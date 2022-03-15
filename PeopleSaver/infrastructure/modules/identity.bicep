
param name string
param location string = resourceGroup().location

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: name
  location: location
}

// outputs
output resourceId string = identity.id
output objectId string = identity.properties.principalId
output clientId string = identity.properties.clientId
