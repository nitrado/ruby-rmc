
module RMC::Item

  class StorageSystem

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :status

    attr_reader :serialNumber
    attr_reader :firmwareVersion
    attr_reader :deviceType
    attr_reader :ipHostname
    attr_reader :sytemId

    def initialize(connection, data)

      @connection = connection

      @id = data['id']
      @name = data['name']
      @status = data['status']

      @serialNumber = data['serialNumber']
      @firmwareVersion = data['firmwareVersion']
      @deviceType = data['deviceType']
      @ipHostname = data['ipHostname']
      @sytemId = data['systemId']

      @configuredProtocols = data['configuredProtocols']
    end

    def get_pools
      pools = []
      @configuredProtocols.each do |storage_pool|
        response = @connection.request(
            url: "/storage-pools/#{storage_pool['poolId']}"
        )
        pools << RMC::Item::StoragePool.new(@connection, response['storagePool'])
      end

      pools
    end

    def get_volumes
      response = @connection.request(
          url: "/volume?query=\"storageSystemId EQ '#{@id}'\"",
      )

      volumes = []
      response['storageSystem']['volumes']['members'].each do |_data|
        volumes << RMC::Item::Volume.new(@connection, _data)
      end

      volumes
    end

    def delete
      @connection.request(
          :url => "/storage-systems/#{@id}",
          :method => :delete,
      )
    end

  end

end