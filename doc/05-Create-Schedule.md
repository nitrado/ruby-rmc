## Create a Schedule

After we've created our first Recovery Set we want to create automatic Backups of each Volume inside the Recovery Set.
So we need to create a Schedule entry for our RMC.

We create a Schedule entry called 'schedulename' and we define that we want to create a Backup each day at 00:00 o'clock.

The backup (Express Protect) entry should be called 'backupname' and we define our pre-created Backup Policy.
The snapshots should be called 'snapshotname'.

Now the RMC will create each day a Backup from our 3PAR StoreServ to our StoreOnce (VSA) Server (by backupPolicyId).

```ruby
require 'rmc'

connection = RMC::Connection.new('https://rmc.domain.local', 'Admin', 'MySpecialPassword')
connection.logger.level = Logger::DEBUG

scheduler = RMC::Scheduler.new(connection)

scheduler.create_schedule(
    name: 'schedulename',
    description: 'scheduledesc',
    resourceCategory: RMC::Scheduler::RESOURCE_CATEGORY_BACKUPS,
    frequency: RMC::Scheduler::FREQUENCY_DAILY,
    recur: 1,
    startTime: '0:00:00',
    resourceList: [
        {
            resourceUri: "#{connection.url}/backups-sets",
            requestInput: {
                backupSet: {
                    name: 'backupname',
                    description: 'backupdesc',
                    backupPolicyId: '365e792b-30be-48a1-b3a7-6c94bce81032',
                    recoverySetId: 'c4a32388-d0f0-48bc-ac9a-c1ed64f16def',
                    snapshotSetName: 'snapshotname',
                    snapshotSetDescription: 'snapshotdesc',
                }
            }
        }
    ]
)
```

