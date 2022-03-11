
param serverName string
param location string
param adminLoginName string

@secure()
param adminPassword string
param databases array
param adAdministrator object

module createdServer 'sqlserver.bicep' = {
  name: 'deployServer-${serverName}'
  params: {
    serverName: serverName
    location: location
    adminLoginName: adminLoginName
    adminPassword: adminPassword
    adAdministrator: adAdministrator
  }
}

module createdDatabases 'sqlserverdb.bicep' = [for database in databases: {
  name: 'deployDatabase-${database.name}'
  params: {
    serverName: serverName
    location: location
    database: database
  }

  dependsOn: [
    createdServer
  ]
}]
