
module RMC::Item

  class Volume

    attr_accessor :connection

    attr_reader :name
    attr_reader :sizeMiB

    def initialize(connection, data)

      @connection = connection

      @name = data['name']
      @status = data['sizeMiB']

    end

  end

end