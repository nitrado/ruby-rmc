
module RMC::Item

  class StoragePool

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :status
    attr_reader :createdAt

    attr_reader :storageSystemId
    attr_reader :protocol

    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']
      @status = data['status']
      @createdAt = data['createdAt']


      @storageSystemId = data['storageSystemId']
      @protocol = data['protocol']
    end

    def get_hosts
      response = @connection.request(
          :url => "/storage-pools/#{@id}/hosts",
      )

      hosts = []
      response['hosts'].each do |_data|
        hosts << RMC::Item::Host.new(@connection, _data)
      end

      hosts
    end

    def delete
      @connection.request(
          :url => "/storage-pools/#{@id}",
          :method => :delete,
      )
    end

  end

end