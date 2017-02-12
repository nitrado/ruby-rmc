# Add Servers

This guide shows you how to add Storage and Backup servers.

## Add Storage Server

This example adds a HPE 3PAR StoreServ to RMC.

```ruby
require 'rmc'

connection = RMC::Connection.new('https://rmc.domain.local', 'Admin', 'MySpecialPassword')
connection.logger.level = Logger::DEBUG

storage_systems = RMC::StorageSystems.new(connection)

storage_systems.create_system(
  ipHostname: '192.168.0.10',
  username: '3paradm',
  password: 'XXXXXXXXXXX',
  deviceType: RMC::StorageSystems::TYPE_STORESERV,
)
```

## Add Backup Server

This example adds a StoreOnce VSA Server to RMC.

```ruby
require 'rmc'

connection = RMC::Connection.new('https://rmc.domain.local', 'Admin', 'MySpecialPassword')
connection.logger.level = Logger::DEBUG

backup_systems = RMC::BackupSystems.new(connection)

backup_systems.create_system(
  ipHostname: '192.168.0.11',
  username: 'Admin',
  password: 'admin',
)
```

