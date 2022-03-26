
param serverName string
param location string

resource sqlservrer 'Microsoft.Sql/servers@2021-08-01-preview' = {
  name: serverName
  location: location
  properties: {
  }
}

resource firewall 'Microsoft.Sql/servers/firewallRules@2021-08-01-preview' = {
  name: 'AllowAzureServices'
  parent: sqlservrer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

// outputs
output fqdn string = sqlservrer.properties.fullyQualifiedDomainName
