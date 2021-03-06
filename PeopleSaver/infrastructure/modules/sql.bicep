
param serverName string
param location string
param databases array

module createdServer 'sqlserver.bicep' = {
  name: 'deployServer-${serverName}'
  params: {
    serverName: serverName
    location: location
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

// outputs
output fqdn string = createdServer.outputs.fqdn
output databaseName string = createdDatabases[0].outputs.databaseName
