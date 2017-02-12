
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

    def delete
      request(
          :url => "/storage-pools/#{@id}",
          :method => :delete,
      )
    end

  end

end