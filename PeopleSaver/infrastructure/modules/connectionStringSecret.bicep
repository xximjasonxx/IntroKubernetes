
@secure()
param dbUserName string

@secure()
param dbPassword string

param serverDomain string
param databaseName string

param targetKeyVaultName string
param targetKeyVaultSecretName string

resource connectionStringSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  name: '${targetKeyVaultName}/${targetKeyVaultSecretName}'
  properties: {
    value: 'Server=tcp:${serverDomain},1433;Initial Catalog=${databaseName};Persist Security Info=False;User ID=${dbUserName};Password=${dbPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
  }
}
