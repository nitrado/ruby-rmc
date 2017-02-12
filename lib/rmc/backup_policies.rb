module RMC

  class BackupPolicies

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def list_policies
      response = @connection.request(
          url: "/backup-policies"
      )

      backup_policies = []
      response['backupPolicies'].each do |_data|
        backup_policies << RMC::Item::BackupPolicy.new(@connection, _data)
      end

      backup_policies
    end

    def get_policy(id)
      response = @connection.request(
          url: "/backup-policies/#{id}"
      )

      RMC::Item::BackupPolicy.new(@connection, response['backupPolicy'])
    end

    def create_policy(data)
      result = @connection.request(
          url: "/backup-policies",
          method: :post,
          payload: {
              backupPolicy: data
          }
      )

      # Blocks async task
      result = @connection.wait_for_task(result['taskUri'].split('/').last)

      get_policy(result['associatedResource']['resourceUri'].split('/').last)
    end

  end

end