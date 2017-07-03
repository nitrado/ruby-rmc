
module RMC::Item

  class ExpressProtect

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :status
    attr_reader :createdAt

    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']
      @status = data['status']
      @createdAt = data['createdAt']

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