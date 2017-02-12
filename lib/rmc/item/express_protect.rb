
module RMC::Item

  class ExpressProtect

    attr_accessor :connection

    attr_reader :id
    attr_reader :name

    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']

    end

    def delete
      @connection.request(
          :url => "/backup-sets/#{@id}",
          :method => :delete,
      )
    end

  end

end