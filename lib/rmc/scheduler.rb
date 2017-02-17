module RMC

  class Scheduler

    FREQUENCY_ONETIME = 'onetimeonly'
    FREQUENCY_BY_MINUTES = 'by minutes'
    FREQUENCY_HOURLY = 'hourly'
    FREQUENCY_DAILY = 'daily'
    FREQUENCY_WEEKLY = 'weekly'
    FREQUENCY_MONTHLY = 'monthly'
    FREQUENCY_YEARLY = 'yearly'

    RESOURCE_CATEGORY_SCRIPT = 'script'
    RESOURCE_CATEGORY_SNAPSHOTS = 'script'
    RESOURCE_CATEGORY_BACKUPS = 'backup-sets'

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def list_schedules(query=nil)
      response = @connection.request(
        url: "/schedule-jobs#{query ? "?query=\"#{query}\"" : ''}"
      )

      schedules = []
      response['schedules'].each do |_data|
        schedules << RMC::Item::Schedule.new(@connection, _data)
      end

      schedules
    end

    def get_schedule(id)
      response = @connection.request(
          url: "/schedule-jobs/#{id}"
      )

      RMC::Item::Schedule.new(@connection, response['schedule'])
    end

    def create_schedule(data)
      response = @connection.request(
          url: "/schedule-jobs",
          payload: {
              schedule: data
          },
          method: :post
      )

      get_schedule(response['schedule']['id'])
    end

  end

end