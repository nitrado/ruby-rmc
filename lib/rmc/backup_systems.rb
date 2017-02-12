module RMC

  class BackupSystems

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def list_systems
      response = @connection.request(
          url: "/backup-systems",
      )

      backup_systems = []
      response['backupSystems'].each do |_data|
        backup_systems << RMC::Item::BackupSystem.new(@connection, _data)
      end

      backup_systems
    end

    def get_system(id)
      response = @connection.request(
          url: "/backup-systems/#{id}",
      )

      RMC::Item::BackupSystem.new(@connection, response['backupSystem'])
    end

    def create_system(data)
      response = @connection.request(
          url: "/backup-systems",
          method: :post,
          payload: {
              backupSystem: data
          }
      )

      get_system(response['backupSystem']['id'])
    end

  end

end