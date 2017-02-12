
module RMC::Item

  class BackupSystem

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :status

    attr_reader :serialNumber
    attr_reader :firmwareVersion
    attr_reader :deviceType
    attr_reader :ipHostname
    attr_reader :state

    def initialize(connection, data)

      @connection = connection

      @id = data['id']
      @name = data['name']
      @status = data['status']

      @serialNumber = data['serialNumber']
      @firmwareVersion = data['firmwareVersion']
      @deviceType = data['deviceType']
      @ipHostname = data['ipHostname']
      @state = data['state']

    end

    def delete
      request(
          :url => "/backup-systems/#{@id}",
          :method => :delete,
      )
    end

  end

end