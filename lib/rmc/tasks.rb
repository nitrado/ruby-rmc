module RMC

  class Tasks

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def list_tasks(query=nil)
      @connection.version = 2
      response = @connection.request(
          url: "/tasks#{query ? "?query=\"#{query}\"" : ''}"
      )

      tasks = []
      response['tasks'].each do |_data|
        tasks << RMC::Item::Task.new(@connection, _data)
      end

      tasks
    end

  end

end