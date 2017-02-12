# Add Backup Policy

Add a Backup Policy with a specific Backup Server ID and a storeName. The storeName defines the name of the remote Storage Pool. VSA creates by default one Pool called Store_1.

The Backup Policy can be used in Schedules.

```ruby
require 'rmc'

connection = RMC::Connection.new('https://rmc.domain.local', 'Admin', 'MySpecialPassword')
connection.logger.level = Logger::DEBUG

backup_policies = RMC::BackupPolicies.new(connection)

backup_policies.create_policy(
  name: 'My-Test-Policy',
  backupSystemId: '9d26a0bc-6fd9-4b64-9f31-4904fdd519b4',
  storeName: 'Store_1',
  transportType: 'ISCSI',
  username: 'Admin',
  password: 'admin'
)
```