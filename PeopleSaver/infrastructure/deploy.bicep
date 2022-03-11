
targetScope = 'subscription'

param location string = deployment().location
param adminLoginName string

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
    adminLoginName: 'azureuser'
    adminPassword: 'P@ssw0rd01!'
    adAdministrator: {
      objectId: 'f1a2c6f4-c875-4d5c-b25c-2cf5e9a6ad84'
      loginName: adminLoginName
    }
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
