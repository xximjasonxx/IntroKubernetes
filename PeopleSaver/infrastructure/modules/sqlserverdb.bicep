
param serverName string
param location string
param database object

// determine the bytes
var ranges = {
  'KB': 1024
  'MB': 1024 * 1024
  'GB': 1024 * 1024 * 1024
  'TB': 1024 * 1024 * 1024 * 1024
}

resource createdDatabase 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  name: '${serverName}/${database.name}'
  location: location
  sku: {
    name: database.sku.name
    tier: database.sku.name
    capacity: database.sku.capacity
  }
  properties: {
    maxSizeBytes: int(substring(database.maxSize, 0, length(database.maxSize) - 2)) * ranges[substring(database.maxSize, length(database.maxSize)-2)]
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
  }
}

// outputs
output databaseName string = createdDatabase.name
