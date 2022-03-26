
targetScope = 'subscription'

param location string = deployment().location
param databaseUsername string

@secure()
param databasePassword string

var resourceGroupName = 'rg-k8s-sampleapp'

module rg 'modules/resource-group.bicep' = {
  name: 'resourceGroupDeploy'
  params: {
    name: resourceGroupName
    location: location
  }
}

module sqlserver 'modules/sql.bicep' = {
  name: 'sqlserverDeploy'
  scope: resourceGroup(resourceGroupName)
  params: {
    serverName: 'sqlserver-k8s-sampleapp'
    location: location
    databases: [
      {
        name: 'peopleDatabase'
        sku: {
          name: 'Standard'
          capacity: 20
        }
        maxSize: '30GB'
      }
    ]
  }

  dependsOn: [
    rg
  ]
}

module appService 'modules/appservice.bicep' = {
  name: 'appServiceDeploy'
  scope: resourceGroup(resourceGroupName)
  params: {
    baseName: 'k8s-sampleapp'
    location: location
    appSettings: [
      {
        name: 'ConnectionString'
        value: 'Server=tcp:${sqlserver.outputs.fqdn},1433;Initial Catalog=${sqlserver.outputs.databaseName};Persist Security Info=False;User ID=${databaseUsername};Password=${databasePassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
      }
    ]
  }
}
