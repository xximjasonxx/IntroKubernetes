
param serverName string
param location string
param adminLoginName string

@secure()
param adminPassword string

resource sqlservrer 'Microsoft.Sql/servers@2021-08-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: adminLoginName
    administratorLoginPassword: adminPassword
  }
}

// outputs
output fqdn string = sqlservrer.properties.fullyQualifiedDomainName
