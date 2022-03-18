
param keyVaultName string
param location string
param roleAssignments array = []

resource vault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: tenant().tenantId
    enableRbacAuthorization: true
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

var supportedRoles = {
  'Key Vault Secret User': '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/4633458b-17de-408a-b874-0445c86b69e6'
}

resource assignments 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = [for (roleAssignment, indx) in roleAssignments: {
  name: guid(subscription().id, roleAssignment.userId, roleAssignment.roleName)
  properties: {
    roleDefinitionId: supportedRoles[roleAssignment.roleName]
    principalId: roleAssignment.userId
  }
}]

// outputs
output vaultName string = keyVaultName
output vaultId string = vault.id
