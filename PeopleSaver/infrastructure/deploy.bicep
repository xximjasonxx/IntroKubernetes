
targetScope = 'subscription'

param location string = deployment().location
param adminLoginName string

@secure()
param adminPassword string

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
    adminLoginName: adminLoginName
    adminPassword: adminPassword
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
  }
}

// get shared key vault reference
resource dbInfoKeyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' existing = {
  name: 'kv-shared-jx01'
  scope: resourceGroup('rg-shared')
}

module keyVault 'modules/keyvault.bicep' = {
  name: 'keyVaultDeploy'
  scope: resourceGroup(resourceGroupName)
  params: {
    keyVaultName: 'kv-k8s-sampleapp'
    location: location
    accessPolicies: [
      {
        objectId: appService.outputs.appServiceIdentityPrincipalId
        secretPermissions: [
          'get'
          'list'
        ]
      }
    ]
  }
}

module connectionStringSecret 'modules/connectionStringSecret.bicep' = {
  name: 'connectionStringSecretDeploy'
  scope: resourceGroup(resourceGroupName)
  params: {
    dbUserName: dbInfoKeyVault.getSecret('k8sSampleDbLogin')
    dbPassword: dbInfoKeyVault.getSecret('k8sSampleDbPassword')
    serverDomain: sqlserver.outputs.fqdn
    databaseName: sqlserver.outputs.databaseName
    targetKeyVaultName: 'kv-k8s-sampleapp'
    targetKeyVaultSecretName: 'ConnectionString'
  }
}
