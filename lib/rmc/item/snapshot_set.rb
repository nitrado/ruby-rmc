
module RMC::Item

  class SnapshotSet

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :status
    attr_reader :createdAt

    attr_reader :appType
    attr_reader :recoverySetId

    attr_reader :snapExpiry
    attr_reader :snapRetention

    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']
      @status = data['status']
      @createdAt = data['createdAt']

      @appType = data['appType']
      @recoverySetId = data['recoverySetId']

      @snapExpiry = data['snapExpiry']
      @snapRetention = data['snapRetention']
    end

    def delete
      request(
          :url => "/snapshot-sets/#{@id}",
          :method => :delete,
      )
    end

  end

end