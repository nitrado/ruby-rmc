module RMC

  class ExpressProtects

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def list_sets(query=nil)
      response = @connection.request(
          url: "/backup-sets#{query ? "?query=\"#{query}\"" : ''}"
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

    def create_set_async(data)
      @connection.request(
          url: "/backup-sets",
          method: :post,
          payload: {
              backupSet: data
          }
      )
    end

    def create_set(data)
      response = create_set_async(data)

      # Blocks async task
      response = @connection.wait_for_task(response['taskUri'].split('/').last)

      get_set(response['associatedResource']['resourceUri'].split('/').last)
    end

  end

end