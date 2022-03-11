
param serverName string
param location string
param adminLoginName string

@secure()
param adminPassword string
param adAdministrator object

resource sqlservrer 'Microsoft.Sql/servers@2021-08-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: adminLoginName
    administratorLoginPassword: adminPassword
    administrators: {
      administratorType: 'ActiveDirectory'
      principalType: 'User'
      sid: adAdministrator.objectId
      login: adAdministrator.loginName
      tenantId: tenant().tenantId
    }
  }
}
