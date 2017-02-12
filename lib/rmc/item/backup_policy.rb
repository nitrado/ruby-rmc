
module RMC::Item

  class BackupPolicy

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :description
    attr_reader :status
    attr_reader :createdAt

    attr_reader :transportType
    attr_reader :blockSize

    attr_reader :backupSystemId
    attr_reader :storeName
    attr_reader :dedupeMode

    attr_reader :backupExpiry
    attr_reader :backupRetention


    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']
      @description = data['description']
      @status = data['status']
      @createdAt = data['createdAt']

      @transportType = data['transportType']
      @blockSize = data['blockSize']

      @backupSystemId = data['backupSystemId']
      @storeName = data['storeName']
      @dedupeMode = data['dedupeMode']

      @backupExpiry = data['backupExpiry']
      @backupRetention = data['backupRetention']

    end

    def delete
      request(
          :url => "/backup-policies/#{@id}",
          :method => :delete,
      )
    end

  end

end