
module RMC::Item

  class Host

    attr_accessor :connection

    attr_reader :name
    attr_reader :domain

    attr_reader :iqns

    def initialize(connection, data)

      @connection = connection

      @name = data['name']
      @domains = data['domain']

      @iqns = data['iqns']

    end

  end

end