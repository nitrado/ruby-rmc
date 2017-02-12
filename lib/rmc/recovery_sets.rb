module RMC

  class RecoverySets

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def list_sets(query=nil)
      response = @connection.request(
          url: "/recovery-sets#{query ? "?query=\"#{query}\"" : ''}"
      )

      recovery_sets = []
      response['recoverySets'].each do |_data|
        recovery_sets << RMC::Item::RecoverySet.new(@connection, _data)
      end

      recovery_sets
    end

    def get_set(id)
      response = @connection.request(
          url: "/recovery-sets/#{id}"
      )

      RMC::Item::RecoverySet.new(@connection, response['recoverySet'])
    end

    def create_set(data)
      response = @connection.request(
          url: "/recovery-sets",
          method: :post,
          payload: {
              recoverySet: data
          }
      )

      # Blocks async task
      response = @connection.wait_for_task(response['taskUri'].split('/').last)

      get_set(response['associatedResource']['resourceUri'].split('/').last)
    end

  end

end