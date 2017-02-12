module RMC

  class StorageSystems

    attr_reader :connection

    TYPE_STORESERV = 'STORESERV'
    TYPE_STOREVIRTUAL = 'STOREVIRTUAL'

    def initialize(connection)
      @connection = connection
    end

    def list_systems
      response = @connection.request(
          url: "/storage-systems",
      )

      storage_systems = []
      response['storageSystems'].each do |_data|
        storage_systems << RMC::Item::StorageSystem.new(@connection, _data)
      end

      storage_systems
    end

    def get_system(id)
      response = @connection.request(
          url: "/storage-systems/#{id}",
      )

      RMC::Item::StorageSystem.new(@connection, response['storageSystem'])
    end

    def create_system(data)
      response = @connection.request(
          url: "/storage-systems",
          method: :post,
          payload: {
              storageSystem: data
          }
      )

      get_system(response['storageSystem']['id'])
    end

  end

end