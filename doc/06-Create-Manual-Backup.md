# Create manual backup

If you won't wait until your Schedule creates a Backup you can trigger it manual.

This sample shows the creation of a manual Backup Set (Express Protect) for a specific Recovery Set to a specific Backup Policy.
The name for the needed snapshots are also provided.

## Good to know

If you have a Recovery Set with the maximum of 3 Backups per Volume and you have 3 existing scheduled Backups, one of the Scheduled Backups will be deleted to create this manual one.

```ruby
require 'rmc'

connection = RMC::Connection.new('https://rmc.domain.local', 'Admin', 'MySpecialPassword')
connection.logger.level = Logger::DEBUG

express_protects = RMC::ExpressProtects.new(connection)
express_protects.create_set(
  backupPolicyId: '365e792b-30be-48a1-b3a7-6c94bce81032',
  description: 'My-Manual-Backup',
  name: 'My-Manual-Backup',
  snapshotSetName: 'My-Manual-Snapshot-Set',
  snapshotSetDescription: 'My-Manual-Snapshot-Set',
  recoverySetId: 'c4a32388-d0f0-48bc-ac9a-c1ed64f16def'
)

```

