
module RMC::Item

  class RecoverySet

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :description
    attr_reader :status
    attr_reader :createdAt

    attr_reader :snapCount
    attr_reader :removeOldestSnap

    attr_reader :backupCount
    attr_reader :removeOldestBackup

    attr_reader :volumelist
    attr_reader :volumes

    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']
      @description = data['description']
      @status = data['status']
      @createdAt = data['createdAt']

      @snapCount = data['snapCount']
      @removeOldestSnap = data['removeOldestSnap']

      @backupCount = data['backupCount']
      @removeOldestBackup = data['removeOldestBackup']

      @volumelist = data['volumelist']

      @volumes = data['volumes']

    end

    def add_volume(volume)
      response = @connection.request(
          :url => "/recovery-sets/#{@id}/add",
          :method => :put,
          :payload => {
              recoverySet: {
                  volumelist: [volume]
              }
          }
      )

      @connection.wait_for_task(response['taskUri'].split('/').last)
      true
    end

    def remove_volume(volume)
      response = @connection.request(
          :url => "/recovery-sets/#{@id}/delete",
          :method => :put,
          :payload => {
              recoverySet: {
                  volumelist: [volume]
              }
          }
      )

      @connection.wait_for_task(response['taskUri'].split('/').last)
      true
    end

    def detach_volume(volume, hostname)
      response = @connection.request(
          :url => "/recovery-sets/#{@id}/detach",
          :method => :post,
          :payload => {
              recoverySet: {
                  volumelist: [volume],
                  hostname: hostname
              }
          }
      )

      @connection.wait_for_task(response['taskUri'].split('/').last)
      true
    end

    def attach_volume(volume, hostname)
      response = @connection.request(
          :url => "/recovery-sets/#{@id}/attach",
          :method => :post,
          :payload => {
              recoverySet: {
                  volumelist: [volume],
                  hostname: hostname
              }
          }
      )

      @connection.wait_for_task(response['taskUri'].split('/').last)
      true
    end

    def delete
      @connection.request(
          :url => "/recovery-sets/#{@id}",
          :method => :delete,
      )
    end

  end

end