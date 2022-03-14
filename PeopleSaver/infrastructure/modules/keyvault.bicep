
param keyVaultName string
param location string

@minLength(1)
param accessPolicies array

var accessPoliciesObject = [for policy in accessPolicies: {
    objectId: policy.objectId
    tenantId: tenant().tenantId
    permissions: {
      secrets: policy.secretPermissions
    }
  }]

resource vault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: tenant().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    accessPolicies: accessPoliciesObject
  }
}
