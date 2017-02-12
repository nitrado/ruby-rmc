module RMC

  class ExpressProtects

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def list_sets
      response = @connection.request(
          url: "/backup-sets",
      )

      backup_sets = []
      response['backupSets'].each do |_data|
        backup_sets << RMC::Item::ExpressProtect.new(@connection, _data)
      end

      backup_sets
    end

    def get_set(id)
      response = @connection.request(
          url: "/backup-sets/#{id}",
      )

      RMC::Item::ExpressProtect.new(@connection, response['backupSet'])
    end

    def create_set(data)
      response = @connection.request(
          url: "/backup-sets",
          method: :post,
          payload: {
              recoverySet: data
          }
      )

      RMC::Item::ExpressProtect.new(@connection, response['backupSet'])
    end

  end

end