module RMC

  class SnapshotSets

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def list_sets(query=nil)
      response = @connection.request(
          url: "/snapshot-sets#{query ? "?query=\"#{query}\"" : ''}"
      )

      recovery_sets = []
      response['snapshotSets'].each do |_data|
        recovery_sets << RMC::Item::SnapshotSet.new(@connection, _data)
      end

      recovery_sets
    end

    def get_set(id)
      response = @connection.request(
          url: "/snapshot-sets/#{id}"
      )

      RMC::Item::SnapshotSet.new(@connection, response['snapshotSet'])
    end

    # Creates snapshots of a recovery set
    def create_set(data)
      result = @connection.request(
          url: "/snapshot-sets",
          method: :post,
          payload: {
              snapshotSet: data
          }
      )

      # Blocks async task
      result = @connection.wait_for_task(result['taskUri'].split('/').last)

      get_set(result['associatedResource']['resourceUri'].split('/').last)
    end

  end

end