
targetScope = 'resourceGroup'

param baseName string
param location string
param appSettings array

resource plan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'plan-${baseName}'
  location: location
  sku: {
    name: 'S1'
    tier: 'Standard'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource app 'Microsoft.Web/sites@2021-02-01' = {
  name: 'app-${baseName}'
  location: location
  properties: {
    serverFarmId: plan.id
    httpsOnly: false
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|6.0'
      alwaysOn: true
      appSettings: appSettings
    }
  }
}
