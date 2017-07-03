
module RMC::Item

  class Task

    attr_accessor :connection

    attr_reader :id
    attr_reader :name

    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']
    end

    def delete
      @connection.version = 1
      @connection.request(
          :url => "/tasks/#{@id}",
          :method => :delete,
      )
    end

  end

end