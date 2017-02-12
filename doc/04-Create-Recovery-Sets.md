# Create a Recovery Set

A Recovery Set is a group of Storage Volumes. For example we create a Recovery Set called Test-Set and we will add the first Storage System. In our case it's a HPE 3PAR StoreServ.
 
We add a single Volume called osv-l5nF3kDJRhuFE0szhimwIQ, that's a OpenStack Cinder Volume.

Also we define that this Recovery Set should always have a maximum of 1 Snapshot and 3 Backups for each Volume.
If there will be created more, the oldest one will be deleted automatically.

```ruby
require 'rmc'

connection = RMC::Connection.new('https://rmc.domain.local', 'Admin', 'MySpecialPassword')
connection.logger.level = Logger::DEBUG

recovery_sets = RMC::RecoverySets.new(connection)

recovery_sets.create_set(
    name: "Test-Set",
    description: "Test Description",
    poolId: storages.list_systems.first.get_pools.first.id,
    volumelist: ['osv-l5nF3kDJRhuFE0szhimwIQ'],
    snapCount: 1,
    removeOldestSnap: true,
    backupCount: 3,
    removeOldestBackup: true,
)
```