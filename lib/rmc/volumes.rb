module RMC

  class Volumes

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def list_volumes(storage_system_id)
      response = @connection.request(
          url: "/volume?query=\"storageSystemId EQ '#{storage_system_id}'\"",
      )

      volumes = []
      response['storageSystem']['volumes']['members'].each do |_data|
        volumes << RMC::Item::Volume.new(@connection, _data)
      end

      volumes
    end

  end

end