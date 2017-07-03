
module RMC::Item

  class ExpressProtect

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :status
    attr_reader :backups
    attr_reader :createdAt
    attr_reader :recoverySetId

    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']
      @status = data['status']
      @backups = data['backups']
      @createdAt = data['createdAt']
      @recoverySetId = data['recoverySetId']

    end

    def update(data)
      @connection.request(
          :url => "/backup-sets/#{@id}",
          :method => :put,
          :payload => {
              backupSet: data
          }
      )
    end

    def delete
      @connection.request(
          :url => "/backup-sets/#{@id}",
          :method => :delete,
      )
    end

    def restore_to_parent_volumes
      response = @connection.request(
          :url => "/backup-sets/#{@id}/restore",
          :method => :post
      )

      @connection.wait_for_task(response['taskUri'].split('/').last)
    end

    def restore_to_recovery_set(id)
      response = @connection.request(
          :url => "/backup-sets/#{@id}/restore",
          :payload => {
              backupSet: {
                  restoreRecoverysetId: id
              }
          },
          :method => :post
      )

      @connection.wait_for_task(response['taskUri'].split('/').last)
    end

  end

end