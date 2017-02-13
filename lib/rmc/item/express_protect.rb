
module RMC::Item

  class ExpressProtect

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :status
    attr_reader :createdAt

    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']
      @status = data['status']
      @createdAt = data['createdAt']

    end

    def delete
      @connection.request(
          :url => "/backup-sets/#{@id}",
          :method => :delete,
      )
    end

  end

end